-- ============================================================
-- seed.sql  --  Odisha Tourist Planner
-- 18 locations + 306 directed travel-matrix pairs
-- Run AFTER schema.sql
-- ============================================================

BEGIN;

-- ============================================================
-- 1. LOCATIONS  (18 Odisha tourist spots)
-- ============================================================
INSERT INTO locations (name, latitude, longitude, category, avg_time_spent, open_time, close_time, cost_score, description) VALUES
  ('BBI Hub - Bhubaneswar',        20.2961, 85.8245, 'heritage',      30, '00:00', '23:59', 1, 'Bhubaneswar city-centre hub, the main transit anchor for all Odisha routes.'),
  ('Lingaraj Temple',              20.2384, 85.8340, 'temple',        90, '06:00', '21:00', 1, 'Ancient 11th-century Shiva temple, the largest temple in Bhubaneswar.'),
  ('Mukteshwar Temple',            20.2440, 85.8282, 'temple',        60, '06:00', '20:00', 1, 'A 10th-century Shiva temple renowned for its ornate torana archway.'),
  ('Rajarani Temple',              20.2554, 85.8463, 'temple',        60, '08:00', '18:00', 1, 'An 11th-century temple famed for its erotic sculptures and tower carvings.'),
  ('Udayagiri & Khandagiri Caves', 20.2709, 85.7804, 'heritage',      90, '08:00', '18:00', 1, 'Ancient Jain rock-cut caves dating from the 2nd century BCE.'),
  ('Dhauli Peace Pagoda',          20.1874, 85.8513, 'heritage',      60, '07:00', '19:00', 1, 'Buddhist peace pagoda at the historic site of the Kalinga War, 261 BCE.'),
  ('Nandankanan Zoological Park',  20.3996, 85.8219, 'wildlife',     180, '08:00', '17:00', 2, 'Famous zoo home to white tigers, Indian pangolins and botanical gardens.'),
  ('Puri Jagannath Temple',        19.8048, 85.8181, 'temple',       120, '05:00', '21:00', 1, 'Iconic 12th-century temple dedicated to Lord Jagannath, one of the Char Dhams.'),
  ('Puri Beach',                   19.7983, 85.8245, 'beach',        120, '06:00', '20:00', 1, 'One of the finest beaches on the Bay of Bengal with golden sands.'),
  ('Konark Sun Temple',            19.8876, 86.0945, 'heritage',     120, '06:00', '20:00', 2, 'UNESCO World Heritage 13th-century Sun Temple shaped like a colossal chariot.'),
  ('Chilika Lake Satapada',        19.7177, 85.4320, 'lake',         180, '06:00', '18:00', 3, 'Asia''s largest brackish lagoon, home to Irrawaddy dolphins and flamingos.'),
  ('Mangalajodi Bird Sanctuary',   20.0247, 85.2013, 'wildlife',     150, '06:00', '17:00', 3, 'Premier birding destination on Chilika Lake''s northern shore; 200+ species.'),
  ('Simlipal Biosphere Reserve',   21.8356, 86.5144, 'wildlife',     360, '06:00', '16:00', 4, 'UNESCO biosphere reserve covering 2750 sq km of sal forest with tigers.'),
  ('Bhitarkanika National Park',   20.7236, 86.8808, 'wildlife',     300, '06:00', '16:00', 4, 'Ramsar wetland renowned for saltwater crocodiles and vast mangroves.'),
  ('Daringbadi',                   20.0543, 84.3925, 'hill_station', 240, '07:00', '18:00', 2, 'The Kashmir of Odisha — a cool hill station with coffee plantations.'),
  ('Gopalpur-on-Sea',              19.2627, 84.9129, 'beach',        180, '06:00', '20:00', 2, 'Tranquil seaside town on the Bay of Bengal with a historic lighthouse.'),
  ('Barabati Fort',                20.4686, 85.8792, 'fort',          90, '08:00', '17:00', 1, '14th-century Ganga dynasty fort in Cuttack beside the Mahanadi river.'),
  ('Hirakud Dam',                  21.5247, 83.8710, 'heritage',     120, '07:00', '18:00', 2, 'World''s longest earthen dam across the Mahanadi river, built in 1957.');

-- ============================================================
-- 2. BEHAVIORAL PROFILES (culture / nature / relax / adventure)
-- ============================================================
INSERT INTO behavioral_profiles (location_id, culture_score, nature_score, relax_score, adventure_score) SELECT id,  3,  2, 3, 2 FROM locations WHERE name = 'BBI Hub - Bhubaneswar';
INSERT INTO behavioral_profiles (location_id, culture_score, nature_score, relax_score, adventure_score) SELECT id, 10,  2, 4, 1 FROM locations WHERE name = 'Lingaraj Temple';
INSERT INTO behavioral_profiles (location_id, culture_score, nature_score, relax_score, adventure_score) SELECT id,  9,  3, 5, 1 FROM locations WHERE name = 'Mukteshwar Temple';
INSERT INTO behavioral_profiles (location_id, culture_score, nature_score, relax_score, adventure_score) SELECT id,  8,  2, 5, 1 FROM locations WHERE name = 'Rajarani Temple';
INSERT INTO behavioral_profiles (location_id, culture_score, nature_score, relax_score, adventure_score) SELECT id,  9,  3, 4, 2 FROM locations WHERE name = 'Udayagiri & Khandagiri Caves';
INSERT INTO behavioral_profiles (location_id, culture_score, nature_score, relax_score, adventure_score) SELECT id,  8,  4, 6, 1 FROM locations WHERE name = 'Dhauli Peace Pagoda';
INSERT INTO behavioral_profiles (location_id, culture_score, nature_score, relax_score, adventure_score) SELECT id,  3,  9, 5, 4 FROM locations WHERE name = 'Nandankanan Zoological Park';
INSERT INTO behavioral_profiles (location_id, culture_score, nature_score, relax_score, adventure_score) SELECT id, 10,  2, 5, 1 FROM locations WHERE name = 'Puri Jagannath Temple';
INSERT INTO behavioral_profiles (location_id, culture_score, nature_score, relax_score, adventure_score) SELECT id,  3,  6, 9, 5 FROM locations WHERE name = 'Puri Beach';
INSERT INTO behavioral_profiles (location_id, culture_score, nature_score, relax_score, adventure_score) SELECT id, 10,  3, 4, 2 FROM locations WHERE name = 'Konark Sun Temple';
INSERT INTO behavioral_profiles (location_id, culture_score, nature_score, relax_score, adventure_score) SELECT id,  3, 10, 8, 5 FROM locations WHERE name = 'Chilika Lake Satapada';
INSERT INTO behavioral_profiles (location_id, culture_score, nature_score, relax_score, adventure_score) SELECT id,  2, 10, 7, 4 FROM locations WHERE name = 'Mangalajodi Bird Sanctuary';
INSERT INTO behavioral_profiles (location_id, culture_score, nature_score, relax_score, adventure_score) SELECT id,  2, 10, 6, 9 FROM locations WHERE name = 'Simlipal Biosphere Reserve';
INSERT INTO behavioral_profiles (location_id, culture_score, nature_score, relax_score, adventure_score) SELECT id,  3, 10, 5, 8 FROM locations WHERE name = 'Bhitarkanika National Park';
INSERT INTO behavioral_profiles (location_id, culture_score, nature_score, relax_score, adventure_score) SELECT id,  4,  9, 8, 7 FROM locations WHERE name = 'Daringbadi';
INSERT INTO behavioral_profiles (location_id, culture_score, nature_score, relax_score, adventure_score) SELECT id,  2,  7, 9, 5 FROM locations WHERE name = 'Gopalpur-on-Sea';
INSERT INTO behavioral_profiles (location_id, culture_score, nature_score, relax_score, adventure_score) SELECT id,  8,  2, 4, 2 FROM locations WHERE name = 'Barabati Fort';
INSERT INTO behavioral_profiles (location_id, culture_score, nature_score, relax_score, adventure_score) SELECT id,  5,  7, 5, 4 FROM locations WHERE name = 'Hirakud Dam';

