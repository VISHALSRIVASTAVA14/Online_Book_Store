# Online_Book_Store
This repository showcases a complete SQL-based Online Bookstore Management System built using three CSV datasets: books.csv, customers.csv, and orders.csv. The project demonstrates database design, data import, and execution of both basic and advanced SQL queries.
.

🗂️ Dataset Overview
1. books.csv

Primary Key: Book_ID

Columns: Title, Author, Price, Stock

Contains detailed information about all books available in the store.

2. customers.csv

Primary Key: Customer_ID

Columns: Name, City, Country

Stores customer details for all registered buyers.

3. orders.csv

Primary Key: Order_ID

Foreign Keys: Customer_ID → Customers table, Book_ID → Books table

Columns: Amount, Quantity_Sold, Date, etc.

Stores transactional information for each customer order.

🛠️ What I Did in This Project

Designed and created three relational tables matching the CSV file structures.

Used SQL IMPORT methods to load all three CSV datasets into the database.

Ensured proper primary and foreign key constraints for referential integrity.

Executed 20 SQL queries to analyze and test the database:

11 Basic Queries: SELECT, WHERE, ORDER BY, GROUP BY, aggregate functions, etc.

9 Advanced Queries: Joins, subqueries, nested queries, set operations, aggregate + join combinations, window functions, etc.

🎯 Project Highlights

Demonstrates complete data flow from raw CSV files → database tables → analytical SQL queries.

Covers real-world scenarios like book availability, order tracking, customer insights, and sales analytics.

Good practice for understanding database normalization, foreign key relationships, and query optimization.

📌 Tech Stack

SQL (PostgreSQL / MySQL – specify your DBMS)

CSV data import tools
