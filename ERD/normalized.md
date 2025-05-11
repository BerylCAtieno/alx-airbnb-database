# Database Normalization Report

## Objective
Normalize the database schema for a property rental platform to ensure it satisfies **Third Normal Form (3NF)**—eliminating redundancy and ensuring data integrity.

---

## Initial Review

The original schema contained the following tables:

- User
- Property
- Booking
- Payment
- Review
- Message

Most tables were well-structured, but one issue was identified:
- The `location` field in the `Property` table was a single VARCHAR value. This presented a **transitive dependency** and potential data redundancy (e.g., storing "Nairobi, Kenya" multiple times across rows).

---

## Normalization Steps

### 1First Normal Form (1NF)
- All tables have atomic columns (no arrays or repeating groups).
- Each table has a primary key.

✅ Already satisfied.

---

### Second Normal Form (2NF)
- No partial dependencies exist since all primary keys are single-column.
  
✅ Already satisfied.

---

### Third Normal Form (3NF)
- Identified and removed a transitive dependency in the `Property` table by extracting `location` into its own table.
- This ensures non-key attributes only depend on the primary key.

✅ Now satisfied after refactoring.

---

## Final 3NF Compliant ERD

![Airbnb project ERD diagram](https://raw.githubusercontent.com/BerylCAtieno/alx-airbnb-database/main/ERD/normalized.png)
