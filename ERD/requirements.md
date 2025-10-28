
# 🧩 Step 1: Entities and Attributes


# User

user_id (PK)

first_name

last_name

email

password_hash

phone_number

role

created_at

# Property

property_id (PK)

host_id (FK → User.user_id)

name

description

location

price_per_night

created_at

updated_at

# Booking

booking_id (PK)

property_id (FK → Property.property_id)

user_id (FK → User.user_id)

start_date

end_date

total_price

status

created_at

# Payment

payment_id (PK)

booking_id (FK → Booking.booking_id)

amount

payment_date

payment_method

# Review

review_id (PK)

property_id (FK → Property.property_id)

user_id (FK → User.user_id)

rating

comment

created_at

# Message

message_id (PK)

sender_id (FK → User.user_id)

recipient_id (FK → User.user_id)

message_body

sent_at



# 🔗 Step 2: Relationships
# Relationship	Type	Description
User → Property	1-to-Many	A User (host) can list many Properties
User → Booking	1-to-Many	A User (guest) can make many Bookings
Property → Booking	1-to-Many	A Property can have many Bookings
Booking → Payment	1-to-1	Each Booking has one Payment
Property → Review	1-to-Many	A Property can have multiple Reviews
User → Review	1-to-Many	A User (guest) can leave many Reviews
User → Message	1-to-Many (self-referencing)	A User can send/receive many Messages


# 🎨 Step 3: ER Diagram (Visual)

```mermaid
erDiagram
    USER {
        UUID user_id PK
        VARCHAR first_name
        VARCHAR last_name
        VARCHAR email
        VARCHAR password_hash
        VARCHAR phone_number
        ENUM role
        TIMESTAMP created_at
    }

    PROPERTY {
        UUID property_id PK
        UUID host_id FK
        VARCHAR name
        TEXT description
        VARCHAR location
        DECIMAL price_per_night
        TIMESTAMP created_at
        TIMESTAMP updated_at
    }

    BOOKING {
        UUID booking_id PK
        UUID property_id FK
        UUID user_id FK
        DATE start_date
        DATE end_date
        DECIMAL total_price
        ENUM status
        TIMESTAMP created_at
    }

    PAYMENT {
        UUID payment_id PK
        UUID booking_id FK
        DECIMAL amount
        TIMESTAMP payment_date
        ENUM payment_method
    }

    REVIEW {
        UUID review_id PK
        UUID property_id FK
        UUID user_id FK
        INTEGER rating
        TEXT comment
        TIMESTAMP created_at
    }

    MESSAGE {
        UUID message_id PK
        UUID sender_id FK
        UUID recipient_id FK
        TEXT message_body
        TIMESTAMP sent_at
    }

    USER ||--o{ PROPERTY : hosts
    USER ||--o{ BOOKING : makes
    PROPERTY ||--o{ BOOKING : has
    BOOKING ||--|| PAYMENT : includes
    PROPERTY ||--o{ REVIEW : receives
    USER ||--o{ REVIEW : writes
    USER ||--o{ MESSAGE : sends
    USER ||--o{ MESSAGE : receives
