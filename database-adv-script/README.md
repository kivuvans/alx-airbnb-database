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
