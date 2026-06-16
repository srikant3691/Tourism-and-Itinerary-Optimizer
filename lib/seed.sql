-- ============================================================
-- seed.sql  --  Odisha Tourist Planner  (18 locations)
-- ============================================================

BEGIN;

-- ============================================================
-- 1. LOCATIONS
-- ============================================================
INSERT INTO locations (name, latitude, longitude, category, avg_time_spent, open_time, close_time, cost_score, description) VALUES
  ('BBI Hub - Bhubaneswar',         20.2961,  85.8245, 'heritage',     30,  '00:00', '23:59', 1, 'Bhubaneswar railway station hub, main transit point of the state capital.'),
  ('Lingaraj Temple',               20.2384,  85.8340, 'temple',       90,  '06:00', '21:00', 1, 'Ancient 11th-century Shiva temple, the largest temple in Bhubaneswar.'),
  ('Mukteshwar Temple',             20.2440,  85.8282, 'temple',       60,  '06:00', '20:00', 1, 'A 10th-century Shiva temple renowned for its ornate torana archway.'),
  ('Rajarani Temple',               20.2554,  85.8463, 'temple',       60,  '08:00', '18:00', 1, 'A 11th-century temple famed for its erotic sculptures and tower carvings.'),
  ('Udayagiri & Khandagiri Caves',  20.2709,  85.7804, 'heritage',     90,  '08:00', '18:00', 1, 'Ancient Jain rock-cut caves dating from the 2nd century BCE.'),
  ('Dhauli Peace Pagoda',           20.1874,  85.8513, 'heritage',     60,  '07:00', '19:00', 1, 'Buddhist peace pagoda built at the site of the Kalinga War in 261 BCE.'),
  ('Nandankanan Zoological Park',   20.3996,  85.8219, 'wildlife',    180,  '08:00', '17:00', 2, 'Famous zoo and botanical garden home to white tigers and Indian pangolins.'),
  ('Puri Jagannath Temple',         19.8048,  85.8181, 'temple',      120,  '05:00', '21:00', 1, 'Iconic 12th-century temple dedicated to Lord Jagannath, one of the Char Dhams.'),
  ('Puri Beach',                    19.7983,  85.8245, 'beach',       120,  '06:00', '20:00', 1, 'One of the finest beaches on the Bay of Bengal with golden sands.'),
  ('Konark Sun Temple',             19.8876,  86.0945, 'heritage',    120,  '06:00', '20:00', 2, 'UNESCO World Heritage 13th-century Sun Temple shaped like a colossal chariot.'),
  ('Chilika Lake Satapada',         19.7177,  85.4320, 'lake',        180,  '06:00', '18:00', 3, 'Asia''s largest brackish lagoon, home to Irrawaddy dolphins and flamingos.'),
  ('Mangalajodi Bird Sanctuary',    20.0247,  85.2013, 'wildlife',    150,  '06:00', '17:00', 3, 'Premier birding destination on Chilika Lake''s northern shore; 200+ species.'),
  ('Simlipal Biosphere Reserve',    21.8356,  86.5144, 'wildlife',    360,  '06:00', '16:00', 4, 'UNESCO biosphere reserve covering 2750 sq km of sal forest with tigers and elephants.'),
  ('Bhitarkanika National Park',    20.7236,  86.8808, 'wildlife',    300,  '06:00', '16:00', 4, 'Ramsar wetland known for saltwater crocodiles and vast mangrove forests.'),
  ('Daringbadi',                    20.0543,  84.3925, 'hill_station',240,  '07:00', '18:00', 2, 'Called the Kashmir of Odisha; a cool hill station with coffee plantations.'),
  ('Gopalpur-on-Sea',               19.2627,  84.9129, 'beach',       180,  '06:00', '20:00', 2, 'Tranquil seaside town on the Bay of Bengal with a historic lighthouse.'),
  ('Barabati Fort',                 20.4686,  85.8792, 'fort',         90,  '08:00', '17:00', 1, '14th-century fort of the Ganga dynasty in Cuttack beside the Mahanadi river.'),
  ('Hirakud Dam',                   21.5247,  83.8710, 'heritage',    120,  '07:00', '18:00', 2, 'World''s longest earthen dam across the Mahanadi river, built in 1957.');

-- ============================================================
-- 2. BEHAVIORAL PROFILES
-- ============================================================
INSERT INTO behavioral_profiles (location_id, culture_score, nature_score, relax_score, adventure_score)
SELECT id,  3,  2, 3, 2 FROM locations WHERE name = 'BBI Hub - Bhubaneswar';

INSERT INTO behavioral_profiles (location_id, culture_score, nature_score, relax_score, adventure_score)
SELECT id, 10,  2, 4, 1 FROM locations WHERE name = 'Lingaraj Temple';

INSERT INTO behavioral_profiles (location_id, culture_score, nature_score, relax_score, adventure_score)
SELECT id,  9,  3, 5, 1 FROM locations WHERE name = 'Mukteshwar Temple';

INSERT INTO behavioral_profiles (location_id, culture_score, nature_score, relax_score, adventure_score)
SELECT id,  8,  2, 5, 1 FROM locations WHERE name = 'Rajarani Temple';

INSERT INTO behavioral_profiles (location_id, culture_score, nature_score, relax_score, adventure_score)
SELECT id,  9,  3, 4, 2 FROM locations WHERE name = 'Udayagiri & Khandagiri Caves';

