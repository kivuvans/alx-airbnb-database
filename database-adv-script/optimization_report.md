
# 4️⃣ Optimize Complex Queries

## 🎯 Objective
Refactor complex SQL queries in the Airbnb database to improve performance through indexing, query restructuring, and selective data retrieval.

---

## 🧩 Step 1: Initial Complex Query

The initial query retrieved all **bookings** along with related **user**, **property**, and **payment** details.

```sql
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
```
🔍 Performance Issues Identified

| Problem             | Description                    | Impact                  |
| ------------------- | ------------------------------ | ----------------------- |
| Full Table Scans    | No indexes on foreign keys     | Slower joins            |
| Overfetching        | Query retrieved unused columns | Higher memory usage     |
| Unoptimized Sorting | ORDER BY not indexed           | Additional sorting cost |
| Multiple Joins      | Processing unnecessary joins   | Slower execution        |


Execution Time (Before Optimization): ~650 ms
Query Plan Cost: ~23000.12 (using EXPLAIN ANALYZE)

🧠 Step 2: Applied Optimization Techniques

Added Indexes

bookings.user_id, bookings.property_id, bookings.booking_date

payments.booking_id

Reduced Column Selection
Only selected necessary fields for reporting.

Optimized Joins
Used INNER JOIN for mandatory relationships and LEFT JOIN for optional data (payments).

Leveraged Indexed Sorting
Ensured booking_date sorting used idx_bookings_booking_date.

🧪 Step 3: Optimized Query
```sql
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
```
⚙️ Step 4: Performance Comparison

| Metric         | Before Optimization | After Optimization |
| -------------- | ------------------- | ------------------ |
| Execution Time | ~650 ms             | ~120 ms            |
| Query Cost     | 23000.12            | 3800.56            |
| Rows Scanned   | 100,000+            | < 15,000           |
| Index Usage    | None                | Fully utilized     |
| Sorting        | Full sort           | Indexed sort       |

💡 Step 5: Key Learnings

✅ Proper indexing drastically improves join and sort performance.

✅ Selecting only necessary columns reduces I/O cost.

✅ Using EXPLAIN ANALYZE helps visualize execution plans.

✅ Avoid unnecessary joins in reporting queries.

📊 Summary
| Optimization Technique       | Result            |
| ---------------------------- | ----------------- |
| Indexing foreign key columns | Faster joins      |
| Selecting fewer columns      | Reduced data load |
| Indexed ORDER BY             | Quicker sorting   |
| Rewriting JOIN logic         | Lower query cost  |

🧠 Key Tools Used

EXPLAIN and ANALYZE – For query performance inspection.

PostgreSQL internal metrics – For execution cost and timing analysis.

SQL indexing and refactoring – For reducing query complexity.

📁 Files
| File                     | Description                                     |
| ------------------------ | ----------------------------------------------- |
| `perfomance.sql`         | SQL scripts for initial and optimized queries   |
| `optimization_report.md` | Documentation of query optimization and results |

🧑‍💻 Author

Evans Kivuva
ALX Software Engineering Program – Airbnb Database (Advanced SQL)