-- ============================================================
-- 3. TRAVEL MATRIX  (18×17 = 306 directed edges, both ways)
--    Abbreviations used in comments:
--      BBI=BBI Hub  LIN=Lingaraj  MUK=Mukteshwar  RAJ=Rajarani
--      UDA=Udayagiri  DHA=Dhauli  NAN=Nandankanan
--      PJT=Puri Jagannath  PBE=Puri Beach  KON=Konark
--      CHI=Chilika  MAN=Mangalajodi  SIM=Simlipal
--      BHI=Bhitarkanika  DAR=Daringbadi  GOP=Gopalpur
--      BAR=Barabati  HIR=Hirakud
-- ============================================================

-- ── FROM BBI Hub ────────────────────────────────────────────────────────────
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  15,   5.0 FROM locations o, locations d WHERE o.name='BBI Hub - Bhubaneswar' AND d.name='Lingaraj Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  20,   7.0 FROM locations o, locations d WHERE o.name='BBI Hub - Bhubaneswar' AND d.name='Mukteshwar Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  18,   6.0 FROM locations o, locations d WHERE o.name='BBI Hub - Bhubaneswar' AND d.name='Rajarani Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  22,  10.0 FROM locations o, locations d WHERE o.name='BBI Hub - Bhubaneswar' AND d.name='Udayagiri & Khandagiri Caves';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  25,  12.0 FROM locations o, locations d WHERE o.name='BBI Hub - Bhubaneswar' AND d.name='Dhauli Peace Pagoda';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  35,  18.0 FROM locations o, locations d WHERE o.name='BBI Hub - Bhubaneswar' AND d.name='Nandankanan Zoological Park';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  75,  60.0 FROM locations o, locations d WHERE o.name='BBI Hub - Bhubaneswar' AND d.name='Puri Jagannath Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  77,  62.0 FROM locations o, locations d WHERE o.name='BBI Hub - Bhubaneswar' AND d.name='Puri Beach';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  80,  65.0 FROM locations o, locations d WHERE o.name='BBI Hub - Bhubaneswar' AND d.name='Konark Sun Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 150, 120.0 FROM locations o, locations d WHERE o.name='BBI Hub - Bhubaneswar' AND d.name='Chilika Lake Satapada';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 140, 110.0 FROM locations o, locations d WHERE o.name='BBI Hub - Bhubaneswar' AND d.name='Mangalajodi Bird Sanctuary';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 360, 280.0 FROM locations o, locations d WHERE o.name='BBI Hub - Bhubaneswar' AND d.name='Simlipal Biosphere Reserve';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 270, 200.0 FROM locations o, locations d WHERE o.name='BBI Hub - Bhubaneswar' AND d.name='Bhitarkanika National Park';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 300, 250.0 FROM locations o, locations d WHERE o.name='BBI Hub - Bhubaneswar' AND d.name='Daringbadi';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 210, 175.0 FROM locations o, locations d WHERE o.name='BBI Hub - Bhubaneswar' AND d.name='Gopalpur-on-Sea';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  45,  32.0 FROM locations o, locations d WHERE o.name='BBI Hub - Bhubaneswar' AND d.name='Barabati Fort';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 420, 380.0 FROM locations o, locations d WHERE o.name='BBI Hub - Bhubaneswar' AND d.name='Hirakud Dam';

-- ── TO BBI Hub (reverse) ────────────────────────────────────────────────────
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  15,   5.0 FROM locations o, locations d WHERE o.name='Lingaraj Temple'              AND d.name='BBI Hub - Bhubaneswar';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  20,   7.0 FROM locations o, locations d WHERE o.name='Mukteshwar Temple'            AND d.name='BBI Hub - Bhubaneswar';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  18,   6.0 FROM locations o, locations d WHERE o.name='Rajarani Temple'              AND d.name='BBI Hub - Bhubaneswar';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  22,  10.0 FROM locations o, locations d WHERE o.name='Udayagiri & Khandagiri Caves' AND d.name='BBI Hub - Bhubaneswar';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  25,  12.0 FROM locations o, locations d WHERE o.name='Dhauli Peace Pagoda'          AND d.name='BBI Hub - Bhubaneswar';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  35,  18.0 FROM locations o, locations d WHERE o.name='Nandankanan Zoological Park'  AND d.name='BBI Hub - Bhubaneswar';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  75,  60.0 FROM locations o, locations d WHERE o.name='Puri Jagannath Temple'        AND d.name='BBI Hub - Bhubaneswar';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  77,  62.0 FROM locations o, locations d WHERE o.name='Puri Beach'                   AND d.name='BBI Hub - Bhubaneswar';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  80,  65.0 FROM locations o, locations d WHERE o.name='Konark Sun Temple'            AND d.name='BBI Hub - Bhubaneswar';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 150, 120.0 FROM locations o, locations d WHERE o.name='Chilika Lake Satapada'        AND d.name='BBI Hub - Bhubaneswar';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 140, 110.0 FROM locations o, locations d WHERE o.name='Mangalajodi Bird Sanctuary'   AND d.name='BBI Hub - Bhubaneswar';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 360, 280.0 FROM locations o, locations d WHERE o.name='Simlipal Biosphere Reserve'   AND d.name='BBI Hub - Bhubaneswar';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 270, 200.0 FROM locations o, locations d WHERE o.name='Bhitarkanika National Park'   AND d.name='BBI Hub - Bhubaneswar';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 300, 250.0 FROM locations o, locations d WHERE o.name='Daringbadi'                   AND d.name='BBI Hub - Bhubaneswar';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 210, 175.0 FROM locations o, locations d WHERE o.name='Gopalpur-on-Sea'              AND d.name='BBI Hub - Bhubaneswar';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  45,  32.0 FROM locations o, locations d WHERE o.name='Barabati Fort'                AND d.name='BBI Hub - Bhubaneswar';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 420, 380.0 FROM locations o, locations d WHERE o.name='Hirakud Dam'                  AND d.name='BBI Hub - Bhubaneswar';

