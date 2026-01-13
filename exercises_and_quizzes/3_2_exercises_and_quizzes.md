# Exercises & Quizzes

## Practice Tables

We keep using:

- Employees table
- sales.orders table

---

## Exercises

1. Create a CTE to calculate total sales per employee
2. Filter employees with sales above average
3. Use multiple CTEs in one query
4. Compare CTE vs subquery
5. Identify employees with no sales using CTE
6. Rewrite a subquery using a CTE

---

## Quiz

### Multiple Choice

1. Q1. What is a Common Table Expression (CTE)?

    - a. A permanent table stored in the database
    - b. A temporary result set available only during query execution
    - c. A replacement for indexes
    - d. A type of join

2. Which keyword is used to define a CTE in SQL?

    - a. TEMP
    - b. VIEW
    - c. WITH
    - d. AS

3. Where must a CTE be defined in a SQL query?

    - a. After the SELECT statement
    - b. Inside the WHERE clause
    - c. Before the main SELECT statement
    - d. At the end of the query

4. How long does a CTE exist?

    - a. Until the database connection is closed
    - b. Until the transaction ends
    - c. Until the query finishes execution
    - d. Permanently unless dropped

5. Which of the following is a key advantage of using CTEs?

    - a. They always improve query performance
    - b. They replace GROUP BY
    - c. They improve query readability and structure
    - d. They create physical tables

6. Can a CTE be referenced more than once in the same query?

    - a. No, it can only be used once
    - b. Yes, it can be reused multiple times
    - c. Only if it contains joins
    - d. Only in PostgreSQL

7. Which statement about CTEs and subqueries is correct?

    - a. CTEs cannot contain subqueries
    - b. Subqueries are always faster than CTEs
    - c. CTEs are often easier to read than nested subqueries
    - d. Subqueries cannot be reused

8. Which scenario is best suited for using a CTE?

    - a. Simple SELECT with no filtering
    - b. Very small tables
    - c. Multi-step analytical logic
    - d. Creating indexes

9. What happens if you try to reference a CTE outside its query?

    - a. It works like a view
    - b. It creates a temporary table
    - c. It throws an error
    - d. It returns NULL values

10. Which combination is commonly used by data analysts?

    - a. CTE + DELETE
    - b. CTE + TRUNCATE
    - c. CTE + Window Functions
    - d. CTE + Index

---

### Answers

1. ✅ **Answer:**  b
2. ✅ **Answer:**  c
3. ✅ **Answer:**  c
4. ✅ **Answer:**  c
5. ✅ **Answer:**  c
6. ✅ **Answer:**  b
7. ✅ **Answer:**  c
8. ✅ **Answer:**  c
9. ✅ **Answer:**  c
10. ✅ **Answer:**  c
