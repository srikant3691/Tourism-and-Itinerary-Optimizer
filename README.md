# 🏛️ Odisha Behavioral Tourism & Itinerary Optimizer

> A full-stack Next.js 14 application that generates **mathematically optimized, day-by-day travel itineraries** for Odisha, India — powered by a behavioral dot-product scoring engine and a DP + Bitmask TSP solver.

---

## ✨ Features

- **Behavioral Scoring** — Dot-product matching between user preferences (culture, nature, relax, adventure) and location profiles
- **TSP Optimization** — Exact DP + Bitmask algorithm for ≤12 locations; greedy Nearest Neighbor for larger sets
- **Temporal Scheduling** — Respects open/close times, daily travel windows (07:00–20:00)
- **GraphQL API** — Apollo Server 4 with full nested itinerary response
- **Interactive Map** — Leaflet route visualization with day-colored polylines
- **18 Odisha Locations** — Real coordinates, travel times, and behavioral profiles
- **Premium Dark UI** — Glassmorphism aesthetic, amber/teal palette, smooth animations

---

## 🗂️ Project Structure

```
app/                          ← Next.js project root
├── app/
│   ├── layout.tsx            ← Root layout (Outfit font, ambient orbs)
│   ├── page.tsx              ← Landing page with multi-step preference form
│   ├── globals.css           ← Design system (CSS vars, glassmorphism, animations)
│   └── api/
│       └── graphql/
│           └── route.ts      ← Apollo Server 4 route handler
├── components/
│   ├── WeightSlider.tsx      ← Animated preference slider
│   ├── ItineraryCard.tsx     ← Day card with vertical stop timeline
│   ├── MapView.tsx           ← Leaflet interactive route map
│   └── MetricsSummary.tsx    ← Stats strip (distance, time, cost)
├── lib/
│   ├── db.ts                 ← pg Pool + query helper (Neon SSL)
│   ├── schema.sql            ← DDL (locations, behavioral_profiles, travel_matrix)
│   ├── seed.sql              ← 18 Odisha locations + 306 travel matrix rows
│   ├── graphql/
│   │   ├── schema.ts         ← GraphQL SDL type definitions
│   │   └── resolvers.ts      ← Query resolvers → optimizer pipeline
│   └── optimizer/
│       ├── types.ts          ← Shared TypeScript interfaces
│       ├── scoring.ts        ← Step A: behavioral filtering & scoring
│       ├── tsp.ts            ← Step B: DP Bitmask TSP + greedy fallback
│       └── scheduler.ts      ← Step C: temporal day scheduling
├── .env.local                ← DATABASE_URL (fill in your Neon string)
├── next.config.ts
└── package.json
```

---

## 🚀 Getting Started

### Prerequisites

