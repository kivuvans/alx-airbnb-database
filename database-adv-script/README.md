# 0️⃣ Write Complex Queries with Joins

## 🎯 Objective
To demonstrate mastery of SQL JOIN operations by writing complex queries that combine data from multiple related tables in the Airbnb database.

---

## 🧠 Key Concepts
- **INNER JOIN** — Returns only records with matching values in both tables.
- **LEFT JOIN** — Returns all records from the left table, and matching records from the right table.
- **FULL OUTER JOIN** — Returns all records when there is a match in either table (emulated using UNION in MySQL).

---

## 📋 Tasks Implemented

### 1️⃣ INNER JOIN: Bookings and Users
Retrieve all bookings and the respective users who made those bookings.

```sql
SELECT u.id, u.first_name, u.last_name, b.id AS booking_id, b.property_id, b.start_date, b.end_date
FROM users u
INNER JOIN bookings b ON u.id = b.user_id;


### 2️⃣ LEFT JOIN: Properties and Reviews

Retrieve all properties and their reviews, including properties that have no reviews.

```sql
SELECT p.id, p.name, p.location, r.id AS review_id, r.rating, r.comment
FROM properties p
LEFT JOIN reviews r ON p.id = r.property_id;

### 3️⃣ FULL OUTER JOIN: Users and Bookings

Retrieve all users and all bookings, even if a user has no booking or a booking is not linked to a user.

SELECT u.id, u.first_name, u.last_name, b.id AS booking_id, b.property_id, b.start_date, b.end_date
FROM users u
LEFT JOIN bookings b ON u.id = b.user_id
UNION
SELECT u.id, u.first_name, u.last_name, b.id AS booking_id, b.property_id, b.start_date, b.end_date
FROM users u
RIGHT JOIN bookings b ON u.id = b.user_id;

🧩 Files
File	Description
joins_queries.sql	Contains all SQL JOIN queries
README.md	Documentation of objectives, explanations, and sample queries
✅ Expected Output

INNER JOIN: Only users with bookings.

LEFT JOIN: All properties (with or without reviews).

FULL OUTER JOIN: All users and all bookings (complete dataset).

🧑‍💻 Author

Evans Kivuva
ALX Software Engineering Program – Airbnb Database Module (Advanced SQL)

