/**
 * @file scheduler.ts
 * @description Step C of the optimizer pipeline: temporal scheduling and full pipeline orchestration.
 *
 * ─── Responsibilities ───────────────────────────────────────────────────────
 *
 *  `buildItinerary()`       — Takes the TSP-ordered location list and maps each
 *                             stop to a concrete HH:MM arrival/departure time
 *                             within valid daily windows. Overflowing stops are
 *                             bumped to the next day automatically.
 *
 *  `runOptimizerPipeline()` — The single entry-point called by the API route.
 *                             Orchestrates: DB fetch → scoring → TSP → scheduling.
 *
 * ─── Daily Window ───────────────────────────────────────────────────────────
 *
 *   Day start : 07:00  (420 minutes from midnight)
 *   Day end   : 20:00  (1200 minutes from midnight)
 *
 *   A stop is placed in the current day only if:
 *     (a) arrival < location.close_time   (we arrive before it closes)
 *     (b) arrival + avg_time_spent ≤ DAY_END_MINS   (we finish within the window)
 *   Otherwise the stop is deferred to the next day at 07:00 + travel time.
 *
 * ─── Hub handling ───────────────────────────────────────────────────────────
 *
 *   The BBI hub is the first AND last element in `orderedNodes` (as returned
 *   by `solveTSP`).  It is used as the daily departure anchor but is NOT
 *   listed as a named `ScheduledStop` inside any `ItineraryDay`.  The hub
 *   travel edge to the first stop of each day contributes `travelTimeFromPrev`
 *   and `distanceFromPrev` to that first stop's `ScheduledStop` object.
 */

import { query } from '@/lib/db';
import {
  Location,
  BehavioralProfile,
  TravelEdge,
  TravelMatrix,
  UserPreferences,
  ScheduledStop,
  ItineraryDay,
  OptimizedItinerary,
} from './types';
import { filterAndScore } from './scoring';
import { solveTSP, getEdgeKey } from './tsp';

// ---------------------------------------------------------------------------
// Constants
// ---------------------------------------------------------------------------

/** The time of day at which each touring day begins, in minutes from midnight.
 *  07:00 = 7 × 60 = 420 minutes. */
const DAY_START_MINS = 7 * 60; // 420

/** The time of day by which all touring must be finished, in minutes from midnight.
 *  20:00 = 20 × 60 = 1200 minutes. */
const DAY_END_MINS = 20 * 60; // 1200

// ---------------------------------------------------------------------------
// Time Utility Functions
// ---------------------------------------------------------------------------

/**
 * Converts a 24-hour time string ('HH:MM') into an integer number of minutes
 * elapsed since midnight.
 *
 * Used throughout the scheduler to do simple integer arithmetic on times
 * instead of juggling Date objects or string comparisons.
 *
 * @param time - A 24-hour time string in 'HH:MM' format, e.g. '09:30'
 * @returns    Minutes since midnight, e.g. 570 for '09:30'
 *
 * @example
 *   timeToMins('07:00') // → 420
 *   timeToMins('17:30') // → 1050
 */
export function timeToMins(time: string): number {
  const [hours, minutes] = time.split(':').map(Number);
  return hours * 60 + minutes;
}

/**
 * Converts a minute-offset since midnight back into a 'HH:MM' 24-hour string.
 *
 * The inverse of `timeToMins`.  Clamps to [00:00, 23:59] to guard against
 * overflow or underflow caused by edge cases in scheduling logic.
 *
 * @param mins - Integer minutes since midnight (e.g. 570)
 * @returns    24-hour time string, e.g. '09:30'
 *
 * @example
 *   minsToTime(420)  // → '07:00'
 *   minsToTime(1050) // → '17:30'
 */
export function minsToTime(mins: number): string {
  // Clamp to valid 24-hour range
  const clamped = Math.max(0, Math.min(mins, 23 * 60 + 59));

  const hours   = Math.floor(clamped / 60);
  const minutes = clamped % 60;

  // Zero-pad both components to ensure 'HH:MM' format
  const hh = String(hours).padStart(2, '0');
  const mm  = String(minutes).padStart(2, '0');

  return `${hh}:${mm}`;
}

// ---------------------------------------------------------------------------
// Core Scheduling Function
// ---------------------------------------------------------------------------