INSERT INTO behavioral_profiles (location_id, culture_score, nature_score, relax_score, adventure_score)
SELECT id,  8,  4, 6, 1 FROM locations WHERE name = 'Dhauli Peace Pagoda';

INSERT INTO behavioral_profiles (location_id, culture_score, nature_score, relax_score, adventure_score)
SELECT id,  3,  9, 5, 4 FROM locations WHERE name = 'Nandankanan Zoological Park';

INSERT INTO behavioral_profiles (location_id, culture_score, nature_score, relax_score, adventure_score)
SELECT id, 10,  2, 5, 1 FROM locations WHERE name = 'Puri Jagannath Temple';

INSERT INTO behavioral_profiles (location_id, culture_score, nature_score, relax_score, adventure_score)
SELECT id,  3,  6, 9, 5 FROM locations WHERE name = 'Puri Beach';

INSERT INTO behavioral_profiles (location_id, culture_score, nature_score, relax_score, adventure_score)
SELECT id, 10,  3, 4, 2 FROM locations WHERE name = 'Konark Sun Temple';

INSERT INTO behavioral_profiles (location_id, culture_score, nature_score, relax_score, adventure_score)
SELECT id,  3, 10, 8, 5 FROM locations WHERE name = 'Chilika Lake Satapada';

INSERT INTO behavioral_profiles (location_id, culture_score, nature_score, relax_score, adventure_score)
SELECT id,  2, 10, 7, 4 FROM locations WHERE name = 'Mangalajodi Bird Sanctuary';

INSERT INTO behavioral_profiles (location_id, culture_score, nature_score, relax_score, adventure_score)
SELECT id,  2, 10, 6, 9 FROM locations WHERE name = 'Simlipal Biosphere Reserve';

INSERT INTO behavioral_profiles (location_id, culture_score, nature_score, relax_score, adventure_score)
SELECT id,  3, 10, 5, 8 FROM locations WHERE name = 'Bhitarkanika National Park';

INSERT INTO behavioral_profiles (location_id, culture_score, nature_score, relax_score, adventure_score)
SELECT id,  4,  9, 8, 7 FROM locations WHERE name = 'Daringbadi';

INSERT INTO behavioral_profiles (location_id, culture_score, nature_score, relax_score, adventure_score)
SELECT id,  2,  7, 9, 5 FROM locations WHERE name = 'Gopalpur-on-Sea';

INSERT INTO behavioral_profiles (location_id, culture_score, nature_score, relax_score, adventure_score)
SELECT id,  8,  2, 4, 2 FROM locations WHERE name = 'Barabati Fort';

INSERT INTO behavioral_profiles (location_id, culture_score, nature_score, relax_score, adventure_score)
SELECT id,  5,  7, 5, 4 FROM locations WHERE name = 'Hirakud Dam';

-- ============================================================
-- 3. TRAVEL MATRIX  (306 directed pairs, both directions)
-- ============================================================

-- ---- FROM: BBI Hub - Bhubaneswar ----
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  15,   5.0 FROM locations o, locations d WHERE o.name = 'BBI Hub - Bhubaneswar' AND d.name = 'Lingaraj Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  20,   7.0 FROM locations o, locations d WHERE o.name = 'BBI Hub - Bhubaneswar' AND d.name = 'Mukteshwar Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  18,   6.0 FROM locations o, locations d WHERE o.name = 'BBI Hub - Bhubaneswar' AND d.name = 'Rajarani Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  22,  10.0 FROM locations o, locations d WHERE o.name = 'BBI Hub - Bhubaneswar' AND d.name = 'Udayagiri & Khandagiri Caves';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  25,  12.0 FROM locations o, locations d WHERE o.name = 'BBI Hub - Bhubaneswar' AND d.name = 'Dhauli Peace Pagoda';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  35,  18.0 FROM locations o, locations d WHERE o.name = 'BBI Hub - Bhubaneswar' AND d.name = 'Nandankanan Zoological Park';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  75,  60.0 FROM locations o, locations d WHERE o.name = 'BBI Hub - Bhubaneswar' AND d.name = 'Puri Jagannath Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  77,  62.0 FROM locations o, locations d WHERE o.name = 'BBI Hub - Bhubaneswar' AND d.name = 'Puri Beach';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  80,  65.0 FROM locations o, locations d WHERE o.name = 'BBI Hub - Bhubaneswar' AND d.name = 'Konark Sun Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 150, 120.0 FROM locations o, locations d WHERE o.name = 'BBI Hub - Bhubaneswar' AND d.name = 'Chilika Lake Satapada';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 140, 110.0 FROM locations o, locations d WHERE o.name = 'BBI Hub - Bhubaneswar' AND d.name = 'Mangalajodi Bird Sanctuary';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 360, 280.0 FROM locations o, locations d WHERE o.name = 'BBI Hub - Bhubaneswar' AND d.name = 'Simlipal Biosphere Reserve';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 270, 200.0 FROM locations o, locations d WHERE o.name = 'BBI Hub - Bhubaneswar' AND d.name = 'Bhitarkanika National Park';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 300, 250.0 FROM locations o, locations d WHERE o.name = 'BBI Hub - Bhubaneswar' AND d.name = 'Daringbadi';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 210, 175.0 FROM locations o, locations d WHERE o.name = 'BBI Hub - Bhubaneswar' AND d.name = 'Gopalpur-on-Sea';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  45,  32.0 FROM locations o, locations d WHERE o.name = 'BBI Hub - Bhubaneswar' AND d.name = 'Barabati Fort';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 420, 380.0 FROM locations o, locations d WHERE o.name = 'BBI Hub - Bhubaneswar' AND d.name = 'Hirakud Dam';

