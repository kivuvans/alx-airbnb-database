-- ==========================================
-- Advanced SQL: Query Optimization for Performance
-- Author: Evans Kivuva
-- Project: ALX Airbnb Database - Advanced SQL
-- Task 4: Optimize Complex Queries
-- ==========================================

-- 🧠 Objective:
-- Retrieve all bookings with user, property, and payment details.
-- Analyze performance and refactor to improve execution efficiency.

-- ==========================================
-- STEP 1️⃣: INITIAL COMPLEX QUERY
-- ==========================================
-- This query retrieves all bookings with related user, property, and payment details.

EXPLAIN ANALYZE
SELECT 
    b.id AS booking_id,
    b.booking_date,
    b.start_date,
    b.end_date,
    b.total_price,
    u.id AS user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.id AS property_id,
    p.title AS property_title,
    p.city,
    pay.id AS payment_id,
    pay.amount,
    pay.status AS payment_status,
    pay.payment_date
FROM bookings b
JOIN users u ON b.user_id = u.id
JOIN properties p ON b.property_id = p.id
LEFT JOIN payments pay ON b.id = pay.booking_id
ORDER BY b.booking_date DESC;

-- ==========================================
-- STEP 2️⃣: IDENTIFY INEFFICIENCIES
-- ==========================================
-- 1. Full table scans on large tables (bookings, payments)
-- 2. Unnecessary retrieval of unused columns
-- 3. Sorting without index on booking_date
-- 4. Multiple JOINs impacting performance

-- ==========================================
-- STEP 3️⃣: CREATE INDEXES TO OPTIMIZE PERFORMANCE
-- ==========================================
-- (Ensure indexes exist from Task 3)
-- CREATE INDEX idx_bookings_user_id ON bookings (user_id);
-- CREATE INDEX idx_bookings_property_id ON bookings (property_id);
-- CREATE INDEX idx_bookings_booking_date ON bookings (booking_date);
-- CREATE INDEX idx_payments_booking_id ON payments (booking_id);

-- ==========================================
-- STEP 4️⃣: REFACTORED OPTIMIZED QUERY
-- ==========================================
-- Optimization strategy:
-- ✅ Select only necessary columns.
-- ✅ Ensure JOINs use indexed columns.
-- ✅ Use proper ordering by indexed column.
-- ✅ Avoid unnecessary nested queries.

EXPLAIN ANALYZE
SELECT 
    b.id AS booking_id,
    b.booking_date,
    u.first_name || ' ' || u.last_name AS user_name,
    p.title AS property_title,
    pay.amount AS payment_amount,
    pay.status AS payment_status
FROM bookings b
INNER JOIN users u ON b.user_id = u.id
INNER JOIN properties p ON b.property_id = p.id
LEFT JOIN payments pay ON b.id = pay.booking_id
ORDER BY b.booking_date DESC;

-- ==========================================
-- STEP 5️⃣: PERFORMANCE TESTING
-- ==========================================
-- Run both queries with EXPLAIN ANALYZE and compare execution time.
-- Expect to see:
-- - Reduced cost
-- - Fewer rows scanned
-- - Improved execution plan with index usage

