-- Initial complex query: Retrieve bookings with user, property, and payment details

SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status AS booking_status,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.price_per_night,
    pay.payment_id,
    pay.amount,
    pay.payment_date,
    pay.payment_method
FROM "Booking" b
JOIN "User" u ON b.user_id = u.user_id
JOIN "Property" p ON b.property_id = p.property_id
LEFT JOIN "Payment" pay ON b.booking_id = pay.booking_id
WHERE b.status = 'confirmed'
  AND p.price_per_night > 100
  AND u.role = 'guest';


-- analysis query
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status AS booking_status,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.price_per_night,
    pay.payment_id,
    pay.amount,
    pay.payment_date,
    pay.payment_method
FROM "Booking" b
JOIN "User" u ON b.user_id = u.user_id
JOIN "Property" p ON b.property_id = p.property_id
LEFT JOIN "Payment" pay ON b.booking_id = pay.booking_id;


-- Refactored query with selected fields and indexing considered
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    u.first_name || ' ' || u.last_name AS full_name,
    p.name AS property_name,
    pay.amount AS payment_amount
FROM "Booking" b
JOIN "User" u ON b.user_id = u.user_id
JOIN "Property" p ON b.property_id = p.property_id
LEFT JOIN "Payment" pay ON b.booking_id = pay.booking_id
ORDER BY b.created_at DESC
LIMIT 100;
