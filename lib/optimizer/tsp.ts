/**
 * @file tsp.ts
 * @description Traveling Salesman Problem (TSP) solver for the tourist route optimizer.
 *
 * This module provides a single public function `solveTSP()` that returns the
 * optimal (or near-optimal) visit order for a set of tourist locations,
 * starting and ending at the BBI hub (Bhubaneswar airport / city centre).
 *
 * ─── Algorithm Selection ───────────────────────────────────────────────────
 *
 *  n ≤ 12 nodes  →  Exact Held-Karp bitmask DP  (O(2^n · n²) time, O(2^n · n) space)
 *                   For n=12: 2^12 × 144 = ~590 k operations — runs in <5 ms.
 *
 *  n > 12 nodes  →  Greedy Nearest-Neighbor heuristic  (O(n²) time)
 *                   Gives ≈ 20–25 % above optimal but scales to hundreds of nodes.
 *
 * ─── Bitmask DP Primer ─────────────────────────────────────────────────────
 *
 * We represent the "set of visited nodes" as a single integer (bitmask) where
 * bit k is 1 if node k has been visited.
 *
 *   mask = 0b0000_0101  →  nodes 0 and 2 have been visited
 *   mask | (1 << j)     →  add node j to the visited set
 *   mask & (1 << i)     →  test if node i is in the visited set (non-zero = yes)
 *   (1 << n) - 1        →  all-ones mask: every node visited (the "full" state)
 *
 * State definition:
 *   dp[mask][i] = minimum travel time (minutes) to visit exactly the nodes
 *                 encoded in `mask`, ending at node i.
 *
 * Base case:
 *   dp[1 << hubIndex][hubIndex] = 0
 *   — We start at the hub, having visited only it, with 0 travel time elapsed.
 *
 * Transition:
 *   For each (mask, i) where dp[mask][i] is known and finite:
 *     For each node j NOT yet in mask:
 *       newMask = mask | (1 << j)          // mark j as visited
 *       cost    = dp[mask][i] + travel(i→j)
 *       if cost < dp[newMask][j]:
 *         dp[newMask][j]     = cost        // relax the DP
 *         parent[newMask][j] = i           // record predecessor for path reconstruction
 *
 * Answer extraction:
 *   fullMask = (1 << n) - 1   (all nodes visited)
 *   Find i that minimises:  dp[fullMask][i] + travel(i → hub)
 *   Then walk parent[][] pointers backwards to reconstruct the path.
 */

import { Location, TravelMatrix } from './types';

// ---------------------------------------------------------------------------
// Constants
// ---------------------------------------------------------------------------

/**
 * Fallback travel time used when a direct edge is absent from `TravelMatrix`.
 *
 * 999 999 minutes (≈ 694 days) acts as "infinity" in the DP/greedy minimiser.
 * It is large enough that any real path will be preferred, yet small enough
 * not to overflow when added to another large number (JavaScript numbers are
 * 64-bit floats, safe up to 2^53).
 */
const INFINITY_COST = 999_999;

/**
 * The maximum number of nodes (including the hub) for which the exact DP
 * algorithm is used.  Above this threshold we fall back to the greedy
 * nearest-neighbour heuristic.
 *
 * At n=12: memory = 2^12 states × 12 nodes × 2 arrays (dp + parent) ×
 *          8 bytes = ~786 KB — well within budget.
 * At n=20: memory would be ~160 MB — unacceptable for a serverless function.
 */
const DP_NODE_LIMIT = 12;

// ---------------------------------------------------------------------------
// Helper Functions
// ---------------------------------------------------------------------------

/**
 * Builds the canonical lookup key for the `TravelMatrix` map.
 *
 * Format: `'<originId>|<destinationId>'`
 *
 * The pipe character is safe because UUIDs only contain hex digits and hyphens.
 * This function MUST be used everywhere matrix edges are looked up to guarantee
 * consistent key formatting.
 *
 * @param originId      - UUID of the departure location
 * @param destinationId - UUID of the arrival location
 * @returns Pipe-separated compound key string
 *
 * @example
 *   getEdgeKey('abc', 'def') // → 'abc|def'
 */
function getEdgeKey(originId: string, destinationId: string): string {
  return `${originId}|${destinationId}`;
}

