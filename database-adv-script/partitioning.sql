-- 1. Rename the original Booking table
ALTER TABLE "Booking" RENAME TO "Booking_old";

-- 2. Create new partitioned Booking table
CREATE TABLE "Booking" (
  booking_id UUID NOT NULL,
  property_id UUID NOT NULL,
  user_id UUID NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  total_price DECIMAL NOT NULL,
  status booking_status NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (booking_id, start_date)
) PARTITION BY RANGE (start_date);

-- 3. Create partitions (e.g., monthly)
CREATE TABLE "Booking_2024_01" PARTITION OF "Booking"
  FOR VALUES FROM ('2024-01-01') TO ('2024-02-01');

CREATE TABLE "Booking_2024_02" PARTITION OF "Booking"
  FOR VALUES FROM ('2024-02-01') TO ('2024-03-01');

CREATE TABLE "Booking_2024_03" PARTITION OF "Booking"
  FOR VALUES FROM ('2024-03-01') TO ('2024-04-01');

-- Add more partitions as needed...

-- 4. Reinsert data into partitioned table (example)
INSERT INTO "Booking"
SELECT * FROM "Booking_old";

-- 5. Optional: Drop old table after validation
-- DROP TABLE "Booking_old";

-- 6. Query using filter on start_date
EXPLAIN ANALYZE
SELECT * FROM "Booking"
WHERE start_date BETWEEN '2024-02-01' AND '2024-02-15';
