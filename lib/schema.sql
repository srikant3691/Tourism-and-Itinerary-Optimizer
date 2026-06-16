-- ============================================================
-- schema.sql  –  Odisha Tourist Planner
-- ============================================================

-- ENUM: location category
DO $$ BEGIN
  CREATE TYPE category_type AS ENUM (
    'temple',
    'beach',
    'wildlife',
    'hill_station',
    'heritage',
    'lake',
    'waterfall',
    'fort'
  );
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- ENUM: itinerary pace
DO $$ BEGIN
  CREATE TYPE pace_type AS ENUM (
    'RELAXED',
    'MODERATE',
    'HECTIC'
  );
EXCEPTION WHEN duplicate_object THEN NULL;
END $$;

-- ============================================================
-- Table: locations
-- ============================================================
CREATE TABLE IF NOT EXISTS locations (
  id            UUID        PRIMARY KEY DEFAULT gen_random_uuid(),
  name          TEXT        NOT NULL,
  latitude      FLOAT       NOT NULL,
  longitude     FLOAT       NOT NULL,
  category      category_type NOT NULL,
  avg_time_spent INT        NOT NULL,          -- minutes
  open_time     TIME        NOT NULL,
  close_time    TIME        NOT NULL,
  cost_score    INT         CHECK (cost_score BETWEEN 1 AND 5),
  description   TEXT
);

CREATE INDEX IF NOT EXISTS idx_locations_category ON locations (category);

-- ============================================================
-- Table: behavioral_profiles
-- ============================================================
CREATE TABLE IF NOT EXISTS behavioral_profiles (
  id              UUID  PRIMARY KEY DEFAULT gen_random_uuid(),
  location_id     UUID  NOT NULL REFERENCES locations(id) ON DELETE CASCADE,
  culture_score   INT   CHECK (culture_score   BETWEEN 1 AND 10),
  nature_score    INT   CHECK (nature_score    BETWEEN 1 AND 10),
  relax_score     INT   CHECK (relax_score     BETWEEN 1 AND 10),
  adventure_score INT   CHECK (adventure_score BETWEEN 1 AND 10),
  UNIQUE (location_id)
);

CREATE INDEX IF NOT EXISTS idx_behavioral_profiles_location_id
  ON behavioral_profiles (location_id);

-- ============================================================
-- Table: travel_matrix
-- ============================================================
CREATE TABLE IF NOT EXISTS travel_matrix (
  id               UUID   PRIMARY KEY DEFAULT gen_random_uuid(),
  origin_id        UUID   NOT NULL REFERENCES locations(id) ON DELETE CASCADE,
  destination_id   UUID   NOT NULL REFERENCES locations(id) ON DELETE CASCADE,
  travel_time_mins INT    NOT NULL,
  distance_km      FLOAT  NOT NULL,
  UNIQUE (origin_id, destination_id)
);

CREATE INDEX IF NOT EXISTS idx_travel_matrix_origin_id
  ON travel_matrix (origin_id);

CREATE INDEX IF NOT EXISTS idx_travel_matrix_destination_id
  ON travel_matrix (destination_id);

CREATE INDEX IF NOT EXISTS idx_travel_matrix_pair
  ON travel_matrix (origin_id, destination_id);
