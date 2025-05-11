-- Enable uuid generation
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ENUM types
CREATE TYPE user_role AS ENUM ('guest', 'host', 'admin');
CREATE TYPE booking_status AS ENUM ('pending', 'confirmed', 'canceled');
CREATE TYPE payment_method_enum AS ENUM ('credit_card', 'paypal', 'stripe');

-- User table
CREATE TABLE "User" (
  "user_id" UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  "first_name" VARCHAR NOT NULL,
  "last_name" VARCHAR NOT NULL,
  "email" VARCHAR UNIQUE NOT NULL,
  "password_hash" VARCHAR NOT NULL,
  "phone_number" VARCHAR,
  "role" user_role NOT NULL,
  "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Location table
CREATE TABLE "Location" (
  "location_id" UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  "city" VARCHAR NOT NULL,
  "state" VARCHAR,
  "country" VARCHAR NOT NULL
);

-- Property table
CREATE TABLE "Property" (
  "property_id" UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  "host_id" UUID NOT NULL,
  "name" VARCHAR NOT NULL,
  "description" TEXT NOT NULL,
  "location_id" UUID NOT NULL,
  "price_per_night" DECIMAL NOT NULL,
  "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  "updated_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY ("host_id") REFERENCES "User" ("user_id"),
  FOREIGN KEY ("location_id") REFERENCES "Location" ("location_id")
);

-- Booking table
CREATE TABLE "Booking" (
  "booking_id" UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  "property_id" UUID NOT NULL,
  "user_id" UUID NOT NULL,
  "start_date" DATE NOT NULL,
  "end_date" DATE NOT NULL,
  "total_price" DECIMAL NOT NULL,
  "status" booking_status NOT NULL,
  "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY ("property_id") REFERENCES "Property" ("property_id"),
  FOREIGN KEY ("user_id") REFERENCES "User" ("user_id")
);

-- Payment table
CREATE TABLE "Payment" (
  "payment_id" UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  "booking_id" UUID NOT NULL,
  "amount" DECIMAL NOT NULL,
  "payment_date" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  "payment_method" payment_method_enum NOT NULL,
  FOREIGN KEY ("booking_id") REFERENCES "Booking" ("booking_id")
);

-- Review table
CREATE TABLE "Review" (
  "review_id" UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  "property_id" UUID NOT NULL,
  "user_id" UUID NOT NULL,
  "rating" INTEGER NOT NULL CHECK ("rating" >= 1 AND "rating" <= 5),
  "comment" TEXT NOT NULL,
  "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY ("property_id") REFERENCES "Property" ("property_id"),
  FOREIGN KEY ("user_id") REFERENCES "User" ("user_id")
);

-- Message table
CREATE TABLE "Message" (
  "message_id" UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  "sender_id" UUID NOT NULL,
  "recipient_id" UUID NOT NULL,
  "message_body" TEXT NOT NULL,
  "sent_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY ("sender_id") REFERENCES "User" ("user_id"),
  FOREIGN KEY ("recipient_id") REFERENCES "User" ("user_id")
);

-- Indexes
CREATE INDEX idx_user_email ON "User" ("email");
CREATE INDEX idx_property_property_id ON "Property" ("property_id");
CREATE INDEX idx_booking_property_id ON "Booking" ("property_id");
CREATE INDEX idx_booking_booking_id ON "Booking" ("booking_id");
CREATE INDEX idx_payment_booking_id ON "Payment" ("booking_id");