-- ---- FROM: Lingaraj Temple ----
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  15,   5.0 FROM locations o, locations d WHERE o.name = 'Lingaraj Temple' AND d.name = 'BBI Hub - Bhubaneswar';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  10,   1.5 FROM locations o, locations d WHERE o.name = 'Lingaraj Temple' AND d.name = 'Mukteshwar Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  15,   3.0 FROM locations o, locations d WHERE o.name = 'Lingaraj Temple' AND d.name = 'Rajarani Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  20,   7.0 FROM locations o, locations d WHERE o.name = 'Lingaraj Temple' AND d.name = 'Udayagiri & Khandagiri Caves';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  25,   9.0 FROM locations o, locations d WHERE o.name = 'Lingaraj Temple' AND d.name = 'Dhauli Peace Pagoda';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  35,  18.0 FROM locations o, locations d WHERE o.name = 'Lingaraj Temple' AND d.name = 'Nandankanan Zoological Park';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  80,  62.0 FROM locations o, locations d WHERE o.name = 'Lingaraj Temple' AND d.name = 'Puri Jagannath Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  82,  63.0 FROM locations o, locations d WHERE o.name = 'Lingaraj Temple' AND d.name = 'Puri Beach';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  85,  67.0 FROM locations o, locations d WHERE o.name = 'Lingaraj Temple' AND d.name = 'Konark Sun Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 155, 122.0 FROM locations o, locations d WHERE o.name = 'Lingaraj Temple' AND d.name = 'Chilika Lake Satapada';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 145, 112.0 FROM locations o, locations d WHERE o.name = 'Lingaraj Temple' AND d.name = 'Mangalajodi Bird Sanctuary';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 365, 282.0 FROM locations o, locations d WHERE o.name = 'Lingaraj Temple' AND d.name = 'Simlipal Biosphere Reserve';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 275, 202.0 FROM locations o, locations d WHERE o.name = 'Lingaraj Temple' AND d.name = 'Bhitarkanika National Park';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 305, 252.0 FROM locations o, locations d WHERE o.name = 'Lingaraj Temple' AND d.name = 'Daringbadi';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 215, 177.0 FROM locations o, locations d WHERE o.name = 'Lingaraj Temple' AND d.name = 'Gopalpur-on-Sea';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  50,  34.0 FROM locations o, locations d WHERE o.name = 'Lingaraj Temple' AND d.name = 'Barabati Fort';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 425, 382.0 FROM locations o, locations d WHERE o.name = 'Lingaraj Temple' AND d.name = 'Hirakud Dam';

-- ---- FROM: Mukteshwar Temple ----
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  20,   7.0 FROM locations o, locations d WHERE o.name = 'Mukteshwar Temple' AND d.name = 'BBI Hub - Bhubaneswar';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  10,   1.5 FROM locations o, locations d WHERE o.name = 'Mukteshwar Temple' AND d.name = 'Lingaraj Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  12,   2.5 FROM locations o, locations d WHERE o.name = 'Mukteshwar Temple' AND d.name = 'Rajarani Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  22,   7.5 FROM locations o, locations d WHERE o.name = 'Mukteshwar Temple' AND d.name = 'Udayagiri & Khandagiri Caves';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  28,  10.0 FROM locations o, locations d WHERE o.name = 'Mukteshwar Temple' AND d.name = 'Dhauli Peace Pagoda';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  38,  19.0 FROM locations o, locations d WHERE o.name = 'Mukteshwar Temple' AND d.name = 'Nandankanan Zoological Park';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  82,  63.0 FROM locations o, locations d WHERE o.name = 'Mukteshwar Temple' AND d.name = 'Puri Jagannath Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  84,  64.0 FROM locations o, locations d WHERE o.name = 'Mukteshwar Temple' AND d.name = 'Puri Beach';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  87,  68.0 FROM locations o, locations d WHERE o.name = 'Mukteshwar Temple' AND d.name = 'Konark Sun Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 158, 123.0 FROM locations o, locations d WHERE o.name = 'Mukteshwar Temple' AND d.name = 'Chilika Lake Satapada';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 148, 113.0 FROM locations o, locations d WHERE o.name = 'Mukteshwar Temple' AND d.name = 'Mangalajodi Bird Sanctuary';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 368, 283.0 FROM locations o, locations d WHERE o.name = 'Mukteshwar Temple' AND d.name = 'Simlipal Biosphere Reserve';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 278, 203.0 FROM locations o, locations d WHERE o.name = 'Mukteshwar Temple' AND d.name = 'Bhitarkanika National Park';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 308, 253.0 FROM locations o, locations d WHERE o.name = 'Mukteshwar Temple' AND d.name = 'Daringbadi';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 218, 178.0 FROM locations o, locations d WHERE o.name = 'Mukteshwar Temple' AND d.name = 'Gopalpur-on-Sea';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  52,  35.0 FROM locations o, locations d WHERE o.name = 'Mukteshwar Temple' AND d.name = 'Barabati Fort';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 428, 383.0 FROM locations o, locations d WHERE o.name = 'Mukteshwar Temple' AND d.name = 'Hirakud Dam';