-- ── Bhubaneswar Cluster (LIN / MUK / RAJ / UDA / DHA / NAN) ───────────────
-- Lingaraj ↔ Mukteshwar (1.2 km apart)
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 10,  1.5 FROM locations o, locations d WHERE o.name='Lingaraj Temple' AND d.name='Mukteshwar Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 10,  1.5 FROM locations o, locations d WHERE o.name='Mukteshwar Temple' AND d.name='Lingaraj Temple';
-- Lingaraj ↔ Rajarani (2.5 km)
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 12,  2.5 FROM locations o, locations d WHERE o.name='Lingaraj Temple' AND d.name='Rajarani Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 12,  2.5 FROM locations o, locations d WHERE o.name='Rajarani Temple' AND d.name='Lingaraj Temple';
-- Lingaraj ↔ Udayagiri (7 km)
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 18,  7.0 FROM locations o, locations d WHERE o.name='Lingaraj Temple' AND d.name='Udayagiri & Khandagiri Caves';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 18,  7.0 FROM locations o, locations d WHERE o.name='Udayagiri & Khandagiri Caves' AND d.name='Lingaraj Temple';
-- Lingaraj ↔ Dhauli (8 km)
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 22,  8.0 FROM locations o, locations d WHERE o.name='Lingaraj Temple' AND d.name='Dhauli Peace Pagoda';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 22,  8.0 FROM locations o, locations d WHERE o.name='Dhauli Peace Pagoda' AND d.name='Lingaraj Temple';
-- Lingaraj ↔ Nandankanan (20 km)
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 38, 20.0 FROM locations o, locations d WHERE o.name='Lingaraj Temple' AND d.name='Nandankanan Zoological Park';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 38, 20.0 FROM locations o, locations d WHERE o.name='Nandankanan Zoological Park' AND d.name='Lingaraj Temple';
-- Mukteshwar ↔ Rajarani (2 km)
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 10,  2.0 FROM locations o, locations d WHERE o.name='Mukteshwar Temple' AND d.name='Rajarani Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 10,  2.0 FROM locations o, locations d WHERE o.name='Rajarani Temple' AND d.name='Mukteshwar Temple';
-- Mukteshwar ↔ Udayagiri (8 km)
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 20,  8.0 FROM locations o, locations d WHERE o.name='Mukteshwar Temple' AND d.name='Udayagiri & Khandagiri Caves';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 20,  8.0 FROM locations o, locations d WHERE o.name='Udayagiri & Khandagiri Caves' AND d.name='Mukteshwar Temple';
-- Mukteshwar ↔ Dhauli (9 km)
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 22,  9.0 FROM locations o, locations d WHERE o.name='Mukteshwar Temple' AND d.name='Dhauli Peace Pagoda';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 22,  9.0 FROM locations o, locations d WHERE o.name='Dhauli Peace Pagoda' AND d.name='Mukteshwar Temple';
-- Mukteshwar ↔ Nandankanan (22 km)
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 40, 22.0 FROM locations o, locations d WHERE o.name='Mukteshwar Temple' AND d.name='Nandankanan Zoological Park';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 40, 22.0 FROM locations o, locations d WHERE o.name='Nandankanan Zoological Park' AND d.name='Mukteshwar Temple';
-- Rajarani ↔ Udayagiri (9 km)
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 22,  9.0 FROM locations o, locations d WHERE o.name='Rajarani Temple' AND d.name='Udayagiri & Khandagiri Caves';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 22,  9.0 FROM locations o, locations d WHERE o.name='Udayagiri & Khandagiri Caves' AND d.name='Rajarani Temple';
-- Rajarani ↔ Dhauli (10 km)
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 25, 10.0 FROM locations o, locations d WHERE o.name='Rajarani Temple' AND d.name='Dhauli Peace Pagoda';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 25, 10.0 FROM locations o, locations d WHERE o.name='Dhauli Peace Pagoda' AND d.name='Rajarani Temple';
-- Rajarani ↔ Nandankanan (21 km)
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 40, 21.0 FROM locations o, locations d WHERE o.name='Rajarani Temple' AND d.name='Nandankanan Zoological Park';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 40, 21.0 FROM locations o, locations d WHERE o.name='Nandankanan Zoological Park' AND d.name='Rajarani Temple';
-- Udayagiri ↔ Dhauli (15 km)
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 28, 15.0 FROM locations o, locations d WHERE o.name='Udayagiri & Khandagiri Caves' AND d.name='Dhauli Peace Pagoda';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 28, 15.0 FROM locations o, locations d WHERE o.name='Dhauli Peace Pagoda' AND d.name='Udayagiri & Khandagiri Caves';
-- Udayagiri ↔ Nandankanan (24 km)
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 42, 24.0 FROM locations o, locations d WHERE o.name='Udayagiri & Khandagiri Caves' AND d.name='Nandankanan Zoological Park';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 42, 24.0 FROM locations o, locations d WHERE o.name='Nandankanan Zoological Park' AND d.name='Udayagiri & Khandagiri Caves';
-- Dhauli ↔ Nandankanan (26 km)
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 45, 26.0 FROM locations o, locations d WHERE o.name='Dhauli Peace Pagoda' AND d.name='Nandankanan Zoological Park';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 45, 26.0 FROM locations o, locations d WHERE o.name='Nandankanan Zoological Park' AND d.name='Dhauli Peace Pagoda';

-- ── Puri Cluster (PJT / PBE / KON) ────────────────────────────────────────
-- Puri Jagannath ↔ Puri Beach (1 km)
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  8,  1.0 FROM locations o, locations d WHERE o.name='Puri Jagannath Temple' AND d.name='Puri Beach';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  8,  1.0 FROM locations o, locations d WHERE o.name='Puri Beach' AND d.name='Puri Jagannath Temple';
-- Puri Jagannath ↔ Konark (35 km)
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 50, 35.0 FROM locations o, locations d WHERE o.name='Puri Jagannath Temple' AND d.name='Konark Sun Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 50, 35.0 FROM locations o, locations d WHERE o.name='Konark Sun Temple' AND d.name='Puri Jagannath Temple';
-- Puri Beach ↔ Konark (35 km)
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 50, 35.0 FROM locations o, locations d WHERE o.name='Puri Beach' AND d.name='Konark Sun Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 50, 35.0 FROM locations o, locations d WHERE o.name='Konark Sun Temple' AND d.name='Puri Beach';

