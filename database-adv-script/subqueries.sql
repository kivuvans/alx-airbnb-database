
-- ==========================================
-- Advanced SQL Subqueries for Airbnb Database
-- Author: Evans Kivuva
-- Project: ALX Airbnb Database - Advanced SQL
-- Task: 1. Practice Subqueries
-- ==========================================

-- 1️⃣ Non-Correlated Subquery:
-- Find all properties where the average rating is greater than 4.0
-- The subquery calculates the average rating per property, and the outer query
-- retrieves property details that meet the condition.

SELECT 
    p.id AS property_id,
    p.name AS property_name,
    p.location,
    p.pricepernight
FROM 
    properties p
WHERE 
    p.id IN (
        SELECT 
            r.property_id
        FROM 
            reviews r
        GROUP BY 
            r.property_id
        HAVING 
            AVG(r.rating) > 4.0
    );

-- ==========================================

-- 2️⃣ Correlated Subquery:
-- Find all users who have made more than 3 bookings.
-- The subquery is correlated because it references the outer query’s user_id.

SELECT 
    u.id AS user_id,
    u.first_name,
    u.last_name,
    u.email
FROM 
    users u
WHERE 
    (
        SELECT 
            COUNT(*)
        FROM 
            bookings b
        WHERE 
            b.user_id = u.id
    ) > 3;
