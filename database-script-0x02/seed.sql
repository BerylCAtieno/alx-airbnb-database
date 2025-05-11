-- Enable extension if not already
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Insert Users
INSERT INTO "User" (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at)
VALUES 
  (uuid_generate_v4(), 'Alice', 'Smith', 'alice@example.com', 'hashedpassword1', '123-456-7890', 'guest', NOW()),
  (uuid_generate_v4(), 'Bob', 'Johnson', 'bob@example.com', 'hashedpassword2', '321-654-0987', 'host', NOW()),
  (uuid_generate_v4(), 'Carol', 'Lee', 'carol@example.com', 'hashedpassword3', '456-789-1234', 'admin', NOW());

-- Insert Locations
INSERT INTO "Location" (location_id, city, state, country)
VALUES 
  (uuid_generate_v4(), 'New York', 'NY', 'USA'),
  (uuid_generate_v4(), 'Los Angeles', 'CA', 'USA'),
  (uuid_generate_v4(), 'Paris', NULL, 'France');

-- Retrieve inserted location_ids and host user_id for Property references
-- You can use SELECT queries here during testing, or hardcode UUIDs in practice

-- Insert Properties
INSERT INTO "Property" (property_id, host_id, name, description, location_id, price_per_night, created_at, updated_at)
SELECT 
  uuid_generate_v4(), u.user_id, 'Cozy Loft in NY', 'A cozy studio apartment in Manhattan.', l.location_id, 120.00, NOW(), NOW()
FROM "User" u, "Location" l
WHERE u.email = 'bob@example.com' AND l.city = 'New York'
UNION
SELECT 
  uuid_generate_v4(), u.user_id, 'Sunny Villa LA', 'Spacious villa with pool.', l.location_id, 250.00, NOW(), NOW()
FROM "User" u, "Location" l
WHERE u.email = 'bob@example.com' AND l.city = 'Los Angeles';

-- Insert Bookings
INSERT INTO "Booking" (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at)
SELECT 
  uuid_generate_v4(), p.property_id, u.user_id, '2025-06-01', '2025-06-05', 480.00, 'confirmed', NOW()
FROM "Property" p, "User" u
WHERE p.name = 'Cozy Loft in NY' AND u.email = 'alice@example.com'
UNION
SELECT 
  uuid_generate_v4(), p.property_id, u.user_id, '2025-07-10', '2025-07-15', 1250.00, 'pending', NOW()
FROM "Property" p, "User" u
WHERE p.name = 'Sunny Villa LA' AND u.email = 'alice@example.com';

-- Insert Payments
INSERT INTO "Payment" (payment_id, booking_id, amount, payment_date, payment_method)
SELECT 
  uuid_generate_v4(), b.booking_id, b.total_price, NOW(), 'credit_card'
FROM "Booking" b
WHERE b.status = 'confirmed';

-- Insert Reviews
INSERT INTO "Review" (review_id, property_id, user_id, rating, comment, created_at)
SELECT 
  uuid_generate_v4(), p.property_id, u.user_id, 5, 'Amazing stay! Highly recommended.', NOW()
FROM "Property" p, "User" u
WHERE p.name = 'Cozy Loft in NY' AND u.email = 'alice@example.com'
UNION
SELECT 
  uuid_generate_v4(), p.property_id, u.user_id, 4, 'Nice place but a bit noisy.', NOW()
FROM "Property" p, "User" u
WHERE p.name = 'Sunny Villa LA' AND u.email = 'alice@example.com';

-- Insert Messages
INSERT INTO "Message" (message_id, sender_id, recipient_id, message_body, sent_at)
SELECT 
  uuid_generate_v4(), s.user_id, r.user_id, 'Is the property available on the weekend?', NOW()
FROM "User" s, "User" r
WHERE s.email = 'alice@example.com' AND r.email = 'bob@example.com'
UNION
SELECT 
  uuid_generate_v4(), s.user_id, r.user_id, 'Yes, it is available. I’ve blocked the dates.', NOW()
FROM "User" s, "User" r
WHERE s.email = 'bob@example.com' AND r.email = 'alice@example.com';
