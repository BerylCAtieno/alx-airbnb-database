-- User Table Indexes
CREATE INDEX idx_user_user_id ON "User" ("user_id");
CREATE INDEX idx_user_email ON "User" ("email");

-- Booking Table Indexes
CREATE INDEX idx_booking_user_id ON "Booking" ("user_id");
CREATE INDEX idx_booking_property_id ON "Booking" ("property_id");
CREATE INDEX idx_booking_status ON "Booking" ("status");

-- Property Table Indexes
CREATE INDEX idx_property_property_id ON "Property" ("property_id");
CREATE INDEX idx_property_host_id ON "Property" ("host_id");
CREATE INDEX idx_property_location_id ON "Property" ("location_id");


-- Query 1: Count bookings per user
EXPLAIN ANALYZE
SELECT user_id, COUNT(*) AS total_bookings
FROM "Booking"
GROUP BY user_id;

-- Query 2: Join users and bookings
EXPLAIN ANALYZE
SELECT u.user_id, u.email, COUNT(b.booking_id)
FROM "User" u
JOIN "Booking" b ON u.user_id = b.user_id
GROUP BY u.user_id, u.email;

-- Query 3: Get bookings by status
EXPLAIN ANALYZE
SELECT * FROM "Booking" WHERE status = 'confirmed';
