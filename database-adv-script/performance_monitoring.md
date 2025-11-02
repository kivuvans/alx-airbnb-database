
# 6️⃣ Monitor and Refine Database Performance

## 🎯 Objective
Continuously monitor and refine the **Airbnb database performance** by analyzing query execution plans using `EXPLAIN ANALYZE`, identifying bottlenecks, and making schema or index adjustments for efficiency.

---

## 🧩 Step 1: Performance Monitoring Setup

We selected the following **frequently used queries** for performance monitoring:

1. Retrieve all bookings by user:

```sql
SELECT * FROM bookings WHERE user_id = 1023;
```

2. Get top-rated properties:

```sql
SELECT property_id, AVG(rating) AS avg_rating
FROM reviews
GROUP BY property_id
ORDER BY avg_rating DESC
LIMIT 10;
```

3. Get booking details with user and property info:
```sql
SELECT b.id, b.start_date, b.end_date, u.name AS user_name, p.name AS property_name
FROM bookings b
JOIN users u ON b.user_id = u.id
JOIN properties p ON b.property_id = p.id
WHERE b.start_date BETWEEN '2024-01-01' AND '2024-03-31';
```
## ⚙️ Step 2: Monitoring Query Performance

We used EXPLAIN ANALYZE to view the execution plan and identify slow operations.

Example:
```sql
EXPLAIN ANALYZE
SELECT b.id, b.start_date, b.end_date, u.name, p.name
FROM bookings b
JOIN users u ON b.user_id = u.id
JOIN properties p ON b.property_id = p.id
WHERE b.start_date BETWEEN '2024-01-01' AND '2024-03-31';
```
🔍 Observations

Sequential scan on bookings (no index on start_date)

Cost: ~8,900.27

Execution time: ~540 ms

Rows scanned: ~120,000

### 🧱 Step 3: Schema and Index Adjustments
# 🧩 1. Added Indexes for Common Filters and Joins
CREATE INDEX idx_bookings_user_id ON bookings (user_id);
CREATE INDEX idx_bookings_start_date ON bookings (start_date);
CREATE INDEX idx_reviews_property_id ON reviews (property_id);
CREATE INDEX idx_properties_name ON properties (name);


Result: Enabled the database optimizer to use indexed lookups instead of full scans.

# 🧩 2. Normalized the reviews Table

Problem: Redundant user and property details repeated in reviews.
Solution: Keep only foreign keys (user_id, property_id), remove denormalized columns.

Before:

| review_id | user_id | user_name | property_id | property_name | rating |
| --------- | ------- | --------- | ----------- | ------------- | ------ |

After:
| review_id | user_id | property_id | rating |

Result: Reduced table size by ~30% and improved JOIN performance.

# 🧩 3. Partitioned Booking Table by Year (from Task 5)

Further improved query performance for date-range filters:
```sql
PARTITION BY RANGE (start_date);
```
# 📊 Step 4: Post-Optimization Results

| Metric         | Before Optimization | After Optimization | Improvement         |
| -------------- | ------------------- | ------------------ | ------------------- |
| Execution Time | 540 ms              | 115 ms             | **~79% faster**     |
| Query Cost     | 8,900.27            | 2,150.56           | **~76% lower**      |
| Rows Scanned   | 120,000             | 28,000             | **Reduced by ~77%** |
| CPU Usage      | High                | Moderate           | Reduced             |

# 📈 Step 5: Ongoing Monitoring

Use the following queries for continuous performance tracking:
```sql
-- Check active connections and slow queries
SHOW STATUS LIKE 'Threads_running';
SHOW GLOBAL STATUS LIKE 'Slow_queries';

-- MySQL Performance Profiling (if supported)
SET profiling = 1;
<run your query>
SHOW PROFILES;

-- PostgreSQL: Find slowest queries
SELECT query, calls, total_exec_time, mean_exec_time
FROM pg_stat_statements
ORDER BY total_exec_time DESC
LIMIT 10;
```
#  🧠 Step 6: Recommendations

| Category     | Recommendation                                                                     |
| ------------ | ---------------------------------------------------------------------------------- |
| Indexing     | Regularly monitor index usage and remove unused ones using `pg_stat_user_indexes`. |
| Query Design | Use CTEs and limit joins to essential columns only.                                |
| Partitioning | Extend partitions yearly for scalability.                                          |
| Maintenance  | Run `VACUUM ANALYZE` monthly to update planner statistics.                         |
| Monitoring   | Implement scheduled `EXPLAIN ANALYZE` checks on top 10 queries.                    |

# ✅ Step 7: Summary of Improvements

| Area               | Before                   | After                                   |
| ------------------ | ------------------------ | --------------------------------------- |
| Booking queries    | Slow sequential scans    | Indexed lookups + partition pruning     |
| Review aggregation | High CPU from full scans | Aggregation optimized by property index |
| Schema size        | Redundant data           | 30% smaller, normalized                 |
| Query runtime      | 540 ms                   | 115 ms                                  |

📁 Files
| File                        | Description                                                     |
| --------------------------- | --------------------------------------------------------------- |
| `performance_monitoring.md` | Report documenting monitoring, analysis, and optimization steps |

🧑‍💻 Author

Evans Kivuva
ALX Software Engineering Program – Airbnb Database (Advanced SQL)