/**
 * Converts a TSP-ordered flat list of locations into a structured, time-aware
 * multi-day itinerary.
 *
 * PRECONDITIONS:
 *   - `orderedNodes[0]`                   is the hub (start of trip)
 *   - `orderedNodes[orderedNodes.length-1]` is the hub (end of trip, loop closed by TSP)
 *   - The hub is excluded from scheduled stops; it acts only as the day anchor.
 *
 * ALGORITHM:
 *   1. Strip the hub from the front and back.  The remaining nodes are the
 *      actual tourist stops to schedule.
 *   2. Track `currentTimeMins` (minutes from midnight) and `dayNumber`.
 *   3. For each stop:
 *       a. Compute `arrivalMins` = `currentTimeMins` + travel time from previous location.
 *       b. Check feasibility:
 *            - Arrival must be before the location's closing time.
 *            - Departure (arrival + avg_time_spent) must be ≤ DAY_END_MINS.
 *       c. If infeasible, push the stop to the NEXT day:
 *            - Bump `dayNumber`, open a new `ItineraryDay`.
 *            - Reset `currentTimeMins` to DAY_START_MINS.
 *            - Re-look up the travel leg from the hub (day's first leg).
 *            - Recompute `arrivalMins` from the hub position.
 *       d. Record the `ScheduledStop` and advance `currentTimeMins` to departure.
 *   4. After all stops are placed, compute summary totals per day and globally.
 *
 * NOTE: When a stop overflows to the next day, the travel leg is recalculated
 * from the **hub** (not from the last stop of the previous day), because each
 * day begins from Bhubaneswar (hub).  This matches the real-world pattern of
 * returning to the hotel/city centre each evening.
 *
 * @param orderedNodes - Locations in TSP-optimised order, hub first AND last
 * @param matrix       - Pre-built TravelMatrix map
 * @param hubId        - UUID of the hub Location
 * @param prefs        - User preferences (used for day count validation)
 * @returns            - Complete `OptimizedItinerary` object
 */
