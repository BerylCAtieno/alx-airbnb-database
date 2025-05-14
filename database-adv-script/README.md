## Advanced SQL Queries

🔹 1. INNER JOIN – Bookings and Respective Users
Retrieve all bookings and the respective users who made those bookings

🔹 2. LEFT JOIN – Properties and Their Reviews (including properties with no reviews)

This lists all properties, with review data if available. Properties without reviews will show NULL in review fields.

🔹 3. FULL OUTER JOIN – All Users and All Bookings

Retreive 
- Users who have made bookings (matched rows),

- Users who haven't made any bookings (booking fields will be NULL),

- Bookings not linked to any user (user fields will be NULL — which ideally shouldn't happen if the data is clean and foreign key constraints are enforced, but it's still useful for auditing or diagnosing orphaned data).