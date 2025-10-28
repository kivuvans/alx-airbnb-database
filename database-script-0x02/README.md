# 🏡 Airbnb Clone Database Seeding
This directory contains SQL scripts to populate the **Airbnb Clone Database** with sample, realistic data for development and testing purposes.

---

## 📂 Files
- **seed.sql** – SQL script that inserts sample records into all tables.
- **README.md** – Documentation explaining the data seeding process.

---

## 🧩 Tables Populated
- **User**
- **Property**
- **Booking**
- **Payment**
- **Review**
- **Message**

---

## ⚙️ How to Use
1. Ensure the database schema has already been created.
2. Run the seed script in your SQL environment:

```bash
psql -U <username> -d <database_name> -f seed.sql
