-- ==========================================
-- Advanced SQL Aggregations and Window Functions
-- Author: Evans Kivuva
-- Project: ALX Airbnb Database - Advanced SQL
-- Task 2: Apply Aggregations and Window Functions
-- ==========================================

-- 1️⃣ Aggregation Query:
-- Find the total number of bookings made by each user.
-- Uses COUNT() with GROUP BY to summarize booking data per user.

SELECT 
    u.id AS user_id,
    u.first_name,
    u.last_name,
    COUNT(b.id) AS total_bookings
FROM 
    users u
LEFT JOIN 
    bookings b 
ON 
    u.id = b.user_id
GROUP BY 
    u.id, u.first_name, u.last_name
ORDER BY 
    total_bookings DESC;

-- ==========================================

-- 2️⃣ Window Function Query:
-- Rank properties based on the total number of bookings they have received.
-- Uses COUNT() aggregation and RANK() window function for ranking.

SELECT 
    p.id AS property_id,
    p.name AS property_name,
    COUNT(b.id) AS total_bookings,
    RANK() OVER (ORDER BY COUNT(b.id) DESC) AS booking_rank
FROM 
    properties p
LEFT JOIN 
    bookings b 
ON 
    p.id = b.property_id
GROUP BY 
    p.id, p.name
ORDER BY 
    booking_rank ASC;

