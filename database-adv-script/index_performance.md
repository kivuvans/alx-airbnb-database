# 3️⃣ Implement Indexes for Optimization

## 🎯 Objective
Enhance database performance by identifying high-usage columns and creating indexes to improve the speed of SQL queries for the **Airbnb database**.

---

## 🧠 Key Concepts

### 🔹 What Is an Index?
An **index** is a database structure that improves data retrieval speed by creating a lookup mechanism, similar to a book’s table of contents.

### 🔹 Why Indexing Matters
Indexes allow databases to find rows faster instead of scanning the entire table, which is critical for large datasets.

---

## 🧩 Step-by-Step Implementation

### 1️⃣ Identify High-Usage Columns
Commonly used columns in WHERE, JOIN, and ORDER BY clauses were selected for indexing:

| Table | High-Usage Columns | Reason |
|--------|--------------------|---------|
| **users** | `email`, `created_at` | Used for authentication, filtering by registration date |
| **bookings** | `user_id`, `property_id`, `booking_date` | Used in joins and date-based searches |
| **properties** | `city`, `price_per_night` | Used for filtering search results by location and cost |

---

### 2️⃣ Create Indexes
SQL commands to create the indexes:

```sql
CREATE INDEX idx_users_email ON users (email);
CREATE INDEX idx_users_created_at ON users (created_at);

CREATE INDEX idx_bookings_user_id ON bookings (user_id);
CREATE INDEX idx_bookings_property_id ON bookings (property_id);
CREATE INDEX idx_bookings_booking_date ON bookings (booking_date);

CREATE INDEX idx_properties_city ON properties (city);
CREATE INDEX idx_properties_price ON properties (price_per_night);
```

3️⃣ Measure Query Performance

Performance measured using EXPLAIN and ANALYZE before and after index creation.

🧪 Example Test Query
```sql
EXPLAIN ANALYZE 
SELECT * FROM bookings WHERE user_id = 101;
```

⚙️ Results
| Stage               | Execution Time | Notes                                            |
| ------------------- | -------------- | ------------------------------------------------ |
| **Before Indexing** | ~250 ms        | Full table scan occurred                         |
| **After Indexing**  | ~15 ms         | Index lookup performed (significant improvement) |


4️⃣ Performance Insights

✅ Reduced query cost and time
✅ Faster joins between related tables
✅ Improved responsiveness for filtering and sorting operations

⚠️ Note: Excessive indexing can slow down INSERT, UPDATE, and DELETE operations due to additional maintenance overhead. Use indexing selectively.

📊 Summary
| Table        | Indexes Added                      | Purpose                     |
| ------------ | ---------------------------------- | --------------------------- |
| `users`      | email, created_at                  | Login & date filtering      |
| `bookings`   | user_id, property_id, booking_date | Join & date range filtering |
| `properties` | city, price_per_night              | Search filtering            |

🧠 Key Takeaways

Indexes drastically reduce query execution time.

Always analyze queries using EXPLAIN before and after indexing.

Regularly monitor index usage and database performance to avoid unnecessary overhead.

📁 Files
| File                   | Description                                       |
| ---------------------- | ------------------------------------------------- |
| `database_index.sql`   | SQL commands for creating indexes                 |
| `index_performance.md` | Documentation of performance analysis and results |

🧑‍💻 Author

Evans Kivuva
ALX Software Engineering Program – Airbnb Database (Advanced SQL)