-- ── BBI Cluster → Puri Cluster ─────────────────────────────────────────────
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 65, 56.0 FROM locations o, locations d WHERE o.name='Lingaraj Temple'              AND d.name='Puri Jagannath Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 65, 56.0 FROM locations o, locations d WHERE o.name='Puri Jagannath Temple'        AND d.name='Lingaraj Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 68, 58.0 FROM locations o, locations d WHERE o.name='Lingaraj Temple'              AND d.name='Puri Beach';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 68, 58.0 FROM locations o, locations d WHERE o.name='Puri Beach'                   AND d.name='Lingaraj Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 72, 62.0 FROM locations o, locations d WHERE o.name='Lingaraj Temple'              AND d.name='Konark Sun Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 72, 62.0 FROM locations o, locations d WHERE o.name='Konark Sun Temple'            AND d.name='Lingaraj Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 67, 57.0 FROM locations o, locations d WHERE o.name='Mukteshwar Temple'            AND d.name='Puri Jagannath Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 67, 57.0 FROM locations o, locations d WHERE o.name='Puri Jagannath Temple'        AND d.name='Mukteshwar Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 69, 59.0 FROM locations o, locations d WHERE o.name='Mukteshwar Temple'            AND d.name='Puri Beach';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 69, 59.0 FROM locations o, locations d WHERE o.name='Puri Beach'                   AND d.name='Mukteshwar Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 73, 63.0 FROM locations o, locations d WHERE o.name='Mukteshwar Temple'            AND d.name='Konark Sun Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 73, 63.0 FROM locations o, locations d WHERE o.name='Konark Sun Temple'            AND d.name='Mukteshwar Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 66, 56.5 FROM locations o, locations d WHERE o.name='Rajarani Temple'              AND d.name='Puri Jagannath Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 66, 56.5 FROM locations o, locations d WHERE o.name='Puri Jagannath Temple'        AND d.name='Rajarani Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 68, 58.5 FROM locations o, locations d WHERE o.name='Rajarani Temple'              AND d.name='Puri Beach';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 68, 58.5 FROM locations o, locations d WHERE o.name='Puri Beach'                   AND d.name='Rajarani Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 71, 62.0 FROM locations o, locations d WHERE o.name='Rajarani Temple'              AND d.name='Konark Sun Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 71, 62.0 FROM locations o, locations d WHERE o.name='Konark Sun Temple'            AND d.name='Rajarani Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 75, 68.0 FROM locations o, locations d WHERE o.name='Udayagiri & Khandagiri Caves' AND d.name='Puri Jagannath Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 75, 68.0 FROM locations o, locations d WHERE o.name='Puri Jagannath Temple'        AND d.name='Udayagiri & Khandagiri Caves';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 77, 70.0 FROM locations o, locations d WHERE o.name='Udayagiri & Khandagiri Caves' AND d.name='Puri Beach';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 77, 70.0 FROM locations o, locations d WHERE o.name='Puri Beach'                   AND d.name='Udayagiri & Khandagiri Caves';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 68, 65.0 FROM locations o, locations d WHERE o.name='Udayagiri & Khandagiri Caves' AND d.name='Konark Sun Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 68, 65.0 FROM locations o, locations d WHERE o.name='Konark Sun Temple'            AND d.name='Udayagiri & Khandagiri Caves';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 80, 72.0 FROM locations o, locations d WHERE o.name='Dhauli Peace Pagoda'          AND d.name='Puri Jagannath Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 80, 72.0 FROM locations o, locations d WHERE o.name='Puri Jagannath Temple'        AND d.name='Dhauli Peace Pagoda';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 82, 74.0 FROM locations o, locations d WHERE o.name='Dhauli Peace Pagoda'          AND d.name='Puri Beach';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 82, 74.0 FROM locations o, locations d WHERE o.name='Puri Beach'                   AND d.name='Dhauli Peace Pagoda';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 72, 68.0 FROM locations o, locations d WHERE o.name='Dhauli Peace Pagoda'          AND d.name='Konark Sun Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 72, 68.0 FROM locations o, locations d WHERE o.name='Konark Sun Temple'            AND d.name='Dhauli Peace Pagoda';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 90, 78.0 FROM locations o, locations d WHERE o.name='Nandankanan Zoological Park'  AND d.name='Puri Jagannath Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 90, 78.0 FROM locations o, locations d WHERE o.name='Puri Jagannath Temple'        AND d.name='Nandankanan Zoological Park';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 92, 80.0 FROM locations o, locations d WHERE o.name='Nandankanan Zoological Park'  AND d.name='Puri Beach';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 92, 80.0 FROM locations o, locations d WHERE o.name='Puri Beach'                   AND d.name='Nandankanan Zoological Park';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 85, 75.0 FROM locations o, locations d WHERE o.name='Nandankanan Zoological Park'  AND d.name='Konark Sun Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 85, 75.0 FROM locations o, locations d WHERE o.name='Konark Sun Temple'            AND d.name='Nandankanan Zoological Park';

