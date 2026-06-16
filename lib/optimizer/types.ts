/**
 * @file types.ts
 * @description Central type definitions for the Odisha Tourist Planner optimizer engine.
 *
 * This file is the single source of truth for every data shape that flows through
 * the pipeline:  DB → scoring → TSP solver → scheduler → API response.
 *
 * Import order for consumers:
 *   import { Location, UserPreferences, OptimizedItinerary, … } from './types';
 */

// ---------------------------------------------------------------------------
// Primitive / Scalar Types
// ---------------------------------------------------------------------------

/**
 * The functional category of a tourist location.
 * Used for display, filtering, and icon selection on the frontend.
 */
export type LocationCategory =
  | 'temple'
  | 'beach'
  | 'wildlife'
  | 'hill_station'
  | 'heritage'
  | 'lake'
  | 'waterfall'
  | 'fort';

/**
 * Trip pace chosen by the user.
 * Controls how many stops the planner allocates per day:
 *   RELAXED  → 2 stops / day  (leisurely sightseeing)
 *   MODERATE → 3 stops / day  (balanced)
 *   HECTIC   → 4 stops / day  (maximise coverage)
 */
export type Pace = 'RELAXED' | 'MODERATE' | 'HECTIC';

// ---------------------------------------------------------------------------
// Core Domain Interfaces
// ---------------------------------------------------------------------------

/**
 * A tourist location as stored in the `locations` DB table.
 *
 * `avg_time_spent`  – estimated dwell time in minutes (used by the scheduler).
 * `open_time` / `close_time` – 24-hour strings e.g. '09:00', '17:30'.
 * `cost_score`      – ordinal budget indicator from 1 (free) to 5 (expensive).
 */
export interface Location {
  /** Stable UUID primary key, matches `behavioral_profiles.location_id`. */
  id: string;

  /** Human-readable name displayed in the UI e.g. "Konark Sun Temple". */
  name: string;

  /** WGS-84 latitude in decimal degrees. */
  latitude: number;

  /** WGS-84 longitude in decimal degrees. */
  longitude: number;

  /** Functional category used for filtering and icon selection. */
  category: LocationCategory;

  /**
   * Average time a visitor spends at this location, in minutes.
   * Used by the scheduler to compute departure times.
   */
  avg_time_spent: number;

  /**
   * Time the location opens for visitors, in 'HH:MM' 24-hour format.
   * The scheduler will not schedule an arrival before this time.
   */
  open_time: string;

  /**
   * Time the location closes for visitors, in 'HH:MM' 24-hour format.
   * The scheduler will not schedule an arrival after this time.
   */
  close_time: string;

  /**
   * Ordinal budget score from 1 (free / very cheap) to 5 (expensive).
   * Filtered against `UserPreferences.budgetLevel`.
   */
  cost_score: number;

  /** Optional short description shown in the trip detail card. */
  description?: string;
}

/**
 * Behavioral interest scores for a single location.
 * Each dimension is rated 1–10 and reflects how well the location satisfies
 * that type of tourist interest.
 *
 * These are dot-product-multiplied with the user's normalized preference
 * weights to produce a single `ScoredLocation.score`.
 */
export interface BehavioralProfile {
  /** FK → `locations.id`. */
  location_id: string;

  /**
   * How strongly this location appeals to cultural / religious tourists.
   * High for temples, heritage sites; low for beaches.
   */
  culture_score: number; // 1–10

  /**
   * How strongly this location appeals to nature lovers.
   * High for wildlife sanctuaries, waterfalls; moderate for hill stations.
   */
  nature_score: number; // 1–10

  /**
   * How strongly this location appeals to visitors seeking relaxation.
   * High for beaches, lakes; low for busy forts or heritage museums.
   */
  relax_score: number; // 1–10

  /**
   * How strongly this location appeals to adventure seekers.
   * High for wildlife safaris, hill treks; low for temples.
   */
  adventure_score: number; // 1–10
}

/**
 * A directed edge in the travel graph between two locations.
 * Stored in the `travel_matrix` DB table and loaded into a `TravelMatrix` map.
 *
 * Both `travel_time_mins` and `distance_km` are used:
 *   – TSP solver uses `travel_time_mins` to minimise total travel time.
 *   – Itinerary output reports `distance_km` for informational display.
 */
export interface TravelEdge {
  /** UUID of the departure location. */
  origin_id: string;

  /** UUID of the destination location. */
  destination_id: string;

  /**
   * Estimated road travel time in minutes (accounting for Odisha road
   * conditions and typical traffic patterns).
   */
  travel_time_mins: number;

  /** Approximate road distance in kilometres. */
  distance_km: number;
}

// ---------------------------------------------------------------------------
// User Input
// ---------------------------------------------------------------------------

/**
 * All preferences collected from the user on the trip-planning form.
 *
 * Weight fields (`cultureWeight`, `natureWeight`, `relaxWeight`,
 * `adventureWeight`) MUST be normalised so they sum to 1.0 before being
 * passed into `computeBehavioralScore`.  The API layer is responsible for
 * this normalisation.
 */
