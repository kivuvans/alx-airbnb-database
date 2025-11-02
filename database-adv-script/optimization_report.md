
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

