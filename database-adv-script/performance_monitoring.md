
# 6️⃣ Monitor and Refine Database Performance

## 🎯 Objective
Continuously monitor and refine the **Airbnb database performance** by analyzing query execution plans using `EXPLAIN ANALYZE`, identifying bottlenecks, and making schema or index adjustments for efficiency.

---

## 🧩 Step 1: Performance Monitoring Setup

We selected the following **frequently used queries** for performance monitoring:

1. Retrieve all bookings by user:
   ```sql
   SELECT * FROM bookings WHERE user_id = 1023;