-- ---- FROM: Rajarani Temple ----
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  18,   6.0 FROM locations o, locations d WHERE o.name = 'Rajarani Temple' AND d.name = 'BBI Hub - Bhubaneswar';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  15,   3.0 FROM locations o, locations d WHERE o.name = 'Rajarani Temple' AND d.name = 'Lingaraj Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  12,   2.5 FROM locations o, locations d WHERE o.name = 'Rajarani Temple' AND d.name = 'Mukteshwar Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  20,   8.0 FROM locations o, locations d WHERE o.name = 'Rajarani Temple' AND d.name = 'Udayagiri & Khandagiri Caves';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  22,   8.5 FROM locations o, locations d WHERE o.name = 'Rajarani Temple' AND d.name = 'Dhauli Peace Pagoda';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  35,  17.0 FROM locations o, locations d WHERE o.name = 'Rajarani Temple' AND d.name = 'Nandankanan Zoological Park';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  80,  61.0 FROM locations o, locations d WHERE o.name = 'Rajarani Temple' AND d.name = 'Puri Jagannath Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  82,  62.0 FROM locations o, locations d WHERE o.name = 'Rajarani Temple' AND d.name = 'Puri Beach';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  85,  66.0 FROM locations o, locations d WHERE o.name = 'Rajarani Temple' AND d.name = 'Konark Sun Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 152, 121.0 FROM locations o, locations d WHERE o.name = 'Rajarani Temple' AND d.name = 'Chilika Lake Satapada';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 142, 111.0 FROM locations o, locations d WHERE o.name = 'Rajarani Temple' AND d.name = 'Mangalajodi Bird Sanctuary';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 362, 281.0 FROM locations o, locations d WHERE o.name = 'Rajarani Temple' AND d.name = 'Simlipal Biosphere Reserve';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 272, 201.0 FROM locations o, locations d WHERE o.name = 'Rajarani Temple' AND d.name = 'Bhitarkanika National Park';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 303, 251.0 FROM locations o, locations d WHERE o.name = 'Rajarani Temple' AND d.name = 'Daringbadi';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 213, 176.0 FROM locations o, locations d WHERE o.name = 'Rajarani Temple' AND d.name = 'Gopalpur-on-Sea';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  48,  33.0 FROM locations o, locations d WHERE o.name = 'Rajarani Temple' AND d.name = 'Barabati Fort';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 422, 381.0 FROM locations o, locations d WHERE o.name = 'Rajarani Temple' AND d.name = 'Hirakud Dam';

-- ---- FROM: Udayagiri & Khandagiri Caves ----
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  22,  10.0 FROM locations o, locations d WHERE o.name = 'Udayagiri & Khandagiri Caves' AND d.name = 'BBI Hub - Bhubaneswar';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  20,   7.0 FROM locations o, locations d WHERE o.name = 'Udayagiri & Khandagiri Caves' AND d.name = 'Lingaraj Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  22,   7.5 FROM locations o, locations d WHERE o.name = 'Udayagiri & Khandagiri Caves' AND d.name = 'Mukteshwar Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  20,   8.0 FROM locations o, locations d WHERE o.name = 'Udayagiri & Khandagiri Caves' AND d.name = 'Rajarani Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  30,  14.0 FROM locations o, locations d WHERE o.name = 'Udayagiri & Khandagiri Caves' AND d.name = 'Dhauli Peace Pagoda';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  40,  20.0 FROM locations o, locations d WHERE o.name = 'Udayagiri & Khandagiri Caves' AND d.name = 'Nandankanan Zoological Park';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  85,  65.0 FROM locations o, locations d WHERE o.name = 'Udayagiri & Khandagiri Caves' AND d.name = 'Puri Jagannath Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  87,  66.0 FROM locations o, locations d WHERE o.name = 'Udayagiri & Khandagiri Caves' AND d.name = 'Puri Beach';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  90,  70.0 FROM locations o, locations d WHERE o.name = 'Udayagiri & Khandagiri Caves' AND d.name = 'Konark Sun Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 160, 124.0 FROM locations o, locations d WHERE o.name = 'Udayagiri & Khandagiri Caves' AND d.name = 'Chilika Lake Satapada';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 150, 114.0 FROM locations o, locations d WHERE o.name = 'Udayagiri & Khandagiri Caves' AND d.name = 'Mangalajodi Bird Sanctuary';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 370, 284.0 FROM locations o, locations d WHERE o.name = 'Udayagiri & Khandagiri Caves' AND d.name = 'Simlipal Biosphere Reserve';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 280, 204.0 FROM locations o, locations d WHERE o.name = 'Udayagiri & Khandagiri Caves' AND d.name = 'Bhitarkanika National Park';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 310, 254.0 FROM locations o, locations d WHERE o.name = 'Udayagiri & Khandagiri Caves' AND d.name = 'Daringbadi';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 220, 179.0 FROM locations o, locations d WHERE o.name = 'Udayagiri & Khandagiri Caves' AND d.name = 'Gopalpur-on-Sea';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  55,  36.0 FROM locations o, locations d WHERE o.name = 'Udayagiri & Khandagiri Caves' AND d.name = 'Barabati Fort';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 430, 384.0 FROM locations o, locations d WHERE o.name = 'Udayagiri & Khandagiri Caves' AND d.name = 'Hirakud Dam';