/**
 * Looks up the travel time in minutes between two nodes identified by their
 * array indices.  Returns `INFINITY_COST` when the matrix entry is missing.
 *
 * This abstraction hides the index → id → key lookup chain from the hot DP
 * loop, keeping the transition code readable.
 *
 * @param nodes  - Ordered array of Location objects (index = node number)
 * @param matrix - Pre-built TravelMatrix map
 * @param from   - Index of origin node in `nodes`
 * @param to     - Index of destination node in `nodes`
 * @returns Travel time in minutes, or INFINITY_COST if the edge is unknown
 */
function getTravelTime(
  nodes: Location[],
  matrix: TravelMatrix,
  from: number,
  to: number
): number {
  // If `from` and `to` are the same node, travel time is 0 (no movement).
  if (from === to) return 0;

  const key  = getEdgeKey(nodes[from].id, nodes[to].id);
  const edge = matrix[key];

  // Return the real travel time if the edge exists, otherwise use INFINITY_COST
  // so that missing edges are never selected over any real path.
  return edge ? edge.travel_time_mins : INFINITY_COST;
}

/**
 * Looks up the distance in km between two nodes.
 * Mirror of `getTravelTime` — returns 0 for missing edges (used by scheduler
 * for display, not by the optimiser).
 */
function getDistance(
  nodes: Location[],
  matrix: TravelMatrix,
  from: number,
  to: number
): number {
  if (from === to) return 0;
  const key  = getEdgeKey(nodes[from].id, nodes[to].id);
  const edge = matrix[key];
  return edge ? edge.distance_km : 0;
}

// ---------------------------------------------------------------------------
// Algorithm Implementations
// ---------------------------------------------------------------------------

/**
 * Exact TSP solver using Held-Karp bitmask dynamic programming.
 *
 * Time complexity:  O(2^n · n²)
 * Space complexity: O(2^n · n)
 *
 * Only called when `nodes.length ≤ DP_NODE_LIMIT` (12).
 *
 * The hub is assumed to be at index 0 in the `nodes` array.
 * The returned path starts at the hub, visits all other nodes in optimal
 * order, and ends with the hub repeated at the tail — matching the format
 * expected by `buildItinerary()` in scheduler.ts.
 *
 * @param nodes      - Array of Location objects; hub at index 0
 * @param matrix     - Pre-built TravelMatrix map
 * @param hubIndex   - Index of the hub within `nodes` (always 0 in our usage)
 * @returns          - Ordered Location[] from hub → … → hub (inclusive)
 */