-- ── Chilika / Mangalajodi ──────────────────────────────────────────────────
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 45,  30.0 FROM locations o, locations d WHERE o.name='Chilika Lake Satapada'      AND d.name='Mangalajodi Bird Sanctuary';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 45,  30.0 FROM locations o, locations d WHERE o.name='Mangalajodi Bird Sanctuary' AND d.name='Chilika Lake Satapada';
-- Chilika ↔ Puri cluster
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 100,  80.0 FROM locations o, locations d WHERE o.name='Chilika Lake Satapada' AND d.name='Puri Jagannath Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 100,  80.0 FROM locations o, locations d WHERE o.name='Puri Jagannath Temple' AND d.name='Chilika Lake Satapada';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 102,  82.0 FROM locations o, locations d WHERE o.name='Chilika Lake Satapada' AND d.name='Puri Beach';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 102,  82.0 FROM locations o, locations d WHERE o.name='Puri Beach' AND d.name='Chilika Lake Satapada';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 120, 100.0 FROM locations o, locations d WHERE o.name='Chilika Lake Satapada' AND d.name='Konark Sun Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 120, 100.0 FROM locations o, locations d WHERE o.name='Konark Sun Temple' AND d.name='Chilika Lake Satapada';
-- Mangalajodi ↔ Puri cluster
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 110,  85.0 FROM locations o, locations d WHERE o.name='Mangalajodi Bird Sanctuary' AND d.name='Puri Jagannath Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 110,  85.0 FROM locations o, locations d WHERE o.name='Puri Jagannath Temple' AND d.name='Mangalajodi Bird Sanctuary';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 112,  87.0 FROM locations o, locations d WHERE o.name='Mangalajodi Bird Sanctuary' AND d.name='Puri Beach';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 112,  87.0 FROM locations o, locations d WHERE o.name='Puri Beach' AND d.name='Mangalajodi Bird Sanctuary';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 125,  95.0 FROM locations o, locations d WHERE o.name='Mangalajodi Bird Sanctuary' AND d.name='Konark Sun Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 125,  95.0 FROM locations o, locations d WHERE o.name='Konark Sun Temple' AND d.name='Mangalajodi Bird Sanctuary';
-- Chilika / Mangalajodi ↔ BBI Cluster (all 6 nodes)
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 145, 115.0 FROM locations o, locations d WHERE o.name='Chilika Lake Satapada' AND d.name='Lingaraj Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 145, 115.0 FROM locations o, locations d WHERE o.name='Lingaraj Temple' AND d.name='Chilika Lake Satapada';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 147, 117.0 FROM locations o, locations d WHERE o.name='Chilika Lake Satapada' AND d.name='Mukteshwar Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 147, 117.0 FROM locations o, locations d WHERE o.name='Mukteshwar Temple' AND d.name='Chilika Lake Satapada';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 146, 116.0 FROM locations o, locations d WHERE o.name='Chilika Lake Satapada' AND d.name='Rajarani Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 146, 116.0 FROM locations o, locations d WHERE o.name='Rajarani Temple' AND d.name='Chilika Lake Satapada';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 160, 130.0 FROM locations o, locations d WHERE o.name='Chilika Lake Satapada' AND d.name='Udayagiri & Khandagiri Caves';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 160, 130.0 FROM locations o, locations d WHERE o.name='Udayagiri & Khandagiri Caves' AND d.name='Chilika Lake Satapada';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 165, 135.0 FROM locations o, locations d WHERE o.name='Chilika Lake Satapada' AND d.name='Dhauli Peace Pagoda';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 165, 135.0 FROM locations o, locations d WHERE o.name='Dhauli Peace Pagoda' AND d.name='Chilika Lake Satapada';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 175, 145.0 FROM locations o, locations d WHERE o.name='Chilika Lake Satapada' AND d.name='Nandankanan Zoological Park';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 175, 145.0 FROM locations o, locations d WHERE o.name='Nandankanan Zoological Park' AND d.name='Chilika Lake Satapada';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 135, 105.0 FROM locations o, locations d WHERE o.name='Mangalajodi Bird Sanctuary' AND d.name='Lingaraj Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 135, 105.0 FROM locations o, locations d WHERE o.name='Lingaraj Temple' AND d.name='Mangalajodi Bird Sanctuary';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 137, 107.0 FROM locations o, locations d WHERE o.name='Mangalajodi Bird Sanctuary' AND d.name='Mukteshwar Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 137, 107.0 FROM locations o, locations d WHERE o.name='Mukteshwar Temple' AND d.name='Mangalajodi Bird Sanctuary';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 136, 106.0 FROM locations o, locations d WHERE o.name='Mangalajodi Bird Sanctuary' AND d.name='Rajarani Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 136, 106.0 FROM locations o, locations d WHERE o.name='Rajarani Temple' AND d.name='Mangalajodi Bird Sanctuary';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 150, 120.0 FROM locations o, locations d WHERE o.name='Mangalajodi Bird Sanctuary' AND d.name='Udayagiri & Khandagiri Caves';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 150, 120.0 FROM locations o, locations d WHERE o.name='Udayagiri & Khandagiri Caves' AND d.name='Mangalajodi Bird Sanctuary';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 155, 125.0 FROM locations o, locations d WHERE o.name='Mangalajodi Bird Sanctuary' AND d.name='Dhauli Peace Pagoda';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 155, 125.0 FROM locations o, locations d WHERE o.name='Dhauli Peace Pagoda' AND d.name='Mangalajodi Bird Sanctuary';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 165, 135.0 FROM locations o, locations d WHERE o.name='Mangalajodi Bird Sanctuary' AND d.name='Nandankanan Zoological Park';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 165, 135.0 FROM locations o, locations d WHERE o.name='Nandankanan Zoological Park' AND d.name='Mangalajodi Bird Sanctuary';

-- ── Barabati Fort (Cuttack) ────────────────────────────────────────────────
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  50,  36.0 FROM locations o, locations d WHERE o.name='Barabati Fort' AND d.name='Lingaraj Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  50,  36.0 FROM locations o, locations d WHERE o.name='Lingaraj Temple' AND d.name='Barabati Fort';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  52,  37.0 FROM locations o, locations d WHERE o.name='Barabati Fort' AND d.name='Mukteshwar Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  52,  37.0 FROM locations o, locations d WHERE o.name='Mukteshwar Temple' AND d.name='Barabati Fort';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  51,  36.5 FROM locations o, locations d WHERE o.name='Barabati Fort' AND d.name='Rajarani Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  51,  36.5 FROM locations o, locations d WHERE o.name='Rajarani Temple' AND d.name='Barabati Fort';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  55,  40.0 FROM locations o, locations d WHERE o.name='Barabati Fort' AND d.name='Udayagiri & Khandagiri Caves';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  55,  40.0 FROM locations o, locations d WHERE o.name='Udayagiri & Khandagiri Caves' AND d.name='Barabati Fort';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  57,  42.0 FROM locations o, locations d WHERE o.name='Barabati Fort' AND d.name='Dhauli Peace Pagoda';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  57,  42.0 FROM locations o, locations d WHERE o.name='Dhauli Peace Pagoda' AND d.name='Barabati Fort';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  40,  28.0 FROM locations o, locations d WHERE o.name='Barabati Fort' AND d.name='Nandankanan Zoological Park';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  40,  28.0 FROM locations o, locations d WHERE o.name='Nandankanan Zoological Park' AND d.name='Barabati Fort';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 120,  90.0 FROM locations o, locations d WHERE o.name='Barabati Fort' AND d.name='Puri Jagannath Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 120,  90.0 FROM locations o, locations d WHERE o.name='Puri Jagannath Temple' AND d.name='Barabati Fort';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 122,  92.0 FROM locations o, locations d WHERE o.name='Barabati Fort' AND d.name='Puri Beach';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 122,  92.0 FROM locations o, locations d WHERE o.name='Puri Beach' AND d.name='Barabati Fort';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 115,  98.0 FROM locations o, locations d WHERE o.name='Barabati Fort' AND d.name='Konark Sun Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 115,  98.0 FROM locations o, locations d WHERE o.name='Konark Sun Temple' AND d.name='Barabati Fort';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 180, 150.0 FROM locations o, locations d WHERE o.name='Barabati Fort' AND d.name='Chilika Lake Satapada';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 180, 150.0 FROM locations o, locations d WHERE o.name='Chilika Lake Satapada' AND d.name='Barabati Fort';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 170, 140.0 FROM locations o, locations d WHERE o.name='Barabati Fort' AND d.name='Mangalajodi Bird Sanctuary';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 170, 140.0 FROM locations o, locations d WHERE o.name='Mangalajodi Bird Sanctuary' AND d.name='Barabati Fort';