-- ---- FROM: Dhauli Peace Pagoda ----
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  25,  12.0 FROM locations o, locations d WHERE o.name = 'Dhauli Peace Pagoda' AND d.name = 'BBI Hub - Bhubaneswar';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  25,   9.0 FROM locations o, locations d WHERE o.name = 'Dhauli Peace Pagoda' AND d.name = 'Lingaraj Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  28,  10.0 FROM locations o, locations d WHERE o.name = 'Dhauli Peace Pagoda' AND d.name = 'Mukteshwar Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  22,   8.5 FROM locations o, locations d WHERE o.name = 'Dhauli Peace Pagoda' AND d.name = 'Rajarani Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  30,  14.0 FROM locations o, locations d WHERE o.name = 'Dhauli Peace Pagoda' AND d.name = 'Udayagiri & Khandagiri Caves';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  45,  25.0 FROM locations o, locations d WHERE o.name = 'Dhauli Peace Pagoda' AND d.name = 'Nandankanan Zoological Park';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  65,  52.0 FROM locations o, locations d WHERE o.name = 'Dhauli Peace Pagoda' AND d.name = 'Puri Jagannath Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  67,  53.0 FROM locations o, locations d WHERE o.name = 'Dhauli Peace Pagoda' AND d.name = 'Puri Beach';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  75,  60.0 FROM locations o, locations d WHERE o.name = 'Dhauli Peace Pagoda' AND d.name = 'Konark Sun Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 135, 110.0 FROM locations o, locations d WHERE o.name = 'Dhauli Peace Pagoda' AND d.name = 'Chilika Lake Satapada';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 125, 100.0 FROM locations o, locations d WHERE o.name = 'Dhauli Peace Pagoda' AND d.name = 'Mangalajodi Bird Sanctuary';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 375, 285.0 FROM locations o, locations d WHERE o.name = 'Dhauli Peace Pagoda' AND d.name = 'Simlipal Biosphere Reserve';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 285, 205.0 FROM locations o, locations d WHERE o.name = 'Dhauli Peace Pagoda' AND d.name = 'Bhitarkanika National Park';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 295, 245.0 FROM locations o, locations d WHERE o.name = 'Dhauli Peace Pagoda' AND d.name = 'Daringbadi';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 200, 168.0 FROM locations o, locations d WHERE o.name = 'Dhauli Peace Pagoda' AND d.name = 'Gopalpur-on-Sea';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  58,  37.0 FROM locations o, locations d WHERE o.name = 'Dhauli Peace Pagoda' AND d.name = 'Barabati Fort';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 435, 385.0 FROM locations o, locations d WHERE o.name = 'Dhauli Peace Pagoda' AND d.name = 'Hirakud Dam';

-- ---- FROM: Nandankanan Zoological Park ----
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  35,  18.0 FROM locations o, locations d WHERE o.name = 'Nandankanan Zoological Park' AND d.name = 'BBI Hub - Bhubaneswar';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  35,  18.0 FROM locations o, locations d WHERE o.name = 'Nandankanan Zoological Park' AND d.name = 'Lingaraj Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  38,  19.0 FROM locations o, locations d WHERE o.name = 'Nandankanan Zoological Park' AND d.name = 'Mukteshwar Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  35,  17.0 FROM locations o, locations d WHERE o.name = 'Nandankanan Zoological Park' AND d.name = 'Rajarani Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  40,  20.0 FROM locations o, locations d WHERE o.name = 'Nandankanan Zoological Park' AND d.name = 'Udayagiri & Khandagiri Caves';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  45,  25.0 FROM locations o, locations d WHERE o.name = 'Nandankanan Zoological Park' AND d.name = 'Dhauli Peace Pagoda';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 100,  72.0 FROM locations o, locations d WHERE o.name = 'Nandankanan Zoological Park' AND d.name = 'Puri Jagannath Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 102,  73.0 FROM locations o, locations d WHERE o.name = 'Nandankanan Zoological Park' AND d.name = 'Puri Beach';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 105,  78.0 FROM locations o, locations d WHERE o.name = 'Nandankanan Zoological Park' AND d.name = 'Konark Sun Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 175, 132.0 FROM locations o, locations d WHERE o.name = 'Nandankanan Zoological Park' AND d.name = 'Chilika Lake Satapada';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 165, 122.0 FROM locations o, locations d WHERE o.name = 'Nandankanan Zoological Park' AND d.name = 'Mangalajodi Bird Sanctuary';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 360, 278.0 FROM locations o, locations d WHERE o.name = 'Nandankanan Zoological Park' AND d.name = 'Simlipal Biosphere Reserve';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 270, 198.0 FROM locations o, locations d WHERE o.name = 'Nandankanan Zoological Park' AND d.name = 'Bhitarkanika National Park';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 320, 258.0 FROM locations o, locations d WHERE o.name = 'Nandankanan Zoological Park' AND d.name = 'Daringbadi';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 230, 183.0 FROM locations o, locations d WHERE o.name = 'Nandankanan Zoological Park' AND d.name = 'Gopalpur-on-Sea';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  50,  30.0 FROM locations o, locations d WHERE o.name = 'Nandankanan Zoological Park' AND d.name = 'Barabati Fort';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 415, 375.0 FROM locations o, locations d WHERE o.name = 'Nandankanan Zoological Park' AND d.name = 'Hirakud Dam';

