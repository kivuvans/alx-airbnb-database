
-- ==============================================
-- Airbnb Clone Database - Sample Data Seeding
-- Author: Evans Kivuva
-- ALX Software Engineering - Back-End Web Pro-Development
-- ==============================================

-- Clear previous data (for repeatable runs)
DELETE FROM payment;
DELETE FROM booking;
DELETE FROM review;
DELETE FROM property;
DELETE FROM message;
DELETE FROM "user";

-- ==============================================
-- Insert Users
-- ==============================================
INSERT INTO "user" (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at)
VALUES
('u1', 'Alice', 'Kimani', 'alice.kimani@example.com', 'hashedpassword1', '+254711223344', 'host', NOW()),
('u2', 'Brian', 'Omondi', 'brian.omondi@example.com', 'hashedpassword2', '+254722334455', 'guest', NOW()),
('u3', 'Carol', 'Mwangi', 'carol.mwangi@example.com', 'hashedpassword3', '+254733445566', 'guest', NOW()),
('u4', 'David', 'Mutua', 'david.mutua@example.com', 'hashedpassword4', '+254744556677', 'host', NOW()),
('u5', 'Evelyn', 'Otieno', 'evelyn.otieno@example.com', 'hashedpassword5', '+254755667788', 'admin', NOW());

-- ==============================================
-- Insert Properties
-- ==============================================
INSERT INTO property (property_id, host_id, name, description, location, pricepernight, created_at)
VALUES
('p1', 'u1', 'Ocean View Apartment', 'A stunning ocean view apartment in Mombasa.', 'Mombasa, Kenya', 120.00, NOW()),
('p2', 'u1', 'Nairobi City Loft', 'Modern loft in the heart of Nairobi CBD.', 'Nairobi, Kenya', 90.00, NOW()),
('p3', 'u4', 'Serene Lake House', 'Peaceful getaway with a private lake view.', 'Naivasha, Kenya', 150.00, NOW());

-- ==============================================
-- Insert Bookings
-- ==============================================
INSERT INTO booking (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at)
VALUES
('b1', 'p1', 'u2', '2025-10-01', '2025-10-05', 480.00, 'confirmed', NOW()),
('b2', 'p2', 'u3', '2025-10-10', '2025-10-12', 180.00, 'pending', NOW()),
('b3', 'p3', 'u2', '2025-10-20', '2025-10-25', 750.00, 'confirmed', NOW());

-- ==============================================
-- Insert Payments
-- ==============================================
INSERT INTO payment (payment_id, booking_id, amount, payment_date, payment_method)
VALUES
('pay1', 'b1', 480.00, NOW(), 'stripe'),
('pay2', 'b3', 750.00, NOW(), 'paypal');

-- ==============================================
-- Insert Reviews
-- ==============================================
INSERT INTO review (review_id, property_id, user_id, rating, comment, created_at)
VALUES
('r1', 'p1', 'u2', 5, 'Beautiful stay, loved the ocean breeze!', NOW()),
('r2', 'p2', 'u3', 4, 'Nice location but a bit noisy at night.', NOW());

-- ==============================================
-- Insert Messages
-- ==============================================
INSERT INTO message (message_id, sender_id, recipient_id, message_body, sent_at)
VALUES
('m1', 'u2', 'u1', 'Hi Alice, just checking if early check-in is possible.', NOW()),
('m2', 'u1', 'u2', 'Sure Brian, you can check in from 10 AM.', NOW()),
('m3', 'u3', 'u1', 'Is parking available at the Nairobi Loft?', NOW());

-- ==============================================
-- End of Seed Script
-- ==============================================
