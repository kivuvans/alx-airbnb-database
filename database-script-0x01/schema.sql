-- ============================================================
-- Airbnb Clone Database Schema (DDL)
-- Author: Evans Kivuva
-- ALX Software Engineering - Back-End Web Pro-Development
-- ============================================================

-- Enable extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ============================================================
-- USER TABLE
-- ============================================================
CREATE TABLE IF NOT EXISTS "user" (
    user_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20),
    role VARCHAR(20) CHECK (role IN ('guest', 'host', 'admin')) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Index for faster lookup by email
CREATE INDEX IF NOT EXISTS idx_user_email ON "user" (email);

-- ============================================================
-- PROPERTY TABLE
-- ============================================================
CREATE TABLE IF NOT EXISTS property (
    property_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    host_id UUID NOT NULL,
    name VARCHAR(200) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(200) NOT NULL,
    pricepernight DECIMAL(10,2) NOT NULL CHECK (pricepernight > 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (host_id) REFERENCES "user"(user_id) ON DELETE CASCADE
);

-- Index for frequent searches
CREATE INDEX IF NOT EXISTS idx_property_location ON property (location);
CREATE INDEX IF NOT EXISTS idx_property_price ON property (pricepernight);

-- ============================================================
-- BOOKING TABLE
-- ============================================================
CREATE TABLE IF NOT EXISTS booking (
    booking_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10,2) NOT NULL CHECK (total_price >= 0),
    status VARCHAR(20) CHECK (status IN ('pending', 'confirmed', 'canceled')) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES property(property_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES "user"(user_id) ON DELETE CASCADE
);

-- Index for booking lookups
CREATE INDEX IF NOT EXISTS idx_booking_property_id ON booking (property_id);
CREATE INDEX IF NOT EXISTS idx_booking_user_id ON booking (user_id);

-- ============================================================
-- PAYMENT TABLE
-- ============================================================
CREATE TABLE IF NOT EXISTS payment (
    payment_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    booking_id UUID NOT NULL,
    amount DECIMAL(10,2) NOT NULL CHECK (amount > 0),
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method VARCHAR(50) CHECK (payment_method IN ('credit_card', 'paypal', 'stripe')) NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES booking(booking_id) ON DELETE CASCADE
);

-- Index for quick access
CREATE INDEX IF NOT EXISTS idx_payment_booking_id ON payment (booking_id);

-- ============================================================
-- REVIEW TABLE
-- ============================================================
CREATE TABLE IF NOT EXISTS review (
    review_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 5) NOT NULL,
    comment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES property(property_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES "user"(user_id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_review_property_id ON review (property_id);

-- ============================================================
-- MESSAGE TABLE
-- ============================================================
CREATE TABLE IF NOT EXISTS message (
    message_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    sender_id UUID NOT NULL,
    recipient_id UUID NOT NULL,
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES "user"(user_id) ON DELETE CASCADE,
    FOREIGN KEY (recipient_id) REFERENCES "user"(user_id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_message_sender_id ON message (sender_id);
CREATE INDEX IF NOT EXISTS idx_message_recipient_id ON message (recipient_id);

-- ============================================================
-- END OF SCHEMA
-- ============================================================
