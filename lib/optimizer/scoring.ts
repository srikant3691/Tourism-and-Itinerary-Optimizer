/**
 * @file scoring.ts
 * @description Behavioral scoring and filtering pipeline — Step A of the optimizer.
 *
 * Pipeline overview:
 *   1. `getStopsPerDay(pace)`        → how many sites to fit per day
 *   2. `computeBehavioralScore()`    → dot-product of user weights × profile scores
 *   3. `filterAndScore()`            → budget filter → score → sort → slice top-N
 *
 * The output of `filterAndScore()` is a ranked list of `ScoredLocation` objects
 * ready to be handed off to the TSP solver in tsp.ts.
 */

import {
  Location,
  BehavioralProfile,
  ScoredLocation,
  UserPreferences,
  Pace,
} from './types';

// ---------------------------------------------------------------------------
// Constants
// ---------------------------------------------------------------------------

/**
 * Maps each `Pace` variant to the maximum number of tourist stops per day.
 *
 * These numbers were calibrated for Odisha:
 *   - RELAXED : 2 stops — allows long visits + midday rest in the heat
 *   - MODERATE: 3 stops — typical tourist rhythm
 *   - HECTIC  : 4 stops — packed schedule, short dwell times at each site
 *
 * Note: the hub (BBI) is NOT counted as a stop.
 */
const STOPS_PER_DAY_MAP: Record<Pace, number> = {
  RELAXED: 2,
  MODERATE: 3,
  HECTIC: 4,
};

// ---------------------------------------------------------------------------
// Public Functions
// ---------------------------------------------------------------------------

/**
 * Returns the number of tourist stops to schedule per day for the given pace.
 *
 * Centralising this lookup means the scheduler and the scoring filter always
 * use the same constant — no magic numbers scattered in the code.
 *
 * @param pace - User-selected trip pace ('RELAXED' | 'MODERATE' | 'HECTIC')
 * @returns Number of stops to allocate per day (2, 3, or 4)
 *
 * @example
 *   getStopsPerDay('MODERATE') // → 3
 */
export function getStopsPerDay(pace: Pace): number {
  return STOPS_PER_DAY_MAP[pace];
}

/**
 * Computes the weighted dot-product behavioral score for a location.
 *
 * Formula:
 *   score = (cultureWeight × culture_score)
 *         + (natureWeight  × nature_score)
 *         + (relaxWeight   × relax_score)
 *         + (adventureWeight × adventure_score)
 *
 * Because user weights are normalised to sum to 1.0 and profile scores
 * are in the range [1, 10], the result lands in [1, 10] (practically
 * between ~1 and ~10 weighted by whatever the user emphasises).
 *
 * A higher score means the location is a better match for this user's
 * stated interests.  Scores are used for ranking only — they are not shown
 * to the end user.
 *
 * @param profile - Behavioral profile of the location (from the DB)
 * @param prefs   - User preferences containing normalised weight vector
 * @returns       Composite score as a floating-point number
 *
 * @example
 *   // A user who loves culture (weight 0.8) visiting Konark (culture_score 9)
 *   // score contribution: 0.8 × 9 = 7.2 (dominant)
 */
export function computeBehavioralScore(
  profile: BehavioralProfile,
  prefs: UserPreferences
): number {
  return (
    prefs.cultureWeight   * profile.culture_score   + // cultural match
    prefs.natureWeight    * profile.nature_score    + // nature match
    prefs.relaxWeight     * profile.relax_score     + // relaxation match
    prefs.adventureWeight * profile.adventure_score   // adventure match
  );
}

/**
 * Step A of the optimizer pipeline: filters, scores, and selects the
 * top-N tourist locations for the user's trip.
 *
 * Steps performed:
 *   1. Build a Map<locationId, BehavioralProfile> for O(1) profile lookup.
 *   2. Filter out locations that exceed the user's budget (`cost_score > budgetLevel`).
 *   3. Filter out the BBI hub by name — it is inserted separately by the scheduler.
 *   4. For each remaining location, look up its behavioral profile and
 *      compute `computeBehavioralScore()`.  Locations without a matching
 *      profile are silently dropped (data integrity guard).
 *   5. Sort descending by score (best match first).
 *   6. Slice the top N = `stopsPerDay × durationDays` entries.
 *      This gives exactly as many stops as the scheduler can accommodate.
 *
 * @param locations - Full list of locations loaded from the DB
 * @param profiles  - Full list of behavioral profiles from the DB
 * @param prefs     - User trip preferences (pace, duration, budget, weights)
 * @returns         Ranked list of `ScoredLocation` objects, length ≤ N
 *
 * @throws Does NOT throw; locations with missing profiles are silently excluded.
 */
export function filterAndScore(
  locations: Location[],
  profiles: BehavioralProfile[],
  prefs: UserPreferences
): ScoredLocation[] {
  // ── Step 1: Index profiles by location_id for O(1) lookup ─────────────────
  // Without this map, looking up a profile for each location would be O(n²).
  const profileMap = new Map<string, BehavioralProfile>(
    profiles.map(p => [p.location_id, p])
  );

  // ── Step 2 & 3: Budget filter + exclude the BBI hub ───────────────────────
  // The hub is excluded here because it serves as the mandatory start/end
  // anchor and is inserted directly into the node list by `runOptimizerPipeline`,
  // bypassing the scoring pipeline entirely.
  const affordable = locations.filter(
    loc =>
      loc.cost_score <= prefs.budgetLevel &&       // within user's budget
      loc.name !== 'BBI Hub - Bhubaneswar'         // never score the hub itself
  );

  // ── Step 4: Score every affordable location ────────────────────────────────
  // `.map()` returns `ScoredLocation | null` — null when no profile exists.
  // The type predicate in `.filter()` narrows the array to `ScoredLocation[]`.
  const scored: ScoredLocation[] = affordable
    .map((loc): ScoredLocation | null => {
      const profile = profileMap.get(loc.id);

      // Guard: if the DB is missing a behavioral profile for this location,
      // drop it rather than scoring it as 0 (which could unfairly rank it last
      // and mislead the slicing logic).
      if (!profile) {
        console.warn(
          `[scoring] No behavioral profile found for location "${loc.name}" (id: ${loc.id}). Skipping.`
        );
        return null;
      }

      return {
        ...loc,                                           // spread all Location fields
        score: computeBehavioralScore(profile, prefs),   // dot-product score
        profile,                                          // keep raw profile for debug
      };
    })
    // Type guard: narrows `(ScoredLocation | null)[]` → `ScoredLocation[]`
    .filter((s): s is ScoredLocation => s !== null);

  // ── Step 5: Sort descending — highest score first ─────────────────────────
  scored.sort((a, b) => b.score - a.score);

  // ── Step 6: Slice top N ───────────────────────────────────────────────────
  // N = stops per day × number of days.  For a 3-day MODERATE trip: N = 9.
  // We never want more stops than the scheduler can place on the itinerary.
  const stopsPerDay = getStopsPerDay(prefs.pace);
  const totalStops  = stopsPerDay * prefs.durationDays;

  return scored.slice(0, totalStops);
}
