# 🏡 ALX Airbnb Database - Manual Review

## 📖 Project Overview
This project implements a **relational database design** for an Airbnb-like system, built according to software engineering and database normalization principles.  
The database supports **users**, **properties**, **bookings**, **payments**, **reviews**, and **messages**, ensuring full referential integrity and scalability.

---

## 🎯 Objective
The goal of this manual review is to demonstrate:
- Clear **entity identification** and relationships.
- Proper **normalization** (up to Third Normal Form).
- Accurate and efficient **schema design**.
- Sample **data seeding** and relationship consistency.
- Alignment with ALX database project requirements.

---

## 🧩 1. Entities & Attributes

| Entity | Description | Key Attributes |
|--------|--------------|----------------|
| **User** | Stores all users (guests, hosts, admins). | user_id, first_name, last_name, email, password_hash, role |
| **Property** | Represents listings created by hosts. | property_id, host_id, name, description, location, pricepernight |
| **Booking** | Tracks user reservations for properties. | booking_id, property_id, user_id, start_date, end_date, total_price, status |
| **Payment** | Handles payments for confirmed bookings. | payment_id, booking_id, amount, payment_date, payment_method |
| **Review** | Collects guest feedback and ratings. | review_id, property_id, user_id, rating, comment |
| **Message** | Manages user-to-user communication. | message_id, sender_id, recipient_id, message_body |

---

## 🔗 2. Relationships (ERD)

| Relationship | Type | Description |
|---------------|------|--------------|
| User → Property | 1:N | A host can have many properties. |
| Property → Booking | 1:N | A property can have many bookings. |
| User → Booking | 1:N | A user can make multiple bookings. |
| Booking → Payment | 1:1 | Each booking has one corresponding payment. |
| Property → Review | 1:N | A property can have many reviews. |
| User → Review | 1:N | A user can post multiple reviews. |
| User → Message | 1:N | A user can send or receive many messages. |

---

## ⚙️ 3. Normalization Summary

### **First Normal Form (1NF)**
- Each column holds atomic values (no repeating groups).
- Example: `email`, `phone_number`, and `role` are stored as single-value fields.

### **Second Normal Form (2NF)**
- Each non-key attribute depends entirely on its primary key.
- Example: In `property`, `location` and `pricepernight` depend on `property_id`, not on `host_id`.

### **Third Normal Form (3NF)**
- All attributes are independent of non-key attributes.
- Example: `total_price` in `booking` is derived from `property.pricepernight` and `duration`, ensuring no transitive dependency.

**✅ The database design meets 3NF and eliminates redundancy.**

---

## 💾 4. Schema Design Review

- All tables use **UUID primary keys** for scalability.
- Enforced **foreign key constraints** maintain referential integrity.
- Added **CHECK constraints** to validate data (e.g., valid `status`, `role`, `rating`).
- Indexed frequently queried columns (`email`, `location`, `pricepernight`).
- Used `ON DELETE CASCADE` to ensure dependent records are cleaned automatically.

---

## 🧠 5. Example Use Case Workflow

1. A **host (User)** lists a new **Property**.
2. A **guest (User)** browses and makes a **Booking**.
3. The **Payment** table records the guest’s transaction.
4. After stay completion, the guest leaves a **Review**.
5. Optional **Messages** allow communication between users.

---

## 🧰 6. Tools Used
- **Draw.io** → ERD diagram design.
- **PostgreSQL** → Database engine.
- **VS Code** → SQL and documentation editing.
- **Git & GitHub** → Version control and submission.

---

## 📊 7. Validation Checks

| Check | Status | Description |
|--------|--------|-------------|
| Entities properly identified | ✅ | All key entities defined and linked |
| Relationships consistent | ✅ | FK relationships tested via schema |
| Schema executes cleanly | ✅ | Tested in PostgreSQL |
| Meets 3NF | ✅ | No transitive or partial dependencies |
| Indexed for performance | ✅ | Indexes created on key lookup columns |

---

## 💬 8. Reflection

Through this project, I learned how to:
- Transform a real-world business model into a **normalized database**.
- Apply **referential integrity** principles to maintain data consistency.
- Use **DDL and DML scripts** effectively.
- Design and test a schema for scalability and clarity.

This aligns with ALX’s goal of developing **professional back-end engineers** capable of building production-ready systems.

---

## 📎 9. Repository Structure