export function buildItinerary(
  orderedNodes: Location[],
  matrix: TravelMatrix,
  hubId: string,
  prefs: UserPreferences
): OptimizedItinerary {
  // ── Locate the hub in the ordered node list ────────────────────────────────
  const hub = orderedNodes.find(loc => loc.id === hubId);
  if (!hub) {
    throw new Error(`[scheduler] Hub id "${hubId}" not found in orderedNodes.`);
  }

  // ── Extract tourist stops (strip hub from front and back) ─────────────────
  // `solveTSP` returns: [hub, stopA, stopB, …, stopN, hub]
  // We want only: [stopA, stopB, …, stopN]
  // Slice from index 1 to length-1 (exclusive) to remove both hub bookends.
  const stops = orderedNodes.slice(1, orderedNodes.length - 1);

  // ── Initialise scheduling state ────────────────────────────────────────────
  const days: ItineraryDay[] = [];   // accumulates completed ItineraryDay objects
  let dayNumber      = 1;            // 1-based current day counter
  let currentStops: ScheduledStop[] = []; // stops accumulated for the current day
  let currentTimeMins = DAY_START_MINS;   // current clock position (minutes from midnight)
  let dayTravelMins  = 0;            // running travel time total for current day
  let dayDistanceKm  = 0;            // running distance total for current day

  // `prevLocation` tracks where we are coming FROM when computing travel legs.
  // At the start of each day, we are departing from the hub.
  let prevLocation: Location = hub;

  // ── Helper: seal the current day and start a fresh one ────────────────────
  const closeDay = () => {
    days.push({
      dayNumber,
      stops: currentStops,
      totalTravelMins:  dayTravelMins,
      totalDistanceKm:  dayDistanceKm,
    });
    dayNumber++;
    currentStops    = [];
    currentTimeMins = DAY_START_MINS; // reset clock to 07:00
    dayTravelMins   = 0;
    dayDistanceKm   = 0;
    prevLocation    = hub;            // each day departs from the hub
  };

  // ── Schedule each stop ────────────────────────────────────────────────────
  for (let i = 0; i < stops.length; i++) {
    const loc = stops[i];

    // ── Compute travel leg from previous location ────────────────────────────
    // Look up the directed edge (prevLocation → loc) in the matrix.
    const edgeKey   = getEdgeKey(prevLocation.id, loc.id);
    const edge      = matrix[edgeKey];
    const travelMins = edge?.travel_time_mins ?? 0; // 0 if edge missing (same-location edge)
    const distKm     = edge?.distance_km       ?? 0;

    // ── Compute candidate arrival time ────────────────────────────────────────
    let arrivalMins  = currentTimeMins + travelMins;

    // Parse location open / close times for feasibility checks
    const openMins   = timeToMins(loc.open_time);
    const closeMins  = timeToMins(loc.close_time);

    // If we arrive before the location opens, wait at the gate until it does.
    // This prevents an absurdly early arrival from being flagged infeasible.
    if (arrivalMins < openMins) {
      arrivalMins = openMins;
    }

    // Proposed departure time if we visit this stop today
    const departureMins = arrivalMins + loc.avg_time_spent;

    // ── Feasibility check ─────────────────────────────────────────────────────
    // A stop is feasible for the current day if BOTH:
    //   (a) We arrive before the location closes.
    //   (b) We can complete the visit before the day ends (20:00).
    const feasible =
      arrivalMins  < closeMins   && // (a) arrive while the place is still open
      departureMins <= DAY_END_MINS; // (b) depart by 20:00

    if (!feasible) {
      // ── Overflow: defer to the next day ────────────────────────────────────
      if (dayNumber >= prefs.durationDays) {
        // We have exhausted all available days.  Log a warning and skip this stop
        // rather than generating an itinerary that overruns the trip duration.
        console.warn(
          `[scheduler] Cannot fit "${loc.name}" into the itinerary — ` +
          `no remaining days (durationDays=${prefs.durationDays}). Stop skipped.`
        );
        continue;
      }

      // Seal the current day with whatever stops were already placed.
      closeDay();

      // Re-compute the travel leg from the hub (new day's departure point)
      const hubEdgeKey    = getEdgeKey(hub.id, loc.id);
      const hubEdge       = matrix[hubEdgeKey];
      const hubTravelMins = hubEdge?.travel_time_mins ?? 0;
      const hubDistKm     = hubEdge?.distance_km       ?? 0;

      // Arrival on the new day: DAY_START (07:00) + travel from hub
      arrivalMins = DAY_START_MINS + hubTravelMins;

      // Respect opening time on the new day too
      if (arrivalMins < timeToMins(loc.open_time)) {
        arrivalMins = timeToMins(loc.open_time);
      }

      // Build the ScheduledStop for the new day
      const newDayDepartureMins = arrivalMins + loc.avg_time_spent;

      const scheduledStop: ScheduledStop = {
        order:              currentStops.length + 1,   // 1-based within day
        location:           loc,
        arrivalTime:        minsToTime(arrivalMins),
        departureTime:      minsToTime(newDayDepartureMins),
        travelTimeFromPrev: hubTravelMins,
        distanceFromPrev:   hubDistKm,
      };

      currentStops.push(scheduledStop);
      dayTravelMins   += hubTravelMins;
      dayDistanceKm   += hubDistKm;
      currentTimeMins  = newDayDepartureMins; // advance clock to after visiting loc
      prevLocation     = loc;                 // next leg departs from this location

    } else {
      // ── Feasible: place the stop in the current day ────────────────────────
      const scheduledStop: ScheduledStop = {
        order:              currentStops.length + 1,
        location:           loc,
        arrivalTime:        minsToTime(arrivalMins),
        departureTime:      minsToTime(departureMins),
        travelTimeFromPrev: travelMins,
        distanceFromPrev:   distKm,
      };

      currentStops.push(scheduledStop);
      dayTravelMins   += travelMins;
      dayDistanceKm   += distKm;
      currentTimeMins  = departureMins; // advance clock past this stop's visit time
      prevLocation     = loc;
    }
  } // end for each stop

  // ── Seal the final day (if it has any stops) ──────────────────────────────
  if (currentStops.length > 0) {
    days.push({
      dayNumber,
      stops:           currentStops,
      totalTravelMins: dayTravelMins,
      totalDistanceKm: dayDistanceKm,
    });
  }

  // ── Compute grand totals ──────────────────────────────────────────────────
  const totalDistanceKm     = days.reduce((sum, d) => sum + d.totalDistanceKm,  0);
  const totalTravelTimeMins = days.reduce((sum, d) => sum + d.totalTravelMins,  0);

  // Cost score: sum of cost_score for every scheduled stop (hub excluded)
  const totalCostScore = days.reduce(
    (sum, d) => sum + d.stops.reduce((s, stop) => s + stop.location.cost_score, 0),
    0
  );

  return {
    totalDays:         days.length,
    totalDistanceKm:   Math.round(totalDistanceKm * 10) / 10,    // 1 decimal place
    totalTravelTimeMins,
    totalCostScore,
    days,
  };
}

