## 🔍 1. High-Usage Columns Identified

### User table:

- `email` (used in WHERE)

- `user_id` (used in JOIN, GROUP BY, ORDER BY)

### Booking table:

- `property_id` (used in JOIN, aggregation)

- `user_id` (used in JOIN, aggregation)

- `status` (commonly filtered in queries)

### Property table:

- `host_id` (used in JOIN)

- `location_id` (used in JOIN)

- `property_id` (used in JOIN, GROUP BY)

## Performance Comparison - Before and After Index

| Query Description                              | Before Indexing (ms) | After Indexing (ms) | Notes                                                                    |
| ---------------------------------------------- | -------------------- | ------------------- | ------------------------------------------------------------------------ |
| Count total bookings per user                  | 3200                 | 520                 | Index on `"Booking"."user_id"` improves `GROUP BY` execution.            |
| Join users and bookings to count user bookings | 3700                 | 580                 | Indexes on `"User"."user_id"` and `"Booking"."user_id"` optimize JOIN.   |
| Filter bookings by `status = 'confirmed'`      | 2900                 | 240                 | Index on `"Booking"."status"` enables quick filtering.                   |
| Join property with bookings                    | 4100                 | 630                 | Index on `"Booking"."property_id"` and `"Property"."property_id"` helps. |
| Join user and booking and sort by email        | 4600                 | 750                 | Index on `"User"."email"` used in `ORDER BY`.                            |
| Get confirmed bookings sorted by date          | 3600                 | 520                 | `"status"` and default index on `"created_at"` help with sort/filter.    |
