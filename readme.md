# Vehicle Rental Management System

This project contains a localized database schema for managing a vehicle rental service. It focuses on maintaining data integrity through SQL constraints and performing targeted data analysis.

## 🗺️ Entity Relationship Diagram (ERD)
The database architecture is designed for scalability and referential integrity.
View the live diagram here: **[DrawSQL - Vehicle Rental System](https://drawsql.app/teams/md-rakibul/diagrams/vehicle-rental-system)**

## 🚀 Technical Features
- **Strict Data Validation**: Implements `CHECK` constraints to ensure logical consistency (e.g., `end_date` must be after `start_date`).
- **Standardized Roles**: Utilizes default values and domain constraints for User Roles and Vehicle Status.
- **Relational Integrity**: Employs Foreign Key constraints to maintain links between customers, vehicles, and their respective bookings.

## 📊 Analytical Queries Explained

### Query 1: Multi-Table Data Retrieval (JOIN)
- **Objective**: Generate a comprehensive report linking bookings to specific users and vehicles.
- **Method**: Uses `INNER JOIN` with table aliasing to flatten the relational structure into a human-readable format.

### Query 2: Orphaned Record Identification (EXISTS)
- **Objective**: Identify inventory that has never been utilized (booked).
- **Method**: Implements a `NOT EXISTS` correlated subquery. This is highly optimized as it stops the search immediately upon finding the first match for a vehicle.

### Query 3: Conditional Filtering (WHERE)
- **Objective**: Filter the fleet based on specific availability and category criteria.
- **Method**: Uses multi-conditional `WHERE` clauses to target specific business needs (e.g., "Available Cars").

### Query 4: Performance Aggregation (GROUP BY & HAVING)
- **Objective**: Identify high-demand vehicles.
- **Method**: Groups data by vehicle name and calculates frequency. It uses `HAVING` to filter results based on the aggregated count, which is not possible using a standard `WHERE` clause.

## 🛠️ Installation & Usage
1. Clone this repository.
2. Execute the schema definitions in your PostgreSQL environment.
3. Populate the database using the provided seed data in `queries.sql`.
4. Run the analytical queries to generate business insights.

---