// ---------------------------------------------------------------------------
// Full Pipeline Orchestrator
// ---------------------------------------------------------------------------

/**
 * End-to-end optimizer pipeline entry point called by the Next.js API route.
 *
 * Execution sequence:
 *   1. Fetch all locations, behavioral profiles, and travel matrix edges from DB.
 *   2. Call `filterAndScore()` → ranked list of top-N locations for this user.
 *   3. Identify the BBI hub from the raw location list.
 *   4. Build an in-memory `TravelMatrix` map (O(1) lookups in TSP and scheduler).
 *   5. Prepend the hub to the scored list and call `solveTSP()`.
 *   6. Call `buildItinerary()` to convert the TSP order into time-slotted days.
 *   7. Return the complete `OptimizedItinerary`.
 *
 * @param prefs - User preferences from the planning form (already validated/normalised)
 * @returns     - Promise resolving to the fully optimized `OptimizedItinerary`
 *
 * @throws Will throw if the BBI hub location is not found in the DB, or if
 *         the DB query fails (errors propagate up to the API handler).
 */
export async function runOptimizerPipeline(
  prefs: UserPreferences
): Promise<OptimizedItinerary> {

  // ── Step 1: Fetch all required data from the database ─────────────────────
  // All three queries run in parallel for minimal latency using Promise.all.
  // `query<T>` is a typed wrapper around the pg/mysql2 pool from '@/lib/db'.
  const [locationsResult, profilesResult, matrixResult] = await Promise.all([
    query<Location>('SELECT * FROM locations'),
    query<BehavioralProfile>('SELECT * FROM behavioral_profiles'),
    query<TravelEdge>('SELECT * FROM travel_matrix'),
  ]);

  const locations : Location[]          = locationsResult.rows;
  const profiles  : BehavioralProfile[] = profilesResult.rows;
  const matrixRows: TravelEdge[]        = matrixResult.rows;

  if (locations.length === 0) {
    throw new Error('[pipeline] No locations found in the database.');
  }

  // ── Step 2: Filter and score locations ─────────────────────────────────────
  // Returns top-N `ScoredLocation[]` sorted by behavioral fit, hub excluded.
  const scoredLocations = filterAndScore(locations, profiles, prefs);

  if (scoredLocations.length === 0) {
    throw new Error(
      '[pipeline] No locations matched the user\'s budget and preference criteria. ' +
      'Try increasing budgetLevel or adjusting preference weights.'
    );
  }

  // ── Step 3: Locate the BBI hub ─────────────────────────────────────────────
  // The hub must exist in the locations table with the exact canonical name.
  const hub = locations.find(loc => loc.name === 'BBI Hub - Bhubaneswar');
  if (!hub) {
    throw new Error(
      '[pipeline] BBI Hub - Bhubaneswar not found in the locations table. ' +
      'Ensure the seed data contains this record.'
    );
  }

  // ── Step 4: Build the TravelMatrix map ────────────────────────────────────
  // Convert the flat array of DB rows into an O(1)-lookup map.
  // Key format: 'originId|destinationId' (matches `getEdgeKey()` in tsp.ts).
  const travelMatrix: TravelMatrix = {};
  for (const edge of matrixRows) {
    const key          = getEdgeKey(edge.origin_id, edge.destination_id);
    travelMatrix[key]  = edge;
  }

  // ── Step 5: Build the TSP node list and solve ──────────────────────────────
  // The hub MUST be at index 0 so that `solveTSP` can find it and use it as
  // the route anchor.  `scoredLocations` are `ScoredLocation` which extends
  // `Location`, so they are compatible with the `Location[]` parameter.
  const tspNodes: Location[] = [hub, ...scoredLocations];

  // Returns: [hub, optStop1, optStop2, …, optStopN, hub]
  const orderedRoute = solveTSP(tspNodes, travelMatrix, hub.id);

  // ── Step 6: Schedule the route into time-slotted days ─────────────────────
  const itinerary = buildItinerary(orderedRoute, travelMatrix, hub.id, prefs);

  // ── Step 7: Return the complete itinerary ──────────────────────────────────
  return itinerary;
}
