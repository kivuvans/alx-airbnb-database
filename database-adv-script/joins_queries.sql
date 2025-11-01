-- ==========================================
-- Advanced SQL Joins Queries for Airbnb Database
-- Author: Evans Kivuva
-- Project: ALX Airbnb Database - Advanced SQL
-- Task: 0. Write Complex Queries with Joins
-- ==========================================

-- 1️⃣ INNER JOIN: Retrieve all bookings and the respective users who made those bookings
-- This query lists each booking with user details (only where a user-booking link exists).
SELECT 
    u.id AS user_id,
    u.first_name,
    u.last_name,
    b.id AS booking_id,
    b.property_id,
    b.start_date,
    b.end_date,
    b.total_price
FROM 
    users u
INNER JOIN 
    bookings b 
ON 
    u.id = b.user_id;

-- ==========================================

-- 2️⃣ LEFT JOIN: Retrieve all properties and their reviews (including properties without reviews)
-- This query returns all properties, showing review details if available.
SELECT 
    p.id AS property_id,
    p.name AS property_name,
    p.location,
    r.id AS review_id,
    r.rating,
    r.comment,
    r.user_id
FROM 
    properties p
LEFT JOIN 
    reviews r 
ON 
    p.id = r.property_id;

-- ==========================================

-- 3️⃣ FULL OUTER JOIN: Retrieve all users and bookings (even if user has no booking or booking has no user)
-- This ensures all users and all bookings appear, even without a match.
-- ⚠️ Note: MySQL does not support FULL OUTER JOIN directly — we emulate it using UNION.
SELECT 
    u.id AS user_id,
    u.first_name,
    u.last_name,
    b.id AS booking_id,
    b.property_id,
    b.start_date,
    b.end_date
FROM 
    users u
LEFT JOIN 
    bookings b 
ON 
    u.id = b.user_id

UNION

SELECT 
    u.id AS user_id,
    u.first_name,
    u.last_name,
    b.id AS booking_id,
    b.property_id,
    b.start_date,
    b.end_date
FROM 
    users u
RIGHT JOIN 
    bookings b 
ON 
    u.id = b.user_id;
