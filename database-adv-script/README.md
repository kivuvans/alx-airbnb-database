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

test



```sql
SELECT u.id, u.first_name, u.last_name, b.id AS booking_id, b.property_id, b.start_date, b.end_date
FROM users u
INNER JOIN bookings b ON u.id = b.user_id;

``` 

### 2️⃣ LEFT JOIN: Properties and Reviews

Retrieve all properties and their reviews, including properties that have no reviews.

```sql
SELECT p.id, p.name, p.location, r.id AS review_id, r.rating, r.comment
FROM properties p
LEFT JOIN reviews r ON p.id = r.property_id;
``` 

### 3️⃣ FULL OUTER JOIN: Users and Bookings

Retrieve all users and all bookings, even if a user has no booking or a booking is not linked to a user.
```sql
SELECT u.id, u.first_name, u.last_name, b.id AS booking_id, b.property_id, b.start_date, b.end_date
FROM users u
LEFT JOIN bookings b ON u.id = b.user_id
UNION
SELECT u.id, u.first_name, u.last_name, b.id AS booking_id, b.property_id, b.start_date, b.end_date
FROM users u
RIGHT JOIN bookings b ON u.id = b.user_id;
``` 
🧩 Files
File	Description
joins_queries.sql	Contains all SQL JOIN queries
README.md	Documentation of objectives, explanations, and sample queries
✅ Expected Output

INNER JOIN: Only users with bookings.

LEFT JOIN: All properties (with or without reviews).

FULL OUTER JOIN: All users and all bookings (complete dataset).




# 1️⃣ Practice Subqueries

## 🎯 Objective
To write and understand both **correlated** and **non-correlated subqueries** that retrieve data based on conditions derived from other queries in the Airbnb database.

---

## 🧠 Key Concepts

### 🔹 Non-Correlated Subquery
A **non-correlated subquery** runs independently of the outer query.  
It retrieves data that the main query uses for filtering or comparison.

### 🔹 Correlated Subquery
A **correlated subquery** depends on the outer query for its values and executes once for each row processed by the outer query.

---

## 📋 Tasks Implemented

### 1️⃣ Non-Correlated Subquery — Find Properties with Average Rating > 4.0
This query identifies properties that have an average rating greater than 4.0.

```sql
SELECT p.id, p.name, p.location, p.pricepernight
FROM properties p
WHERE p.id IN (
    SELECT r.property_id
    FROM reviews r
    GROUP BY r.property_id
    HAVING AVG(r.rating) > 4.0
);
```
🧩 Explanation:

The subquery calculates the AVG(r.rating) for each property.

The HAVING clause filters for properties with an average rating greater than 4.0.

The outer query returns property details for these high-rated listings.

2️⃣ Correlated Subquery — Find Users with More Than 3 Bookings

This query lists all users who have made more than three bookings.
```sql
SELECT u.id, u.first_name, u.last_name, u.email
FROM users u
WHERE (
    SELECT COUNT(*)
    FROM bookings b
    WHERE b.user_id = u.id
) > 3;

```
🧩 Explanation:

The inner query counts the number of bookings per user.

The outer query filters users whose booking count exceeds 3.

Because the subquery references u.id from the outer query, it is correlated.

🧪 Expected Output
Query	Output Description
Non-Correlated Subquery	List of properties with average rating > 4.0
Correlated Subquery	List of users with more than 3 bookings
📁 Files
File	Description
subqueries.sql	Contains all subquery SQL statements
README.md	Documentation with explanations and examples
🧑‍💻 Author

Evans Kivuva
ALX Software Engineering Program – Airbnb Database (Advanced SQL)