function solveTSP_DP(
  nodes: Location[],
  matrix: TravelMatrix,
  hubIndex: number
): Location[] {
  const n = nodes.length;

  // ── Initialise DP and parent tables ───────────────────────────────────────
  // `dp[mask][i]`     = min cost to have visited the set encoded in `mask`,
  //                     currently standing at node i.
  // `parent[mask][i]` = index of the node we came from to reach state (mask, i).
  //                     Used to walk back the optimal path.
  //
  // We represent each table as a flat array of size (2^n) × n for cache
  // efficiency.  Index formula: mask * n + i.
  //
  // 2^n : the number of possible subsets of n nodes (each bit = one node).
  const totalStates = 1 << n; // = 2^n
  const dp     = new Array<number>(totalStates * n).fill(INFINITY_COST);
  const parent = new Array<number>(totalStates * n).fill(-1);

  // ── Base case ─────────────────────────────────────────────────────────────
  // Start at the hub having visited only the hub, zero cost elapsed.
  //
  //   1 << hubIndex    →  a bitmask with only the hub's bit set.
  //                       e.g. hubIndex=0 → mask = 0b0001 = 1
  const initMask = 1 << hubIndex;
  dp[initMask * n + hubIndex] = 0;  // cost 0 to "arrive" at hub from itself

  // ── DP Transition ─────────────────────────────────────────────────────────
  // Iterate over every subset `mask` of the node set.
  // For each `mask`, iterate over every node `i` that IS in `mask` (i.e.,
  // has already been visited and we are currently standing at it).
  // For each such (mask, i), try extending the path to every node `j` NOT
  // yet in `mask`.
  for (let mask = 0; mask < totalStates; mask++) {
    for (let i = 0; i < n; i++) {

      // ── Guard: skip if node i is NOT in the current visited set ───────────
      // `mask & (1 << i)` checks whether bit i is set in `mask`.
      // Non-zero means "node i has been visited" — we can stand at it.
      if (!(mask & (1 << i))) continue;

      const costAtI = dp[mask * n + i];

      // ── Guard: skip unreachable states ────────────────────────────────────
      // If dp[mask][i] is still INFINITY_COST, this state was never reached
      // by any valid prefix path — no point trying to extend it.
      if (costAtI === INFINITY_COST) continue;

      // ── Try visiting each unvisited neighbour j ────────────────────────────
      for (let j = 0; j < n; j++) {

        // Skip node j if it is already in `mask` (already visited).
        // `mask & (1 << j)` — bit j is set → j is in the visited set.
        if (mask & (1 << j)) continue;

        // Compute the new mask after visiting j:
        // `mask | (1 << j)` sets bit j in the mask, adding j to the visited set.
        const newMask = mask | (1 << j);

        // Total cost to reach j via the current path through i
        const travelTime = getTravelTime(nodes, matrix, i, j);
        const newCost    = costAtI + travelTime;

        // Relax: update if we found a cheaper way to reach (newMask, j)
        if (newCost < dp[newMask * n + j]) {
          dp[newMask * n + j]     = newCost;  // update best cost
          parent[newMask * n + j] = i;        // record predecessor for path reconstruction
        }
      }
    }
  }

  // ── Find the optimal final node before returning to hub ───────────────────
  // `fullMask = (1 << n) - 1` has every bit set — all n nodes visited.
  // We want the node i such that dp[fullMask][i] + travel(i → hub) is minimum.
  const fullMask = totalStates - 1; // = (1 << n) - 1

  let bestCost    = INFINITY_COST;
  let lastNode    = -1;

  for (let i = 0; i < n; i++) {
    if (i === hubIndex) continue; // no point ending at hub before the final return

    const returnCost = getTravelTime(nodes, matrix, i, hubIndex);
    const totalCost  = dp[fullMask * n + i] + returnCost;

    if (totalCost < bestCost) {
      bestCost = totalCost;
      lastNode = i;
    }
  }

  // Edge case: if no valid tour was found (e.g. disconnected graph), return
  // nodes in their original order as a fallback.
  if (lastNode === -1) {
    console.warn('[tsp] DP found no complete tour — returning original node order.');
    return [...nodes, nodes[hubIndex]];
  }

  // ── Path Reconstruction ───────────────────────────────────────────────────
  // Walk the `parent` table backwards from the last node to the hub,
  // collecting node indices, then reverse to get the forward-order path.
  const pathIndices: number[] = [];
  let currentMask = fullMask;
  let currentNode = lastNode;

  while (currentNode !== -1) {
    pathIndices.push(currentNode);
    const prevNode = parent[currentMask * n + currentNode];
    if (prevNode === -1) break;                          // reached the start (hub)

    // Un-set bit `currentNode` in the mask to recover the previous state.
    // This is the inverse of `mask | (1 << j)` applied during the transition.
    currentMask = currentMask & ~(1 << currentNode);    // remove currentNode from mask
    currentNode = prevNode;
  }

  // `pathIndices` is built backwards (last → first), so reverse it.
  pathIndices.reverse();

  // Map node indices back to Location objects and append the hub at the end
  // so the path is: hub → loc1 → loc2 → … → locN → hub
  const orderedLocations = pathIndices.map(idx => nodes[idx]);
  orderedLocations.push(nodes[hubIndex]); // close the loop back to hub

  return orderedLocations;
}

/**
 * Greedy Nearest-Neighbor heuristic TSP solver.
 *
 * Time complexity:  O(n²)
 * Space complexity: O(n)
 *
 * Used as the fallback when `nodes.length > DP_NODE_LIMIT` (n > 12).
 *
 * Strategy:
 *   - Start at the hub.
 *   - At each step, move to the closest unvisited node (fewest travel minutes).
 *   - After all nodes are visited, return to the hub.
 *
 * This is a classical greedy heuristic — it is not optimal but runs in
 * polynomial time and typically produces routes within ~20–25 % of optimal.
 * For a tourist planner with ≤ 16 daily stops (4 stops × 4 days) the
 * quality is acceptable.
 *
 * @param nodes    - Array of Location objects; hub at index 0
 * @param matrix   - Pre-built TravelMatrix map
 * @param hubIndex - Index of the hub within `nodes` (always 0)
 * @returns        - Ordered Location[] from hub → … → hub (inclusive)
 */