export interface UserPreferences {
  /** Total number of trip days (including travel days). */
  durationDays: number;

  /** Chosen trip pace — controls stops per day. */
  pace: Pace;

  /**
   * Maximum affordable cost score (1–5).
   * Locations with `cost_score > budgetLevel` are filtered out.
   */
  budgetLevel: number; // 1–5

  /**
   * Fractional weight for cultural interest (0–1).
   * Together with the three weights below, must sum to 1.0.
   */
  cultureWeight: number;

  /** Fractional weight for nature interest (0–1). */
  natureWeight: number;

  /** Fractional weight for relaxation interest (0–1). */
  relaxWeight: number;

  /** Fractional weight for adventure interest (0–1). */
  adventureWeight: number;
}

// ---------------------------------------------------------------------------
// Intermediate / Derived Interfaces
// ---------------------------------------------------------------------------

/**
 * A `Location` enriched with its behavioral score and raw profile.
 * Produced by `filterAndScore()` in scoring.ts and consumed by `solveTSP()`.
 */
export interface ScoredLocation extends Location {
  /**
   * Weighted dot-product behavioral score.
   * Higher is better; used only for ranking — not exposed to the user.
   */
  score: number;

  /** The underlying profile used to compute `score`. */
  profile: BehavioralProfile;
}

/**
 * A single scheduled visit within a day's itinerary.
 *
 * `order` is 1-indexed within the day.
 * `arrivalTime` / `departureTime` are 24-hour 'HH:MM' strings.
 * Travel data (`travelTimeFromPrev`, `distanceFromPrev`) describe the leg
 * arriving at *this* stop from the previous one (0 for the day's first stop).
 */
export interface ScheduledStop {
  /** 1-based position of this stop within its `ItineraryDay`. */
  order: number;

  /** Full location data for display. */
  location: Location;

  /**
   * Planned arrival time at this location in 'HH:MM' format.
   * Computed as: previousStop.departureTime + travelTimeFromPrev.
   */
  arrivalTime: string;

  /**
   * Planned departure time from this location in 'HH:MM' format.
   * Computed as: arrivalTime + location.avg_time_spent.
   */
  departureTime: string;

  /**
   * Road travel time in minutes from the previous stop to this one.
   * Zero for the first stop of each day (hub departure).
   */
  travelTimeFromPrev: number;

  /**
   * Road distance in kilometres from the previous stop to this one.
   * Zero for the first stop of each day.
   */
  distanceFromPrev: number;
}

/**
 * All stops scheduled on a single calendar day.
 *
 * `totalTravelMins` and `totalDistanceKm` are sum-aggregates across the
 * day's `stops` array, used for the summary card on the frontend.
 */
export interface ItineraryDay {
  /** 1-based day number within the overall trip. */
  dayNumber: number;

  /**
   * Ordered list of stops for this day.
   * The hub (BBI) is implicitly the departure / return point and is NOT
   * listed as an explicit stop inside a day — it appears as the first node
   * in the TSP solution and is used to anchor travel times.
   */
  stops: ScheduledStop[];

  /**
   * Sum of `travelTimeFromPrev` across all stops in this day.
   * Gives the user a quick sense of how much time is spent in transit.
   */
  totalTravelMins: number;

  /**
   * Sum of `distanceFromPrev` across all stops in this day (kilometres).
   */
  totalDistanceKm: number;
}

/**
 * The fully optimized trip itinerary returned by `buildItinerary()`.
 *
 * `totalDistanceKm` and `totalTravelTimeMins` are grand totals across all days.
 * `totalCostScore` is the sum of `cost_score` for every scheduled location
 * (excluding the hub), giving a rough trip-budget indicator.
 */
export interface OptimizedItinerary {
  /** Total number of itinerary days (matches `UserPreferences.durationDays`). */
  totalDays: number;

  /** Grand total road distance across the entire trip in kilometres. */
  totalDistanceKm: number;

  /** Grand total road travel time across the entire trip in minutes. */
  totalTravelTimeMins: number;

  /**
   * Sum of `cost_score` for every visited location (excluding the hub).
   * Can be displayed as a rough budget indicator (lower = cheaper trip).
   */
  totalCostScore: number;

  /** Day-by-day breakdown of the itinerary. */
  days: ItineraryDay[];
}

// ---------------------------------------------------------------------------
// Travel Matrix
// ---------------------------------------------------------------------------

/**
 * In-memory representation of the travel graph, loaded once at runtime.
 *
 * Keys are formatted as `'originId|destinationId'` (produced by
 * `getEdgeKey()` in tsp.ts).  Using a flat map rather than a nested object
 * gives O(1) edge lookups inside the hot DP / greedy loops.
 *
 * @example
 *   const edge = matrix['uuid-a|uuid-b'];
 *   const travelTime = edge?.travel_time_mins ?? 999999;
 */
export interface TravelMatrix {
  /** Keyed as 'originId|destinationId'. */
  [key: string]: TravelEdge;
}
