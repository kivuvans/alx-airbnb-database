# 🧩 Database Normalization – Airbnb Clone Project
# Objective

To ensure that the database design for the Airbnb Clone is optimized, free of redundancy, and adheres to the Third Normal Form (3NF).

# Understanding Normalization

Normalization is the process of organizing data in a database to:

Eliminate redundancy

Ensure data integrity

Simplify maintenance and updates

# Normalization Stages

# First Normal Form (1NF):

Each column holds atomic (indivisible) values.

Each record is unique.

# Second Normal Form (2NF):

Meets 1NF.

Every non-key attribute depends on the entire primary key (for composite keys).

# Third Normal Form (3NF):

Meets 2NF.

There are no transitive dependencies (non-key attributes depend only on the primary key).

# Normalization Steps Applied
# 1. User Table

Attributes:

user_id (PK), first_name, last_name, email, password_hash, phone_number, role, created_at


✅ 1NF: All attributes contain atomic values (no repeating groups).
✅ 2NF: The table has a single primary key (user_id), and all attributes depend on it.
✅ 3NF: No attribute depends on another non-key attribute — for example, email does not determine first_name.

✅ Result: The User table is in 3NF.


# 2. Property Table

Attributes:

property_id (PK), host_id (FK), name, description, location, price_per_night, created_at, updated_at


✅ 1NF: Each field holds atomic values.
✅ 2NF: All non-key attributes depend on the entire key (property_id).
✅ 3NF: No transitive dependency — host_id only references the User table for ownership; price_per_night and location depend directly on the property, not the host.

✅ Result: The Property table is in 3NF.

# 3. Booking Table

Attributes:

booking_id (PK), property_id (FK), user_id (FK), start_date, end_date, total_price, status, created_at


✅ 1NF: All data is atomic.
✅ 2NF: Each non-key attribute depends on the full primary key (booking_id).
✅ 3NF: There are no attributes that depend on others — status and total_price depend only on booking_id.

✅ Result: The Booking table is in 3NF.

# 4. Payment Table

Attributes:

payment_id (PK), booking_id (FK), amount, payment_date, payment_method


✅ 1NF: No repeating fields.
✅ 2NF: Single primary key ensures full dependency.
✅ 3NF: No transitive dependency — each field depends directly on payment_id.

✅ Result: The Payment table is in 3NF.

# 5. Review Table

Attributes:

review_id (PK), property_id (FK), user_id (FK), rating, comment, created_at


✅ 1NF: Each review has atomic attributes.
✅ 2NF: All attributes depend on review_id.
✅ 3NF: No attribute depends on another non-key field — rating and comment depend only on review_id.

✅ Result: The Review table is in 3NF.

# 6. Message Table

Attributes:

message_id (PK), sender_id (FK), recipient_id (FK), message_body, sent_at


✅ 1NF: Atomic fields.
✅ 2NF: All fields depend on message_id.
✅ 3NF: No transitive dependencies exist.

✅ Result: The Message table is in 3NF.


# Summary of Normalization Results
| Table Name | Normal Form Achieved | Key Points                                |
| ---------- | -------------------- | ----------------------------------------- |
| User       | 3NF                  | Unique email, atomic fields               |
| Property   | 3NF                  | Linked to User via host_id                |
| Booking    | 3NF                  | Avoids redundant property or user data    |
| Payment    | 3NF                  | Depends only on booking_id                |
| Review     | 3NF                  | Independent of property/user transitivity |
| Message    | 3NF                  | Clear sender-recipient relationship       |

Conclusion

All tables in the Airbnb Clone Database adhere to the Third Normal Form (3NF).
This ensures:

Minimal data redundancy

Efficient data management

Strong data integrity and consistency

