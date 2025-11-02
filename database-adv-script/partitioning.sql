-- ==========================================
-- Advanced SQL: Table Partitioning for Optimization
-- Author: Evans Kivuva
-- Project: ALX Airbnb Database - Advanced SQL
-- Task 5: Partitioning Large Tables
-- ==========================================

-- 🧠 Objective:
-- Implement partitioning on the Booking table to improve query performance on large datasets.
-- Partition based on the start_date column.

-- ==========================================
-- STEP 1️⃣: BACKUP ORIGINAL BOOKING TABLE
-- ==========================================
CREATE TABLE bookings_backup AS
SELECT * FROM bookings;

-- ==========================================
-- STEP 2️⃣: DROP EXISTING BOOKING TABLE
-- (Skip if your SQL environment doesn’t allow dropping)
-- ==========================================
DROP TABLE IF EXISTS bookings CASCADE;

-- ==========================================
-- STEP 3️⃣: CREATE PARTITIONED BOOKING TABLE
-- ==========================================
CREATE TABLE bookings (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    property_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2),
    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50) DEFAULT 'confirmed',
    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES users (id),
    CONSTRAINT fk_property FOREIGN KEY (property_id) REFERENCES properties (id)
)
PARTITION BY RANGE (start_date);

-- ==========================================
-- STEP 4️⃣: CREATE INDIVIDUAL PARTITIONS
-- ==========================================
CREATE TABLE bookings_2023 PARTITION OF bookings
    FOR VALUES FROM ('2023-01-01') TO ('2023-12-31');

CREATE TABLE bookings_2024 PARTITION OF bookings
    FOR VALUES FROM ('2024-01-01') TO ('2024-12-31');

CREATE TABLE bookings_2025 PARTITION OF bookings
    FOR VALUES FROM ('2025-01-01') TO ('2025-12-31');

CREATE TABLE bookings_future PARTITION OF bookings
    FOR VALUES FROM ('2026-01-01') TO (MAXVALUE);

-- ==========================================
-- STEP 5️⃣: REINSERT BACKUP DATA (OPTIONAL)
-- ==========================================
INSERT INTO bookings (id, user_id, property_id, start_date, end_date, total_price, booking_date, status)
SELECT id, user_id, property_id, start_date, end_date, total_price, booking_date, status
FROM bookings_backup;

-- ==========================================
-- STEP 6️⃣: TEST QUERY PERFORMANCE
-- ==========================================
-- ✅ Query before partitioning (example)
-- EXPLAIN ANALYZE
-- SELECT * FROM bookings_backup
-- WHERE start_date BETWEEN '2024-01-01' AND '2024-03-31';

-- ✅ Query after partitioning
EXPLAIN ANALYZE
SELECT * FROM bookings
WHERE start_date BETWEEN '2024-01-01' AND '2024-03-31';

-- ==========================================
-- STEP 7️⃣: VERIFY PARTITION USAGE
-- ==========================================
-- PostgreSQL-specific check to confirm partition pruning
EXPLAIN
SELECT * FROM bookings
WHERE start_date BETWEEN '2023-01-01' AND '2023-06-30';

-- ==========================================
-- STEP 8️⃣: INDEX PARTITIONS (OPTIONAL)
-- ==========================================
-- Index each partition to improve date-range queries
CREATE INDEX idx_bookings_2023_start_date ON bookings_2023 (start_date);
CREATE INDEX idx_bookings_2024_start_date ON bookings_2024 (start_date);
CREATE INDEX idx_bookings_2025_start_date ON bookings_2025 (start_date);
CREATE INDEX idx_bookings_future_start_date ON bookings_future (start_date);

-- ==========================================
-- ✅ END OF SCRIPT
-- ==========================================