-- ---- FROM: Puri Jagannath Temple ----
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  75,  60.0 FROM locations o, locations d WHERE o.name = 'Puri Jagannath Temple' AND d.name = 'BBI Hub - Bhubaneswar';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  80,  62.0 FROM locations o, locations d WHERE o.name = 'Puri Jagannath Temple' AND d.name = 'Lingaraj Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  82,  63.0 FROM locations o, locations d WHERE o.name = 'Puri Jagannath Temple' AND d.name = 'Mukteshwar Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  80,  61.0 FROM locations o, locations d WHERE o.name = 'Puri Jagannath Temple' AND d.name = 'Rajarani Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  85,  65.0 FROM locations o, locations d WHERE o.name = 'Puri Jagannath Temple' AND d.name = 'Udayagiri & Khandagiri Caves';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  65,  52.0 FROM locations o, locations d WHERE o.name = 'Puri Jagannath Temple' AND d.name = 'Dhauli Peace Pagoda';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 100,  72.0 FROM locations o, locations d WHERE o.name = 'Puri Jagannath Temple' AND d.name = 'Nandankanan Zoological Park';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  10,   1.5 FROM locations o, locations d WHERE o.name = 'Puri Jagannath Temple' AND d.name = 'Puri Beach';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  55,  35.0 FROM locations o, locations d WHERE o.name = 'Puri Jagannath Temple' AND d.name = 'Konark Sun Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 100,  80.0 FROM locations o, locations d WHERE o.name = 'Puri Jagannath Temple' AND d.name = 'Chilika Lake Satapada';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 115,  95.0 FROM locations o, locations d WHERE o.name = 'Puri Jagannath Temple' AND d.name = 'Mangalajodi Bird Sanctuary';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 390, 310.0 FROM locations o, locations d WHERE o.name = 'Puri Jagannath Temple' AND d.name = 'Simlipal Biosphere Reserve';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 295, 220.0 FROM locations o, locations d WHERE o.name = 'Puri Jagannath Temple' AND d.name = 'Bhitarkanika National Park';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 315, 265.0 FROM locations o, locations d WHERE o.name = 'Puri Jagannath Temple' AND d.name = 'Daringbadi';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 195, 155.0 FROM locations o, locations d WHERE o.name = 'Puri Jagannath Temple' AND d.name = 'Gopalpur-on-Sea';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 120,  90.0 FROM locations o, locations d WHERE o.name = 'Puri Jagannath Temple' AND d.name = 'Barabati Fort';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 480, 435.0 FROM locations o, locations d WHERE o.name = 'Puri Jagannath Temple' AND d.name = 'Hirakud Dam';

-- ---- FROM: Puri Beach ----
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  77,  62.0 FROM locations o, locations d WHERE o.name = 'Puri Beach' AND d.name = 'BBI Hub - Bhubaneswar';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  82,  63.0 FROM locations o, locations d WHERE o.name = 'Puri Beach' AND d.name = 'Lingaraj Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  84,  64.0 FROM locations o, locations d WHERE o.name = 'Puri Beach' AND d.name = 'Mukteshwar Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  82,  62.0 FROM locations o, locations d WHERE o.name = 'Puri Beach' AND d.name = 'Rajarani Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  87,  66.0 FROM locations o, locations d WHERE o.name = 'Puri Beach' AND d.name = 'Udayagiri & Khandagiri Caves';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  67,  53.0 FROM locations o, locations d WHERE o.name = 'Puri Beach' AND d.name = 'Dhauli Peace Pagoda';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 102,  73.0 FROM locations o, locations d WHERE o.name = 'Puri Beach' AND d.name = 'Nandankanan Zoological Park';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  10,   1.5 FROM locations o, locations d WHERE o.name = 'Puri Beach' AND d.name = 'Puri Jagannath Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  50,  35.0 FROM locations o, locations d WHERE o.name = 'Puri Beach' AND d.name = 'Konark Sun Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 102,  81.0 FROM locations o, locations d WHERE o.name = 'Puri Beach' AND d.name = 'Chilika Lake Satapada';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 117,  96.0 FROM locations o, locations d WHERE o.name = 'Puri Beach' AND d.name = 'Mangalajodi Bird Sanctuary';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 392, 311.0 FROM locations o, locations d WHERE o.name = 'Puri Beach' AND d.name = 'Simlipal Biosphere Reserve';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 297, 221.0 FROM locations o, locations d WHERE o.name = 'Puri Beach' AND d.name = 'Bhitarkanika National Park';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 317, 266.0 FROM locations o, locations d WHERE o.name = 'Puri Beach' AND d.name = 'Daringbadi';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 197, 156.0 FROM locations o, locations d WHERE o.name = 'Puri Beach' AND d.name = 'Gopalpur-on-Sea';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 122,  91.0 FROM locations o, locations d WHERE o.name = 'Puri Beach' AND d.name = 'Barabati Fort';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 482, 436.0 FROM locations o, locations d WHERE o.name = 'Puri Beach' AND d.name = 'Hirakud Dam';

