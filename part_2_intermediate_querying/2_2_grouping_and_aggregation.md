# Topic 6 — Grouping & Aggregation

## 6.1 What is Aggregation?

* **Aggregation** = combining multiple rows of data into summarized values (totals, averages, counts, etc.).
* Instead of analyzing row by row, you **summarize by groups**.

## 6.2 Aggregate Functions (built-in in SQL)

| Function  | Description               | Example Use                        |
| --------- | ------------------------- | ---------------------------------- |
| `COUNT()` | Number of rows            | Count employees in each department |
| `SUM()`   | Total of a numeric column | Total sales by product             |
| `AVG()`   | Average value             | Average salary per department      |
| `MIN()`   | Smallest value            | Lowest order amount                |
| `MAX()`   | Largest value             | Highest salary in company          |

## 6.3 Syntax for GROUP BY

```sql
SELECT column1, AGGREGATE_FUNCTION(column2)
FROM table
WHERE condition
GROUP BY column1
ORDER BY column1;
```

## 6.4 Examples (Postgres, MySQL, SQL Server)

### Example 1: Count employees per department

```sql
SELECT deptid, COUNT(*) AS employee_count
FROM hr.employees
GROUP BY deptid
ORDER BY deptid;
-- Groups all employees by department ID and counts them
```

---

### Example 2: Average salary per department

```sql
SELECT deptid, AVG(salary) AS avg_salary
FROM hr.employees
GROUP BY deptid
ORDER BY avg_salary DESC;
-- Finds the average salary per department and sorts by highest
```

---

### Example 3: Total sales by product

```sql
SELECT product_id, SUM(quantity) AS total_quantity
FROM sales.orders
GROUP BY product_id
ORDER BY total_quantity DESC;
-- Summarizes order table by product to see total sales
```

---

### Example 4: Minimum & Maximum salary

```sql
SELECT deptid,
       MIN(salary) AS min_salary,
       MAX(salary) AS max_salary
FROM hr.employees
GROUP BY deptid;
-- Finds salary range within each department
```

## 6.5 Filtering with HAVING

* `WHERE` filters **before grouping** (on rows).
* `HAVING` filters **after grouping** (on groups).

### Example 1 — Departments with at least 2 employees

```sql
SELECT deptid, COUNT(*) AS employee_count
FROM hr.employees
GROUP BY deptid
HAVING COUNT(*) >= 2;
-- Only returns departments that have 2 or more employees
```

---

### Example 2 — Products sold more than 100 units

```sql
SELECT product_id, SUM(quantity) AS total_sold
FROM sales.orders
GROUP BY product_id
HAVING SUM(quantity) > 100;
-- Shows products that reached significant sales volume
```

---

### Example 3 — Departments with average salary above 70,000

```sql
SELECT deptid, AVG(salary) AS avg_salary
FROM hr.employees
GROUP BY deptid
HAVING AVG(salary) > 70000;
-- Filters out lower-paying departments
```

---

### Example 4 — Only show departments where max salary > 90,000

```sql
SELECT deptid, MAX(salary) AS highest_salary
FROM hr.employees
GROUP BY deptid
HAVING MAX(salary) > 90000;
-- Useful to find departments with highly paid employees
```

---

### Example 5 — Customers who placed more than 5 orders

```sql
SELECT customer_id, COUNT(order_id) AS order_count
FROM sales.orders
GROUP BY customer_id
HAVING COUNT(order_id) > 5;
-- Finds loyal/repeat customers
```

## 6.6 Aggregations on Dates

Dates are often grouped by **year, month, or day** in analysis.

### Example 1 — Number of employees hired each year

(Postgres syntax, similar in MySQL/SQL Server)

```sql
SELECT EXTRACT(YEAR FROM hire_date) AS hire_year,
       COUNT(*) AS hires
FROM hr.employees
GROUP BY EXTRACT(YEAR FROM hire_date)
ORDER BY hire_year;
-- Groups employees by hire year
```

---

### Example 2 — Orders per month

```sql
SELECT DATE_TRUNC('month', order_date) AS month,
       COUNT(*) AS total_orders
FROM sales.orders
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY month;
-- Groups orders into months (Postgres).
```

👉 MySQL: `DATE_FORMAT(order_date, '%Y-%m')`
👉 SQL Server: `FORMAT(order_date, 'yyyy-MM')`

---

### Example 3 — Total sales revenue per year

```sql
SELECT EXTRACT(YEAR FROM order_date) AS year,
       SUM(quantity * price) AS total_revenue
FROM sales.orders
GROUP BY EXTRACT(YEAR FROM order_date)
ORDER BY year;
-- Aggregates yearly revenue
```

---

### Example 4 — Customers with monthly orders above 10

```sql
SELECT customer_id,
       DATE_TRUNC('month', order_date) AS order_month,
       COUNT(order_id) AS monthly_orders
FROM sales.orders
GROUP BY customer_id, DATE_TRUNC('month', order_date)
HAVING COUNT(order_id) > 10
ORDER BY monthly_orders DESC;
-- Combines `HAVING` with date aggregation
```

---

### Example 5 — Average salary of employees hired each year

```sql
SELECT EXTRACT(YEAR FROM hire_date) AS hire_year,
       AVG(salary) AS avg_salary
FROM hr.employees
GROUP BY EXTRACT(YEAR FROM hire_date)
HAVING AVG(salary) > 60000
ORDER BY hire_year;
-- Useful for analyzing hiring trends & pay evolution
```

## 6.7 Mixing GROUP BY with Other Clauses

```sql
-- Departments with avg salary above 65,000
SELECT deptid, AVG(salary) AS avg_salary
FROM hr.employees
WHERE salary IS NOT NULL       -- filter rows before grouping
GROUP BY deptid
HAVING AVG(salary) > 65000     -- filter groups
ORDER BY avg_salary DESC;      -- sort results
```

---

## 📝 Notes

* Always include **non-aggregated columns** in `GROUP BY`.
* Use `HAVING` instead of `WHERE` whenever your filter condition involves an **aggregate function** (`COUNT`, `SUM`, `AVG`, etc.).
* `COUNT(*)` counts all rows, while `COUNT(column)` ignores `NULL`.
* Aggregations are **database independent** (same in Postgres, MySQL, SQL Server).
* When combining `GROUP BY` with `ORDER BY`, think: group → aggregate → filter → sort.
* `EXTRACT()` or `DATE_TRUNC()` (Postgres) help break down dates for grouping.
* Different databases have slightly different date functions:

  * **Postgres:** `DATE_TRUNC`, `EXTRACT`
  * **MySQL:** `DATE_FORMAT`, `YEAR()`, `MONTH()`
  * **SQL Server:** `FORMAT`, `YEAR()`, `MONTH()`
* Always think about **granularity** (year vs. month vs. day) when grouping dates.

---