-- ── Simlipal Biosphere Reserve ─────────────────────────────────────────────
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 355, 275.0 FROM locations o, locations d WHERE o.name='Simlipal Biosphere Reserve' AND d.name='Lingaraj Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 355, 275.0 FROM locations o, locations d WHERE o.name='Lingaraj Temple' AND d.name='Simlipal Biosphere Reserve';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 358, 278.0 FROM locations o, locations d WHERE o.name='Simlipal Biosphere Reserve' AND d.name='Mukteshwar Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 358, 278.0 FROM locations o, locations d WHERE o.name='Mukteshwar Temple' AND d.name='Simlipal Biosphere Reserve';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 356, 276.0 FROM locations o, locations d WHERE o.name='Simlipal Biosphere Reserve' AND d.name='Rajarani Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 356, 276.0 FROM locations o, locations d WHERE o.name='Rajarani Temple' AND d.name='Simlipal Biosphere Reserve';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 363, 283.0 FROM locations o, locations d WHERE o.name='Simlipal Biosphere Reserve' AND d.name='Udayagiri & Khandagiri Caves';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 363, 283.0 FROM locations o, locations d WHERE o.name='Udayagiri & Khandagiri Caves' AND d.name='Simlipal Biosphere Reserve';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 368, 288.0 FROM locations o, locations d WHERE o.name='Simlipal Biosphere Reserve' AND d.name='Dhauli Peace Pagoda';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 368, 288.0 FROM locations o, locations d WHERE o.name='Dhauli Peace Pagoda' AND d.name='Simlipal Biosphere Reserve';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 340, 260.0 FROM locations o, locations d WHERE o.name='Simlipal Biosphere Reserve' AND d.name='Nandankanan Zoological Park';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 340, 260.0 FROM locations o, locations d WHERE o.name='Nandankanan Zoological Park' AND d.name='Simlipal Biosphere Reserve';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 420, 330.0 FROM locations o, locations d WHERE o.name='Simlipal Biosphere Reserve' AND d.name='Puri Jagannath Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 420, 330.0 FROM locations o, locations d WHERE o.name='Puri Jagannath Temple' AND d.name='Simlipal Biosphere Reserve';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 422, 332.0 FROM locations o, locations d WHERE o.name='Simlipal Biosphere Reserve' AND d.name='Puri Beach';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 422, 332.0 FROM locations o, locations d WHERE o.name='Puri Beach' AND d.name='Simlipal Biosphere Reserve';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 430, 338.0 FROM locations o, locations d WHERE o.name='Simlipal Biosphere Reserve' AND d.name='Konark Sun Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 430, 338.0 FROM locations o, locations d WHERE o.name='Konark Sun Temple' AND d.name='Simlipal Biosphere Reserve';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 450, 360.0 FROM locations o, locations d WHERE o.name='Simlipal Biosphere Reserve' AND d.name='Chilika Lake Satapada';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 450, 360.0 FROM locations o, locations d WHERE o.name='Chilika Lake Satapada' AND d.name='Simlipal Biosphere Reserve';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 455, 365.0 FROM locations o, locations d WHERE o.name='Simlipal Biosphere Reserve' AND d.name='Mangalajodi Bird Sanctuary';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 455, 365.0 FROM locations o, locations d WHERE o.name='Mangalajodi Bird Sanctuary' AND d.name='Simlipal Biosphere Reserve';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 210, 150.0 FROM locations o, locations d WHERE o.name='Simlipal Biosphere Reserve' AND d.name='Bhitarkanika National Park';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 210, 150.0 FROM locations o, locations d WHERE o.name='Bhitarkanika National Park' AND d.name='Simlipal Biosphere Reserve';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 320, 265.0 FROM locations o, locations d WHERE o.name='Simlipal Biosphere Reserve' AND d.name='Barabati Fort';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 320, 265.0 FROM locations o, locations d WHERE o.name='Barabati Fort' AND d.name='Simlipal Biosphere Reserve';

-- ── Bhitarkanika National Park ─────────────────────────────────────────────
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 265, 195.0 FROM locations o, locations d WHERE o.name='Bhitarkanika National Park' AND d.name='Lingaraj Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 265, 195.0 FROM locations o, locations d WHERE o.name='Lingaraj Temple' AND d.name='Bhitarkanika National Park';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 268, 198.0 FROM locations o, locations d WHERE o.name='Bhitarkanika National Park' AND d.name='Mukteshwar Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 268, 198.0 FROM locations o, locations d WHERE o.name='Mukteshwar Temple' AND d.name='Bhitarkanika National Park';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 266, 196.0 FROM locations o, locations d WHERE o.name='Bhitarkanika National Park' AND d.name='Rajarani Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 266, 196.0 FROM locations o, locations d WHERE o.name='Rajarani Temple' AND d.name='Bhitarkanika National Park';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 273, 203.0 FROM locations o, locations d WHERE o.name='Bhitarkanika National Park' AND d.name='Udayagiri & Khandagiri Caves';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 273, 203.0 FROM locations o, locations d WHERE o.name='Udayagiri & Khandagiri Caves' AND d.name='Bhitarkanika National Park';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 278, 208.0 FROM locations o, locations d WHERE o.name='Bhitarkanika National Park' AND d.name='Dhauli Peace Pagoda';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 278, 208.0 FROM locations o, locations d WHERE o.name='Dhauli Peace Pagoda' AND d.name='Bhitarkanika National Park';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 250, 180.0 FROM locations o, locations d WHERE o.name='Bhitarkanika National Park' AND d.name='Nandankanan Zoological Park';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 250, 180.0 FROM locations o, locations d WHERE o.name='Nandankanan Zoological Park' AND d.name='Bhitarkanika National Park';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 330, 260.0 FROM locations o, locations d WHERE o.name='Bhitarkanika National Park' AND d.name='Puri Jagannath Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 330, 260.0 FROM locations o, locations d WHERE o.name='Puri Jagannath Temple' AND d.name='Bhitarkanika National Park';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 332, 262.0 FROM locations o, locations d WHERE o.name='Bhitarkanika National Park' AND d.name='Puri Beach';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 332, 262.0 FROM locations o, locations d WHERE o.name='Puri Beach' AND d.name='Bhitarkanika National Park';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 320, 255.0 FROM locations o, locations d WHERE o.name='Bhitarkanika National Park' AND d.name='Konark Sun Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 320, 255.0 FROM locations o, locations d WHERE o.name='Konark Sun Temple' AND d.name='Bhitarkanika National Park';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 360, 290.0 FROM locations o, locations d WHERE o.name='Bhitarkanika National Park' AND d.name='Chilika Lake Satapada';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 360, 290.0 FROM locations o, locations d WHERE o.name='Chilika Lake Satapada' AND d.name='Bhitarkanika National Park';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 355, 285.0 FROM locations o, locations d WHERE o.name='Bhitarkanika National Park' AND d.name='Mangalajodi Bird Sanctuary';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 355, 285.0 FROM locations o, locations d WHERE o.name='Mangalajodi Bird Sanctuary' AND d.name='Bhitarkanika National Park';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 230, 165.0 FROM locations o, locations d WHERE o.name='Bhitarkanika National Park' AND d.name='Barabati Fort';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 230, 165.0 FROM locations o, locations d WHERE o.name='Barabati Fort' AND d.name='Bhitarkanika National Park';