function solveTSP_Greedy(
  nodes: Location[],
  matrix: TravelMatrix,
  hubIndex: number
): Location[] {
  const n       = nodes.length;
  const visited = new Array<boolean>(n).fill(false); // tracks which nodes we've visited
  const path: number[] = [];                          // stores node indices in visit order

  // Start at the hub
  let current = hubIndex;
  visited[current] = true;
  path.push(current);

  // Repeat until all nodes have been visited
  for (let step = 1; step < n; step++) {
    let nearestNode = -1;
    let nearestCost = INFINITY_COST;

    // Scan all nodes to find the nearest unvisited one
    for (let j = 0; j < n; j++) {
      if (visited[j]) continue; // skip already-visited nodes

      const cost = getTravelTime(nodes, matrix, current, j);

      // Select j if it is closer than the current best candidate
      if (cost < nearestCost) {
        nearestCost = cost;
        nearestNode = j;
      }
    }

    // Move to the nearest unvisited node
    if (nearestNode === -1) {
      // This can only happen if the graph is disconnected — pick any unvisited
      // node as a fallback to ensure we include all stops.
      nearestNode = visited.findIndex(v => !v);
      if (nearestNode === -1) break; // all visited — shouldn't happen here
    }

    visited[nearestNode] = true;
    path.push(nearestNode);
    current = nearestNode;
  }

  // Close the loop: return to the hub at the end
  path.push(hubIndex);

  // Map indices back to Location objects
  return path.map(idx => nodes[idx]);
}

// ---------------------------------------------------------------------------
// Public API
// ---------------------------------------------------------------------------

/**
 * Solves the Traveling Salesman Problem for the given set of tourist locations.
 *
 * Automatically selects the appropriate algorithm:
 *   - `nodes.length ≤ 12` → Held-Karp bitmask DP (exact, fast for small n)
 *   - `nodes.length > 12` → Greedy nearest-neighbour (heuristic, scalable)
 *
 * IMPORTANT: The hub location MUST be present in `nodes` (at any index —
 * the function locates it via `hubId`).  The recommended convention is to
 * place the hub at index 0.
 *
 * @param nodes  - All locations to include in the route (MUST include the hub).
 *                 Typically: [hubLocation, ...scoredLocations]
 * @param matrix - Pre-built TravelMatrix map loaded from the DB
 * @param hubId  - The `id` field of the hub Location (BBI Bhubaneswar)
 * @returns      - Ordered Location[] starting and ending with the hub.
 *                 The hub appears as the first AND last element.
 *
 * @example
 *   const route = solveTSP([hub, ...topLocations], travelMatrix, hub.id);
 *   // route[0]             === hub  (departure)
 *   // route[route.length-1] === hub (return)
 */
export function solveTSP(
  nodes: Location[],
  matrix: TravelMatrix,
  hubId: string
): Location[] {
  const n = nodes.length;

  // ── Trivial cases ──────────────────────────────────────────────────────────
  if (n === 0) return [];
  if (n === 1) return [nodes[0], nodes[0]]; // just hub → hub

  // ── Locate the hub within the node array ──────────────────────────────────
  const hubIndex = nodes.findIndex(loc => loc.id === hubId);

  if (hubIndex === -1) {
    // Hub not found — this is a programming error in the caller; throw loudly.
    throw new Error(
      `[tsp] solveTSP: hub id "${hubId}" was not found in the nodes array. ` +
      `Ensure the hub Location is prepended to the list before calling solveTSP().`
    );
  }

  // ── If the hub is the only node, return trivially ─────────────────────────
  if (n === 1) return [nodes[hubIndex], nodes[hubIndex]];

  // ── Algorithm dispatch ────────────────────────────────────────────────────
  if (n <= DP_NODE_LIMIT) {
    // Exact Held-Karp DP for small instances (n ≤ 12).
    // Complexity: O(2^n · n²) — acceptable for n ≤ 12 (~590 k ops).
    console.log(`[tsp] Using Held-Karp DP for n=${n} nodes.`);
    return solveTSP_DP(nodes, matrix, hubIndex);
  } else {
    // Greedy nearest-neighbour for larger instances (n > 12).
    // Complexity: O(n²) — acceptable for all practical trip sizes.
    console.log(`[tsp] Using Greedy Nearest-Neighbor heuristic for n=${n} nodes.`);
    return solveTSP_Greedy(nodes, matrix, hubIndex);
  }
}

// ---------------------------------------------------------------------------
// Re-export helper for use by scheduler.ts when building ScheduledStop data
// ---------------------------------------------------------------------------

/**
 * Re-exported edge key builder.
 * `scheduler.ts` uses this to perform O(1) matrix lookups when computing
 * per-stop travel times and distances.
 *
 * @example
 *   import { getEdgeKey } from './tsp';
 *   const edge = matrix[getEdgeKey(prevId, currId)];
 */
export { getEdgeKey };