-- ---- FROM: Konark Sun Temple ----
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  80,  65.0 FROM locations o, locations d WHERE o.name = 'Konark Sun Temple' AND d.name = 'BBI Hub - Bhubaneswar';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  85,  67.0 FROM locations o, locations d WHERE o.name = 'Konark Sun Temple' AND d.name = 'Lingaraj Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  87,  68.0 FROM locations o, locations d WHERE o.name = 'Konark Sun Temple' AND d.name = 'Mukteshwar Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  85,  66.0 FROM locations o, locations d WHERE o.name = 'Konark Sun Temple' AND d.name = 'Rajarani Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  90,  70.0 FROM locations o, locations d WHERE o.name = 'Konark Sun Temple' AND d.name = 'Udayagiri & Khandagiri Caves';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  75,  60.0 FROM locations o, locations d WHERE o.name = 'Konark Sun Temple' AND d.name = 'Dhauli Peace Pagoda';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 105,  78.0 FROM locations o, locations d WHERE o.name = 'Konark Sun Temple' AND d.name = 'Nandankanan Zoological Park';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  55,  35.0 FROM locations o, locations d WHERE o.name = 'Konark Sun Temple' AND d.name = 'Puri Jagannath Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  50,  35.0 FROM locations o, locations d WHERE o.name = 'Konark Sun Temple' AND d.name = 'Puri Beach';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 140, 112.0 FROM locations o, locations d WHERE o.name = 'Konark Sun Temple' AND d.name = 'Chilika Lake Satapada';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 155, 125.0 FROM locations o, locations d WHERE o.name = 'Konark Sun Temple' AND d.name = 'Mangalajodi Bird Sanctuary';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 420, 340.0 FROM locations o, locations d WHERE o.name = 'Konark Sun Temple' AND d.name = 'Simlipal Biosphere Reserve';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 300, 240.0 FROM locations o, locations d WHERE o.name = 'Konark Sun Temple' AND d.name = 'Bhitarkanika National Park';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 340, 290.0 FROM locations o, locations d WHERE o.name = 'Konark Sun Temple' AND d.name = 'Daringbadi';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 220, 180.0 FROM locations o, locations d WHERE o.name = 'Konark Sun Temple' AND d.name = 'Gopalpur-on-Sea';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 140, 110.0 FROM locations o, locations d WHERE o.name = 'Konark Sun Temple' AND d.name = 'Barabati Fort';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 500, 455.0 FROM locations o, locations d WHERE o.name = 'Konark Sun Temple' AND d.name = 'Hirakud Dam';

-- ---- FROM: Chilika Lake Satapada ----
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 150, 120.0 FROM locations o, locations d WHERE o.name = 'Chilika Lake Satapada' AND d.name = 'BBI Hub - Bhubaneswar';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 155, 122.0 FROM locations o, locations d WHERE o.name = 'Chilika Lake Satapada' AND d.name = 'Lingaraj Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 158, 123.0 FROM locations o, locations d WHERE o.name = 'Chilika Lake Satapada' AND d.name = 'Mukteshwar Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 152, 121.0 FROM locations o, locations d WHERE o.name = 'Chilika Lake Satapada' AND d.name = 'Rajarani Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 160, 124.0 FROM locations o, locations d WHERE o.name = 'Chilika Lake Satapada' AND d.name = 'Udayagiri & Khandagiri Caves';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 135, 110.0 FROM locations o, locations d WHERE o.name = 'Chilika Lake Satapada' AND d.name = 'Dhauli Peace Pagoda';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 175, 132.0 FROM locations o, locations d WHERE o.name = 'Chilika Lake Satapada' AND d.name = 'Nandankanan Zoological Park';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 100,  80.0 FROM locations o, locations d WHERE o.name = 'Chilika Lake Satapada' AND d.name = 'Puri Jagannath Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 102,  81.0 FROM locations o, locations d WHERE o.name = 'Chilika Lake Satapada' AND d.name = 'Puri Beach';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 140, 112.0 FROM locations o, locations d WHERE o.name = 'Chilika Lake Satapada' AND d.name = 'Konark Sun Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  45,  30.0 FROM locations o, locations d WHERE o.name = 'Chilika Lake Satapada' AND d.name = 'Mangalajodi Bird Sanctuary';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 450, 370.0 FROM locations o, locations d WHERE o.name = 'Chilika Lake Satapada' AND d.name = 'Simlipal Biosphere Reserve';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 350, 280.0 FROM locations o, locations d WHERE o.name = 'Chilika Lake Satapada' AND d.name = 'Bhitarkanika National Park';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 270, 220.0 FROM locations o, locations d WHERE o.name = 'Chilika Lake Satapada' AND d.name = 'Daringbadi';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 135, 105.0 FROM locations o, locations d WHERE o.name = 'Chilika Lake Satapada' AND d.name = 'Gopalpur-on-Sea';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 190, 145.0 FROM locations o, locations d WHERE o.name = 'Chilika Lake Satapada' AND d.name = 'Barabati Fort';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 510, 460.0 FROM locations o, locations d WHERE o.name = 'Chilika Lake Satapada' AND d.name = 'Hirakud Dam';

