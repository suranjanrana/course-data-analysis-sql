# Topic 12 — Common Table Expressions (CTEs)

## 12.1 What is a CTE?

A Common Table Expression (CTE) is a temporary named result set that exists only for the duration of a single query.

You define it using the WITH keyword and then reference it like a table.

### Why data analysts use CTEs

- Break complex queries into logical steps
- Improve readability and maintainability
- Avoid repeating subqueries
- Make debugging easier
- Prepare datasets for analytics and reporting

👉 Think of a CTE as a temporary view inside a query.

## 12.2 Syntax

```sql
WITH cte_name AS (
    SELECT columns
    FROM table
    WHERE condition
)
SELECT *
FROM cte_name;
-- The CTE is defined first
-- The main query uses the CTE like a table
```

**Important points:**

- CTE must come before the main SELECT
- CTE exists only during query execution
- You can define multiple CTEs

## 12.3 Practice Tables

We’ll continue using the same tables.

- Employees table
- sales.orders table

## 12.4 Simple CTE Example

### Total Sales per Employee Using a CTE

```sql
WITH employee_sales AS (
    SELECT empid,
           SUM(amount) AS total_sales
    FROM sales.orders
    GROUP BY empid
)
SELECT *
FROM employee_sales;
-- Step 1: Aggregate sales per employee
-- Step 2: Select from the CTE
```

**Why use a CTE here?**

This becomes very useful when the result is reused multiple times.

---

## 12.5 CTE vs Subquery

### Using a Subquery

```sql
SELECT empid, total_sales
FROM (
    SELECT empid,
           SUM(amount) AS total_sales
    FROM sales.orders
    GROUP BY empid
) t;
-- Harder to read as logic grows
```

### Using a CTE (Preferred)

```sql
WITH employee_sales AS (
    SELECT empid,
           SUM(amount) AS total_sales
    FROM sales.orders
    GROUP BY empid
)
SELECT empid, total_sales
FROM employee_sales;
-- Cleaner and easier to maintain
```

## 12.6 CTE with Filtering

### High-Performing Employees (Above Average)

```sql
WITH employee_sales AS (
    SELECT empid,
           SUM(amount) AS total_sales
    FROM sales.orders
    GROUP BY empid
)
SELECT empid, total_sales
FROM employee_sales
WHERE total_sales > (
    SELECT AVG(total_sales)
    FROM employee_sales
);
-- CTE reused inside subquery
-- Clear business logic
```

**Scenario:**

Identify employees eligible for bonuses.

## 12.7 Multiple CTEs in One Query

### Monthly Sales + Employee Totals

```sql
WITH monthly_sales AS (
    SELECT empid,
           DATE_TRUNC('month', order_date) AS month,
           SUM(amount) AS monthly_sales
    FROM sales.orders
    GROUP BY empid, month
),
employee_totals AS (
    SELECT empid,
           SUM(amount) AS total_sales
    FROM sales.orders
    GROUP BY empid
)
SELECT m.empid,
       m.month,
       m.monthly_sales,
       e.total_sales
FROM monthly_sales m
JOIN employee_totals e
ON m.empid = e.empid;
-- Multiple CTEs defined
-- Each solves one logical problem
```

## 12.8 CTE + Window Function

### Rank Employees by Total Sales

```sql
WITH employee_sales AS (
    SELECT empid,
           SUM(amount) AS total_sales
    FROM sales.orders
    GROUP BY empid
)
SELECT empid,
       total_sales,
       RANK() OVER (ORDER BY total_sales DESC) AS sales_rank
FROM employee_sales;
-- CTE prepares aggregated data
-- Window function ranks results
```

## 12.9 CTEs for Data Quality Checks

### Employees Without Sales

```sql
WITH sales_employees AS (
    SELECT DISTINCT empid
    FROM sales.orders
)
SELECT e.empid, e.firstname
FROM hr.employees e
LEFT JOIN sales_employees s
ON e.empid = s.empid
WHERE s.empid IS NULL;
-- CTE isolates sales-related employees
-- LEFT JOIN identifies missing relationships
```

## 12.10 Notes 📝

- CTEs improve readability, not performance by default
- PostgreSQL may inline CTEs (optimizer-dependent)
- Use CTEs when:
  - Query has multiple logical steps
  - Same derived dataset is reused
  - Teaching or explaining SQL logic
- Prefer meaningful CTE names

## 12.11 Other examples

### Bonus Eligibility Report

```sql
WITH employee_sales AS (
    SELECT empid,
           SUM(amount) AS total_sales
    FROM sales.orders
    GROUP BY empid
)
SELECT e.firstname, es.total_sales
FROM employee_sales es
JOIN hr.employees e
ON es.empid = e.empid
WHERE es.total_sales > 1000;
-- Real business rule
-- Easy to modify threshold
```
