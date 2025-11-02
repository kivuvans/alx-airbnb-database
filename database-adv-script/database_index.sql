-- ==========================================
-- Advanced SQL: Index Implementation and Optimization
-- Author: Evans Kivuva
-- Project: ALX Airbnb Database - Advanced SQL
-- Task 3: Implement Indexes for Optimization
-- ==========================================

-- 🔍 Objective:
-- Create indexes on frequently used columns to enhance query performance.

-- ==========================================
-- 1️⃣ USERS TABLE
-- Columns frequently used in authentication, search, and filtering queries.
-- ==========================================

-- Create index on email (commonly used for login lookups)
CREATE INDEX idx_users_email ON users (email);

-- Create index on created_at (commonly used in sorting or date range filters)
CREATE INDEX idx_users_created_at ON users (created_at);

-- ==========================================
-- 2️⃣ BOOKINGS TABLE
-- Columns used in JOINs, WHERE, and ORDER BY clauses.
-- ==========================================

-- Create index on user_id (frequently used in joins between users and bookings)
CREATE INDEX idx_bookings_user_id ON bookings (user_id);

-- Create index on property_id (used in joins between bookings and properties)
CREATE INDEX idx_bookings_property_id ON bookings (property_id);

-- Create index on booking_date (for performance on date range queries)
CREATE INDEX idx_bookings_booking_date ON bookings (booking_date);

-- ==========================================
-- 3️⃣ PROPERTIES TABLE
-- Columns used for filtering and sorting.
-- ==========================================

-- Create index on city (frequently queried by users searching for properties by location)
CREATE INDEX idx_properties_city ON properties (city);

-- Create index on price_per_night (used in filtering and sorting)
CREATE INDEX idx_properties_price ON properties (price_per_night);

-- ==========================================
-- 4️⃣ PERFORMANCE ANALYSIS
-- Use EXPLAIN or ANALYZE to compare before and after adding indexes.
-- ==========================================

-- Example before adding indexes:
-- EXPLAIN ANALYZE 
-- SELECT * FROM bookings WHERE user_id = 101;

-- Example after adding indexes:
-- EXPLAIN ANALYZE 
-- SELECT * FROM bookings WHERE user_id = 101;

-- Observe improvement in the query execution plan — reduced cost and faster lookup.