-- ---- FROM: Mangalajodi Bird Sanctuary ----
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 140, 110.0 FROM locations o, locations d WHERE o.name = 'Mangalajodi Bird Sanctuary' AND d.name = 'BBI Hub - Bhubaneswar';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 145, 112.0 FROM locations o, locations d WHERE o.name = 'Mangalajodi Bird Sanctuary' AND d.name = 'Lingaraj Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 148, 113.0 FROM locations o, locations d WHERE o.name = 'Mangalajodi Bird Sanctuary' AND d.name = 'Mukteshwar Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 142, 111.0 FROM locations o, locations d WHERE o.name = 'Mangalajodi Bird Sanctuary' AND d.name = 'Rajarani Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 150, 114.0 FROM locations o, locations d WHERE o.name = 'Mangalajodi Bird Sanctuary' AND d.name = 'Udayagiri & Khandagiri Caves';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 125, 100.0 FROM locations o, locations d WHERE o.name = 'Mangalajodi Bird Sanctuary' AND d.name = 'Dhauli Peace Pagoda';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 165, 122.0 FROM locations o, locations d WHERE o.name = 'Mangalajodi Bird Sanctuary' AND d.name = 'Nandankanan Zoological Park';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 115,  95.0 FROM locations o, locations d WHERE o.name = 'Mangalajodi Bird Sanctuary' AND d.name = 'Puri Jagannath Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 117,  96.0 FROM locations o, locations d WHERE o.name = 'Mangalajodi Bird Sanctuary' AND d.name = 'Puri Beach';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 155, 125.0 FROM locations o, locations d WHERE o.name = 'Mangalajodi Bird Sanctuary' AND d.name = 'Konark Sun Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id,  45,  30.0 FROM locations o, locations d WHERE o.name = 'Mangalajodi Bird Sanctuary' AND d.name = 'Chilika Lake Satapada';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 460, 375.0 FROM locations o, locations d WHERE o.name = 'Mangalajodi Bird Sanctuary' AND d.name = 'Simlipal Biosphere Reserve';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 355, 285.0 FROM locations o, locations d WHERE o.name = 'Mangalajodi Bird Sanctuary' AND d.name = 'Bhitarkanika National Park';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 260, 215.0 FROM locations o, locations d WHERE o.name = 'Mangalajodi Bird Sanctuary' AND d.name = 'Daringbadi';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 130, 102.0 FROM locations o, locations d WHERE o.name = 'Mangalajodi Bird Sanctuary' AND d.name = 'Gopalpur-on-Sea';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 185, 140.0 FROM locations o, locations d WHERE o.name = 'Mangalajodi Bird Sanctuary' AND d.name = 'Barabati Fort';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 505, 455.0 FROM locations o, locations d WHERE o.name = 'Mangalajodi Bird Sanctuary' AND d.name = 'Hirakud Dam';

-- ---- FROM: Simlipal Biosphere Reserve ----
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 360, 280.0 FROM locations o, locations d WHERE o.name = 'Simlipal Biosphere Reserve' AND d.name = 'BBI Hub - Bhubaneswar';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 365, 282.0 FROM locations o, locations d WHERE o.name = 'Simlipal Biosphere Reserve' AND d.name = 'Lingaraj Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 368, 283.0 FROM locations o, locations d WHERE o.name = 'Simlipal Biosphere Reserve' AND d.name = 'Mukteshwar Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 362, 281.0 FROM locations o, locations d WHERE o.name = 'Simlipal Biosphere Reserve' AND d.name = 'Rajarani Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 370, 284.0 FROM locations o, locations d WHERE o.name = 'Simlipal Biosphere Reserve' AND d.name = 'Udayagiri & Khandagiri Caves';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 375, 285.0 FROM locations o, locations d WHERE o.name = 'Simlipal Biosphere Reserve' AND d.name = 'Dhauli Peace Pagoda';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 360, 278.0 FROM locations o, locations d WHERE o.name = 'Simlipal Biosphere Reserve' AND d.name = 'Nandankanan Zoological Park';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 390, 310.0 FROM locations o, locations d WHERE o.name = 'Simlipal Biosphere Reserve' AND d.name = 'Puri Jagannath Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 392, 311.0 FROM locations o, locations d WHERE o.name = 'Simlipal Biosphere Reserve' AND d.name = 'Puri Beach';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 420, 340.0 FROM locations o, locations d WHERE o.name = 'Simlipal Biosphere Reserve' AND d.name = 'Konark Sun Temple';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 450, 370.0 FROM locations o, locations d WHERE o.name = 'Simlipal Biosphere Reserve' AND d.name = 'Chilika Lake Satapada';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 460, 375.0 FROM locations o, locations d WHERE o.name = 'Simlipal Biosphere Reserve' AND d.name = 'Mangalajodi Bird Sanctuary';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 210, 150.0 FROM locations o, locations d WHERE o.name = 'Simlipal Biosphere Reserve' AND d.name = 'Bhitarkanika National Park';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 540, 440.0 FROM locations o, locations d WHERE o.name = 'Simlipal Biosphere Reserve' AND d.name = 'Daringbadi';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 490, 410.0 FROM locations o, locations d WHERE o.name = 'Simlipal Biosphere Reserve' AND d.name = 'Gopalpur-on-Sea';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 320, 255.0 FROM locations o, locations d WHERE o.name = 'Simlipal Biosphere Reserve' AND d.name = 'Barabati Fort';
INSERT INTO travel_matrix (origin_id, destination_id, travel_time_mins, distance_km) SELECT o.id, d.id, 390, 340.0 FROM locations o, locations d WHERE o.name = 'Simlipal Biosphere Reserve' AND d.name = 'Hirakud Dam';

