# Airbnb Database Schema
## Overview
This project defines a PostgreSQL database schema for an Airbnb-style platform. It includes all core entities such as users, properties, bookings, payments, reviews, and messaging, along with relevant constraints and indexes for performance and data integrity.

## Entities & Relationships
1. User
Stores account information for guests, hosts, and admins.

user_id (UUID): Primary key

email: Unique

role: Enum (guest, host, admin)

2. Property
Represents rental listings created by hosts.

Linked to User via host_id

Linked to Location

3. Location
Defines geographical information for properties.

Includes city, state, and country

4. Booking
Captures property reservations.

Links User and Property

Tracks start_date, end_date, status

5. Payment
Handles financial transactions for bookings.

Linked to Booking

Supports multiple payment_method options

6. Review
User-submitted ratings and comments on properties.

Includes rating (1-5), comment

7. Message
Internal messaging system between users.

sender_id and recipient_id both reference User

## Constraints
Primary Keys: All entities use UUIDs with auto-generated values.

Foreign Keys: Enforce relationships across tables (e.g. Booking.user_id → User.user_id)

Unique Constraints: Email in User must be unique.

Checks: Ratings must be between 1–5.

## Indexes
Indexes have been added to frequently queried columns:

User.email

Property.property_id

Booking.property_id, Booking.booking_id

Payment.booking_id

## Extensions Required

Ensure the uuid-ossp extension is enabled:

```sql

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

```

## Setup
Create database (e.g. airbnb_db)

- Connect using psql or PgAdmin

- Run schema.sql to set up tables and constraints