- Node.js 18+
- A [Neon](https://console.neon.tech) PostgreSQL database (free tier works)

### 1. Configure Database

Open `.env.local` and replace the placeholder with your Neon connection string:

```env
DATABASE_URL=postgresql://user:password@ep-xxx.us-east-1.aws.neon.tech/neondb?sslmode=require
```

> **Where to find it:** Neon Dashboard → Your Project → Connection Details → Connection String

### 2. Run Migrations

```bash
# From the app/ directory
cd app

# Run schema DDL
npm run db:migrate

# Seed the 18 Odisha locations + travel matrix
npm run db:seed
```

Or run manually with psql:

```bash
psql "$DATABASE_URL" -f lib/schema.sql
psql "$DATABASE_URL" -f lib/seed.sql
```

Or using the Neon SQL Editor — paste the contents of `lib/schema.sql` then `lib/seed.sql` and run.

### 3. Start Development Server

```bash
cd app
npm run dev
```

Open [http://localhost:3000](http://localhost:3000)

---

## 🔬 GraphQL API

The GraphQL playground is available at **`/api/graphql`** (GET request in a browser).

### Example Query

```graphql
query {
  optimizeItinerary(
    input: {
      durationDays: 3
      pace: MODERATE
      budgetLevel: 3
      cultureWeight: 0.4
      natureWeight: 0.3
      relaxWeight: 0.2
      adventureWeight: 0.1
    }
  ) {
    totalDays
    totalDistanceKm
    totalTravelTimeMins
    totalCostScore
    days {
      dayNumber
      totalTravelMins
      totalDistanceKm
      stops {
        order
        arrivalTime
        departureTime
        travelTimeFromPrev
        distanceFromPrev
        location {
          name
          category
          latitude
          longitude
        }
      }
    }
  }
}
```

---

## 🧠 Algorithm Details

### Step A — Behavioral Scoring

Every non-hub location is scored using a **dot product** between the user's preference weights and the location's behavioral profile:

```
score(L) = cultureWeight × culture_score(L)
         + natureWeight × nature_score(L)
         + relaxWeight × relax_score(L)
         + adventureWeight × adventure_score(L)
```

Locations with `cost_score > budgetLevel` are filtered out. The top `N = stopsPerDay × durationDays` locations are selected.

| Pace     | Stops per Day |
| -------- | ------------- |
| RELAXED  | 2             |
| MODERATE | 3             |
| HECTIC   | 4             |

### Step B — TSP Solver

**For n ≤ 12 locations** (exact): Dynamic Programming with Bitmask

```
dp[mask][i] = minimum travel time to visit all locations in `mask`, ending at node i

Transition:
  for each unvisited j (bit j not set in mask):
    dp[mask | (1<<j)][j] = min(dp[mask|(1<<j)][j], dp[mask][i] + travelTime[i][j])

Time complexity: O(2^n × n²)
Space complexity: O(2^n × n)
```

**For n > 12** (heuristic): Greedy Nearest Neighbor

```
Start at BBI hub → always move to nearest unvisited → return to hub
```

Both start and end at **BBI (Bhubaneswar Airport)**.

### Step C — Temporal Scheduling

- Daily window: **07:00 – 20:00**
- For each stop: `arrival = prev_departure + travel_time_mins`
- Validates: `arrival < close_time` AND `arrival + avg_time_spent ≤ 20:00`
- Stops overflowing a day are pushed to the next day

---

## 🗄️ Database Schema

```sql
locations          -- 18 Odisha tourist spots
behavioral_profiles -- culture/nature/relax/adventure scores (1-10)
travel_matrix       -- 306 pairwise travel times + distances
```

### Seeded Locations

| #   | Location                     | Category       |
| --- | ---------------------------- | -------------- |
| 1   | BBI Hub - Bhubaneswar        | Heritage (hub) |
| 2   | Lingaraj Temple              | Temple         |
| 3   | Mukteshwar Temple            | Temple         |
| 4   | Rajarani Temple              | Temple         |
| 5   | Udayagiri & Khandagiri Caves | Heritage       |
| 6   | Dhauli Peace Pagoda          | Heritage       |
| 7   | Nandankanan Zoological Park  | Wildlife       |
| 8   | Puri Jagannath Temple        | Temple         |
| 9   | Puri Beach                   | Beach          |
| 10  | Konark Sun Temple            | Heritage       |
| 11  | Chilika Lake Satapada        | Lake           |
| 12  | Mangalajodi Bird Sanctuary   | Wildlife       |
| 13  | Simlipal Biosphere Reserve   | Wildlife       |
| 14  | Bhitarkanika National Park   | Wildlife       |
| 15  | Daringbadi                   | Hill Station   |
| 16  | Gopalpur-on-Sea              | Beach          |
| 17  | Barabati Fort Cuttack        | Fort           |
| 18  | Hirakud Dam Sambalpur        | Heritage       |

---

## 📦 Tech Stack

| Layer     | Technology                              |
| --------- | --------------------------------------- |
| Framework | Next.js 14 (App Router)                 |
| Language  | TypeScript (strict)                     |
| Styling   | Tailwind CSS v4 + CSS custom properties |
| Database  | PostgreSQL (Neon) via `pg`              |
| API       | GraphQL (Apollo Server 4)               |
| Map       | Leaflet.js                              |
| Fonts     | Outfit (Google Fonts)                   |

---

## 📜 npm Scripts

```bash
npm run dev       # Start dev server (http://localhost:3000)
npm run build     # Production build
npm run start     # Start production server
npm run lint      # ESLint
```

---

## 🔧 Troubleshooting

**Database connection fails**

- Ensure `DATABASE_URL` in `.env.local` ends with `?sslmode=require`
- Check Neon project is not suspended (free tier pauses after inactivity)

**GraphQL returns empty days**

- Verify seed.sql was run: query `SELECT count(*) FROM locations` — should return 18
- Check that weights sum to a reasonable value (non-zero)

**Map not rendering**

- Leaflet requires browser environment; the component uses dynamic import to avoid SSR
- Hard-refresh the browser (Ctrl+F5) to clear any stale CSS

---

_Built with ❤️ for Odisha tourism_