-- ── Daringbadi ─────────────────────────────────────────────────────────────
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 295, 245.0 FROM locations o, locations d WHERE o.name='Daringbadi' AND d.name='Lingaraj Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 295, 245.0 FROM locations o, locations d WHERE o.name='Lingaraj Temple' AND d.name='Daringbadi';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 297, 247.0 FROM locations o, locations d WHERE o.name='Daringbadi' AND d.name='Mukteshwar Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 297, 247.0 FROM locations o, locations d WHERE o.name='Mukteshwar Temple' AND d.name='Daringbadi';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 296, 246.0 FROM locations o, locations d WHERE o.name='Daringbadi' AND d.name='Rajarani Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 296, 246.0 FROM locations o, locations d WHERE o.name='Rajarani Temple' AND d.name='Daringbadi';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 305, 255.0 FROM locations o, locations d WHERE o.name='Daringbadi' AND d.name='Udayagiri & Khandagiri Caves';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 305, 255.0 FROM locations o, locations d WHERE o.name='Udayagiri & Khandagiri Caves' AND d.name='Daringbadi';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 290, 240.0 FROM locations o, locations d WHERE o.name='Daringbadi' AND d.name='Dhauli Peace Pagoda';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 290, 240.0 FROM locations o, locations d WHERE o.name='Dhauli Peace Pagoda' AND d.name='Daringbadi';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 320, 265.0 FROM locations o, locations d WHERE o.name='Daringbadi' AND d.name='Nandankanan Zoological Park';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 320, 265.0 FROM locations o, locations d WHERE o.name='Nandankanan Zoological Park' AND d.name='Daringbadi';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 250, 200.0 FROM locations o, locations d WHERE o.name='Daringbadi' AND d.name='Puri Jagannath Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 250, 200.0 FROM locations o, locations d WHERE o.name='Puri Jagannath Temple' AND d.name='Daringbadi';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 252, 202.0 FROM locations o, locations d WHERE o.name='Daringbadi' AND d.name='Puri Beach';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 252, 202.0 FROM locations o, locations d WHERE o.name='Puri Beach' AND d.name='Daringbadi';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 270, 215.0 FROM locations o, locations d WHERE o.name='Daringbadi' AND d.name='Konark Sun Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 270, 215.0 FROM locations o, locations d WHERE o.name='Konark Sun Temple' AND d.name='Daringbadi';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 210, 170.0 FROM locations o, locations d WHERE o.name='Daringbadi' AND d.name='Chilika Lake Satapada';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 210, 170.0 FROM locations o, locations d WHERE o.name='Chilika Lake Satapada' AND d.name='Daringbadi';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 220, 180.0 FROM locations o, locations d WHERE o.name='Daringbadi' AND d.name='Mangalajodi Bird Sanctuary';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 220, 180.0 FROM locations o, locations d WHERE o.name='Mangalajodi Bird Sanctuary' AND d.name='Daringbadi';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 500, 420.0 FROM locations o, locations d WHERE o.name='Daringbadi' AND d.name='Simlipal Biosphere Reserve';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 500, 420.0 FROM locations o, locations d WHERE o.name='Simlipal Biosphere Reserve' AND d.name='Daringbadi';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 480, 400.0 FROM locations o, locations d WHERE o.name='Daringbadi' AND d.name='Bhitarkanika National Park';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 480, 400.0 FROM locations o, locations d WHERE o.name='Bhitarkanika National Park' AND d.name='Daringbadi';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 160, 130.0 FROM locations o, locations d WHERE o.name='Daringbadi' AND d.name='Gopalpur-on-Sea';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 160, 130.0 FROM locations o, locations d WHERE o.name='Gopalpur-on-Sea' AND d.name='Daringbadi';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 330, 275.0 FROM locations o, locations d WHERE o.name='Daringbadi' AND d.name='Barabati Fort';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 330, 275.0 FROM locations o, locations d WHERE o.name='Barabati Fort' AND d.name='Daringbadi';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 480, 440.0 FROM locations o, locations d WHERE o.name='Daringbadi' AND d.name='Hirakud Dam';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 480, 440.0 FROM locations o, locations d WHERE o.name='Hirakud Dam' AND d.name='Daringbadi';

