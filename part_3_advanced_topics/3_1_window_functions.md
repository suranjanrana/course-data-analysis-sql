# Topic 11 — Window Functions (Analytical Functions)

## 11.1 What Are Window Functions?

A window function performs a calculation across a set of rows related to the current row, without collapsing rows like `GROUP BY`.

👉 This is the key difference:

| Feature     | GROUP BY       | Window Function                      |
| ----------- | -------------- | ------------------------------------ |
| Row count   | Reduces rows   | Keeps all rows                       |
| Aggregation | Per group      | Per row with context                 |
| Use case    | Summary tables | Ranking, running totals, comparisons |

### Why analysts love window functions

- Rankings (top N, bottom N)
- Running totals
- Period-over-period comparisons
- Percent of total
- De-duplication
- Advanced KPIs

## 11.2 General Syntax

```sql
function_name(column)
OVER (
    PARTITION BY column
    ORDER BY column
);
```

- `OVER()` → defines the window
- `PARTITION BY` → groups rows (like GROUP BY, but doesn’t collapse)
- `ORDER BY` → defines order within each partition

## 11.3 Practice Tables

We’ll continue using employee sales data.

```sql
INSERT INTO sales.orders VALUES
(301, 1, 500.00, '2023-01-10'),
(302, 1, 700.00, '2023-02-15'),
(303, 2, 300.00, '2023-01-20'),
(304, 2, 900.00, '2023-03-05'),
(305, 3, 400.00, '2023-02-10');
```

## 11.4 Window Aggregates (SUM, AVG, COUNT)

### Total Sales per Employee (Without Losing Rows)

```sql
SELECT orderid,
       empid,
       amount,
       SUM(amount) OVER (PARTITION BY empid) AS total_sales
FROM sales.orders;
-- PARTITION BY empid groups orders by employee
-- SUM is calculated per employee
-- Each order row is preserved
```

> This is impossible with GROUP BY alone.

---

### Average Order Value per Employee

```sql
SELECT orderid,
       empid,
       amount,
       AVG(amount) OVER (PARTITION BY empid) AS avg_order_value
FROM sales.orders;
-- Calculates employee-level average
-- Displays it alongside each order
```

## 11.5 Ranking Functions

### ROW_NUMBER()

```sql
SELECT empid,
       orderid,
       amount,
       ROW_NUMBER() OVER (
           PARTITION BY empid
           ORDER BY amount DESC
       ) AS row_num
FROM sales.orders;
-- Assigns unique rank per employee
-- No ties allowed
```

---

### RANK()

```sql
SELECT empid,
       orderid,
       amount,
       RANK() OVER (
           PARTITION BY empid
           ORDER BY amount DESC
       ) AS rank_value
FROM sales.orders;
-- Same values get same rank
-- Gaps appear in ranking
```

---

### DENSE_RANK()

```sql
SELECT empid,
       orderid,
       amount,
       DENSE_RANK() OVER (
           PARTITION BY empid
           ORDER BY amount DESC
       ) AS dense_rank_value
FROM sales.orders;
-- Same values get same rank
-- No gaps in ranking
```

---

### Ranking Comparison

| Function   | Ties | Gaps |
| ---------- | ---- | ---- |
| ROW_NUMBER | No   | No   |
| RANK       | Yes  | Yes  |
| DENSE_RANK | Yes  | No   |

## 11.6 Top-N Analysis (Very Common)

### Top Order per Employee

```sql
SELECT *
FROM (
    SELECT empid,
           orderid,
           amount,
           ROW_NUMBER() OVER (
               PARTITION BY empid
               ORDER BY amount DESC
           ) AS rn
    FROM sales.orders
) t
WHERE rn = 1;
-- Inner query ranks orders per employee
-- Outer query filters top order
```

**Used in:**

- Best deal per sales rep
- Highest transaction per customer
- Peak usage per account

## 11.7 Running Totals

### Running Sales Total per Employee

```sql
SELECT empid,
       order_date,
       amount,
       SUM(amount) OVER (
           PARTITION BY empid
           ORDER BY order_date
       ) AS running_total
FROM sales.orders;
-- Orders sorted by date
-- Cumulative sales calculated row by row
```

## 11.8 Time-Based Analytics

### Monthly Sales per Employee

```sql
SELECT empid,
       DATE_TRUNC('month', order_date) AS month,
       SUM(amount) AS monthly_sales
FROM sales.orders
GROUP BY empid, month;
-- GROUP BY used for time bucketing
-- Window functions come after aggregation
```

## 11.9 Window Functions vs GROUP BY

| Question                       | Correct Tool    |
| ------------------------------ | --------------- |
| Total sales per employee       | GROUP BY        |
| Total sales shown on every row | Window function |
| Top sale per employee          | Window function |
| Ranking employees              | Window function |
| Simple summary                 | GROUP BY        |

## 11.10 Notes

- Window functions do not reduce rows
- OVER() is mandatory
- PARTITION BY is optional but powerful
- Use windows for:
  - Rankings
  - Running totals
  - Percent of total
- Window functions are evaluated after WHERE but before ORDER BY

## 11.11 Realistic Analyst Scenarios

### Identify Top Performing Employee Overall

```sql
SELECT empid, total_sales
FROM (
    SELECT empid,
           SUM(amount) OVER (PARTITION BY empid) AS total_sales
    FROM sales.orders
) t
GROUP BY empid, total_sales
ORDER BY total_sales DESC
LIMIT 1;
-- Combines window function with final aggregation
```

---

### Compare Order Value to Employee Average

```sql
SELECT orderid,
       empid,
       amount,
       AVG(amount) OVER (PARTITION BY empid) AS emp_avg,
       amount - AVG(amount) OVER (PARTITION BY empid) AS diff_from_avg
FROM sales.orders;
-- Shows deviation from employee average
```

---
