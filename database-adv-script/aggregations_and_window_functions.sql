-- Total Number of Bookings by Each User (Aggregation)

SELECT 
  u.user_id,
  u.first_name,
  u.last_name,
  COUNT(b.booking_id) AS total_bookings
FROM "User" u
JOIN "Booking" b ON u.user_id = b.user_id
GROUP BY u.user_id, u.first_name, u.last_name
ORDER BY total_bookings DESC;

-- Rank Properties by Total Number of Bookings (Window Function)

SELECT 
  property_id,
  property_name,
  total_bookings,
  ROW_NUMBER() OVER (ORDER BY total_bookings DESC) AS row_number
FROM (
  SELECT 
    p.property_id,
    p.name AS property_name,
    COUNT(b.booking_id) AS total_bookings
  FROM "Property" p
  LEFT JOIN "Booking" b ON p.property_id = b.property_id
  GROUP BY p.property_id, p.name
) AS booking_counts;