-- ── Gopalpur-on-Sea ────────────────────────────────────────────────────────
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 205, 170.0 FROM locations o, locations d WHERE o.name='Gopalpur-on-Sea' AND d.name='Lingaraj Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 205, 170.0 FROM locations o, locations d WHERE o.name='Lingaraj Temple' AND d.name='Gopalpur-on-Sea';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 207, 172.0 FROM locations o, locations d WHERE o.name='Gopalpur-on-Sea' AND d.name='Mukteshwar Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 207, 172.0 FROM locations o, locations d WHERE o.name='Mukteshwar Temple' AND d.name='Gopalpur-on-Sea';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 206, 171.0 FROM locations o, locations d WHERE o.name='Gopalpur-on-Sea' AND d.name='Rajarani Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 206, 171.0 FROM locations o, locations d WHERE o.name='Rajarani Temple' AND d.name='Gopalpur-on-Sea';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 215, 180.0 FROM locations o, locations d WHERE o.name='Gopalpur-on-Sea' AND d.name='Udayagiri & Khandagiri Caves';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 215, 180.0 FROM locations o, locations d WHERE o.name='Udayagiri & Khandagiri Caves' AND d.name='Gopalpur-on-Sea';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 200, 165.0 FROM locations o, locations d WHERE o.name='Gopalpur-on-Sea' AND d.name='Dhauli Peace Pagoda';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 200, 165.0 FROM locations o, locations d WHERE o.name='Dhauli Peace Pagoda' AND d.name='Gopalpur-on-Sea';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 225, 190.0 FROM locations o, locations d WHERE o.name='Gopalpur-on-Sea' AND d.name='Nandankanan Zoological Park';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 225, 190.0 FROM locations o, locations d WHERE o.name='Nandankanan Zoological Park' AND d.name='Gopalpur-on-Sea';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 160, 125.0 FROM locations o, locations d WHERE o.name='Gopalpur-on-Sea' AND d.name='Puri Jagannath Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 160, 125.0 FROM locations o, locations d WHERE o.name='Puri Jagannath Temple' AND d.name='Gopalpur-on-Sea';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 162, 127.0 FROM locations o, locations d WHERE o.name='Gopalpur-on-Sea' AND d.name='Puri Beach';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 162, 127.0 FROM locations o, locations d WHERE o.name='Puri Beach' AND d.name='Gopalpur-on-Sea';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 175, 140.0 FROM locations o, locations d WHERE o.name='Gopalpur-on-Sea' AND d.name='Konark Sun Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 175, 140.0 FROM locations o, locations d WHERE o.name='Konark Sun Temple' AND d.name='Gopalpur-on-Sea';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 140, 110.0 FROM locations o, locations d WHERE o.name='Gopalpur-on-Sea' AND d.name='Chilika Lake Satapada';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 140, 110.0 FROM locations o, locations d WHERE o.name='Chilika Lake Satapada' AND d.name='Gopalpur-on-Sea';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 150, 120.0 FROM locations o, locations d WHERE o.name='Gopalpur-on-Sea' AND d.name='Mangalajodi Bird Sanctuary';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 150, 120.0 FROM locations o, locations d WHERE o.name='Mangalajodi Bird Sanctuary' AND d.name='Gopalpur-on-Sea';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 560, 470.0 FROM locations o, locations d WHERE o.name='Gopalpur-on-Sea' AND d.name='Simlipal Biosphere Reserve';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 560, 470.0 FROM locations o, locations d WHERE o.name='Simlipal Biosphere Reserve' AND d.name='Gopalpur-on-Sea';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 480, 400.0 FROM locations o, locations d WHERE o.name='Gopalpur-on-Sea' AND d.name='Bhitarkanika National Park';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 480, 400.0 FROM locations o, locations d WHERE o.name='Bhitarkanika National Park' AND d.name='Gopalpur-on-Sea';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 240, 195.0 FROM locations o, locations d WHERE o.name='Gopalpur-on-Sea' AND d.name='Barabati Fort';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 240, 195.0 FROM locations o, locations d WHERE o.name='Barabati Fort' AND d.name='Gopalpur-on-Sea';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 580, 510.0 FROM locations o, locations d WHERE o.name='Gopalpur-on-Sea' AND d.name='Hirakud Dam';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 580, 510.0 FROM locations o, locations d WHERE o.name='Hirakud Dam' AND d.name='Gopalpur-on-Sea';

-- ── Hirakud Dam ─────────────────────────────────────────────────────────────
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 415, 375.0 FROM locations o, locations d WHERE o.name='Hirakud Dam' AND d.name='Lingaraj Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 415, 375.0 FROM locations o, locations d WHERE o.name='Lingaraj Temple' AND d.name='Hirakud Dam';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 418, 378.0 FROM locations o, locations d WHERE o.name='Hirakud Dam' AND d.name='Mukteshwar Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 418, 378.0 FROM locations o, locations d WHERE o.name='Mukteshwar Temple' AND d.name='Hirakud Dam';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 416, 376.0 FROM locations o, locations d WHERE o.name='Hirakud Dam' AND d.name='Rajarani Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 416, 376.0 FROM locations o, locations d WHERE o.name='Rajarani Temple' AND d.name='Hirakud Dam';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 422, 382.0 FROM locations o, locations d WHERE o.name='Hirakud Dam' AND d.name='Udayagiri & Khandagiri Caves';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 422, 382.0 FROM locations o, locations d WHERE o.name='Udayagiri & Khandagiri Caves' AND d.name='Hirakud Dam';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 425, 385.0 FROM locations o, locations d WHERE o.name='Hirakud Dam' AND d.name='Dhauli Peace Pagoda';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 425, 385.0 FROM locations o, locations d WHERE o.name='Dhauli Peace Pagoda' AND d.name='Hirakud Dam';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 400, 360.0 FROM locations o, locations d WHERE o.name='Hirakud Dam' AND d.name='Nandankanan Zoological Park';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 400, 360.0 FROM locations o, locations d WHERE o.name='Nandankanan Zoological Park' AND d.name='Hirakud Dam';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 490, 440.0 FROM locations o, locations d WHERE o.name='Hirakud Dam' AND d.name='Puri Jagannath Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 490, 440.0 FROM locations o, locations d WHERE o.name='Puri Jagannath Temple' AND d.name='Hirakud Dam';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 492, 442.0 FROM locations o, locations d WHERE o.name='Hirakud Dam' AND d.name='Puri Beach';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 492, 442.0 FROM locations o, locations d WHERE o.name='Puri Beach' AND d.name='Hirakud Dam';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 480, 435.0 FROM locations o, locations d WHERE o.name='Hirakud Dam' AND d.name='Konark Sun Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 480, 435.0 FROM locations o, locations d WHERE o.name='Konark Sun Temple' AND d.name='Hirakud Dam';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 530, 480.0 FROM locations o, locations d WHERE o.name='Hirakud Dam' AND d.name='Chilika Lake Satapada';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 530, 480.0 FROM locations o, locations d WHERE o.name='Chilika Lake Satapada' AND d.name='Hirakud Dam';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 540, 490.0 FROM locations o, locations d WHERE o.name='Hirakud Dam' AND d.name='Mangalajodi Bird Sanctuary';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 540, 490.0 FROM locations o, locations d WHERE o.name='Mangalajodi Bird Sanctuary' AND d.name='Hirakud Dam';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 320, 285.0 FROM locations o, locations d WHERE o.name='Hirakud Dam' AND d.name='Simlipal Biosphere Reserve';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 320, 285.0 FROM locations o, locations d WHERE o.name='Simlipal Biosphere Reserve' AND d.name='Hirakud Dam';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 540, 485.0 FROM locations o, locations d WHERE o.name='Hirakud Dam' AND d.name='Bhitarkanika National Park';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 540, 485.0 FROM locations o, locations d WHERE o.name='Bhitarkanika National Park' AND d.name='Hirakud Dam';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 390, 350.0 FROM locations o, locations d WHERE o.name='Hirakud Dam' AND d.name='Barabati Fort';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 390, 350.0 FROM locations o, locations d WHERE o.name='Barabati Fort' AND d.name='Hirakud Dam';

COMMIT;
