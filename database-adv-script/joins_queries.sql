-- Inner join to retrieve all bookings and the respective users who made those bookings:

SELECT 
  b.booking_id,
  b.start_date,
  b.end_date,
  b.total_price,
  b.status,
  u.user_id,
  u.first_name,
  u.last_name,
  u.email
FROM "Booking" b
INNER JOIN "User" u ON b.user_id = u.user_id;

-- LEFT JOIN – Properties and Their Reviews (including properties with no reviews)

SELECT 
  p.property_id,
  p.name AS property_name,
  r.review_id,
  r.rating,
  r.comment,
  r.created_at
FROM "Property" p
LEFT JOIN "Review" r ON p.property_id = r.property_id;
ORDER BY p.property_id;


-- FULL OUTER JOIN – All Users and All Bookings

SELECT 
  u.user_id,
  u.first_name,
  u.last_name,
  b.booking_id,
  b.start_date,
  b.end_date,
  b.total_price,
  b.status
FROM "User" u
FULL OUTER JOIN "Booking" b ON u.user_id = b.user_id;


-- Non-correlated subquery - Find all properties where the average rating is greater than 4.0

SELECT 
  p.property_id,
  p.name,
  p.description,
  p.price_per_night
FROM "Property" p
WHERE p.property_id IN (
  SELECT r.property_id
  FROM "Review" r
  GROUP BY r.property_id
  HAVING AVG(r.rating) > 4.0
);


-- correlated subquery: Find users who have made more than 3 bookings

SELECT 
  u.user_id,
  u.first_name,
  u.last_name,
  u.email
FROM "User" u
WHERE (
  SELECT COUNT(*)
  FROM "Booking" b
  WHERE b.user_id = u.user_id
) > 3;
