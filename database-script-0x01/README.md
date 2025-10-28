

# 🏡 Airbnb Clone Database Schema

This directory contains the **Data Definition Language (DDL)** scripts for the Airbnb Clone backend system.  
It defines all the database tables, relationships, and constraints based on the system specification.

---

## 📂 Files
- **schema.sql** → Defines all tables, relationships, and indexes.
- **README.md** → Provides explanation and usage instructions.

---

## 🧩 Entities
| Table | Description |
|--------|--------------|
| **user** | Stores guest, host, and admin profiles |
| **property** | Contains property listings managed by hosts |
| **booking** | Tracks reservations between users and properties |
| **payment** | Records payment transactions for bookings |
| **review** | Stores user ratings and comments for properties |
| **message** | Manages communication between users |

---

## ⚙️ How to Use

1. Open your PostgreSQL shell or any SQL client connected to your database.
2. Run the script:

```bash
psql -U <username> -d <database_name> -f schema.sql
