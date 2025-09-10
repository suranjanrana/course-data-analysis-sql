# Topic 5 — Functions in SQL (String, Numeric, Date, Aggregate)

## 5.1 What are Functions in SQL?

* Functions are **predefined operations** that let you manipulate values.
* Think of them as **tools**: instead of writing logic from scratch, you call a function.
* Common categories:

  * **String functions** → clean or format text (e.g., `UPPER`, `TRIM`)
  * **Numeric functions** → math operations (e.g., `ROUND`, `ABS`)
  * **Date/Time functions** → work with dates (e.g., `NOW`, `AGE`)
  * **Aggregate functions** → summarize data (e.g., `SUM`, `AVG`)

👉 Most functions are similar across PostgreSQL, MySQL, and SQL Server, but names differ slightly. I’ll note differences when needed.

---

## 5.2 String Functions

| Function                               | Description              | Example                                       |
| -------------------------------------- | ------------------------ | --------------------------------------------- |
| `UPPER(str)`                           | Convert to uppercase     | `UPPER('hello') → 'HELLO'`                    |
| `LOWER(str)`                           | Convert to lowercase     | `LOWER('HELLO') → 'hello'`                    |
| `LENGTH(str)`                          | Get number of characters | `LENGTH('SQL') → 3`                           |
| `TRIM(str)`                            | Remove spaces            | `TRIM('  hi  ') → 'hi'`                       |
| `SUBSTRING(str FROM start FOR length)` | Extract part of a string | `SUBSTRING('Analysis' FROM 1 FOR 4) → 'Anal'` |
| `CONCAT(a, b)`                         | Join strings             | `CONCAT('Data', 'Science') → 'DataScience'`   |

**Example:**

```sql
-- Convert first names to uppercase
SELECT firstname, UPPER(firstname) AS upper_name
FROM hr.employees;

-- Convert last names to lowercase
SELECT lastname, LOWER(lastname) AS lower_name
FROM hr.employees;

-- Find length of each first name
SELECT firstname, LENGTH(firstname) AS name_length
FROM hr.employees;

-- Remove extra spaces (useful when data is messy)
SELECT TRIM('   Analyst   ') AS cleaned_text;

-- Extract first 3 letters of employee first name
SELECT firstname, SUBSTRING(firstname FROM 1 FOR 3) AS short_name
FROM hr.employees;

-- Combine first and last names into full name
SELECT CONCAT(firstname, ' ', lastname) AS full_name
FROM hr.employees;
```

👉 **Note:** Always check for extra spaces in text data (use `TRIM` or `LTRIM`/`RTRIM` in some databases).

---

## 5.3 Numeric Functions

| Function                     | Description            | Example                      |
| ---------------------------- | ---------------------- | ---------------------------- |
| `ROUND(num, decimals)`       | Round number           | `ROUND(123.456, 2) → 123.46` |
| `CEIL(num)` / `CEILING(num)` | Smallest integer ≥ num | `CEIL(4.2) → 5`              |
| `FLOOR(num)`                 | Largest integer ≤ num  | `FLOOR(4.9) → 4`             |
| `ABS(num)`                   | Absolute value         | `ABS(-10) → 10`              |
| `POWER(a, b)`                | Raise to power         | `POWER(2, 3) → 8`            |

**Example:**

```sql
-- Round salary to 2 decimal places
SELECT firstname, ROUND(salary, 2) AS rounded_salary
FROM hr.employees;

-- Round salary to nearest 100
SELECT firstname, ROUND(salary, -2) AS rounded_to_100
FROM hr.employees;

-- Ceiling: always round up
SELECT CEIL(4500.25) AS ceil_example;   -- → 4501

-- Floor: always round down
SELECT FLOOR(4500.99) AS floor_example; -- → 4500

-- Absolute value: convert negatives to positive
SELECT ABS(-250) AS abs_example;        -- → 250

-- Power: raise salary to the power of 2 (not realistic, but demo)
SELECT firstname, POWER(salary, 2) AS squared_salary
FROM hr.employees;
```

👉 **Note for Analysts:** `ROUND` is very common when preparing reports, especially with currency.

---

## 5.4 Date & Time Functions

| Function                       | Description                     | Example                                     |
| ------------------------------ | ------------------------------- | ------------------------------------------- |
| `NOW()`                        | Current timestamp               | `2025-09-07 22:15:00`                       |
| `CURRENT_DATE`                 | Current date                    | `2025-09-07`                                |
| `AGE(date1, date2)` (Postgres) | Difference between dates        | `AGE('2025-01-01', '2020-01-01') → 5 years` |
| `EXTRACT(field FROM date)`     | Extract part (year, month, day) | `EXTRACT(YEAR FROM '2025-09-07') → 2025`    |

**Example:**

```sql
-- Current timestamp (date + time)
SELECT NOW() AS current_timestamp;

-- Current date only
SELECT CURRENT_DATE AS today_date;

-- Difference between two dates (Postgres AGE function)
SELECT AGE('2025-01-01', '2020-01-01') AS diff_example;
-- → 5 years 0 mons 0 days

-- Calculate years each employee has been at company
SELECT firstname, AGE(CURRENT_DATE, hire_date) AS tenure
FROM hr.employees;

-- Extract only year from hire date
SELECT firstname, EXTRACT(YEAR FROM hire_date) AS hire_year
FROM hr.employees;

-- Extract month from order date
SELECT orderid, EXTRACT(MONTH FROM order_date) AS order_month
FROM sales.orders;

-- Add 1 month to each order date
SELECT orderid, order_date, order_date + INTERVAL '1 month' AS next_month
FROM sales.orders;

-- Subtract 7 days from each order date
SELECT orderid, order_date, order_date - INTERVAL '7 days' AS week_before
FROM sales.orders;
```

👉 **Note for Analysts:** Always check which date functions your database supports.

* Postgres: `AGE`, `EXTRACT`, `INTERVAL`
* MySQL: `DATEDIFF`, `DATE_ADD`, `YEAR()`
* SQL Server: `DATEDIFF`, `DATEADD`, `YEAR()`

---

## 5.5 Aggregate Functions

Aggregate functions are **the bread and butter of data analysis**.
They summarize multiple rows into one result.

| Function   | Description    | Example             |
| ---------- | -------------- | ------------------- |
| `COUNT(*)` | Number of rows | Count all employees |
| `SUM(col)` | Total sum      | Total sales amount  |
| `AVG(col)` | Average        | Average salary      |
| `MIN(col)` | Minimum value  | Lowest order amount |
| `MAX(col)` | Maximum value  | Highest salary      |

**Example:**

```sql
-- Count how many employees are in the table
SELECT COUNT(*) AS total_employees
FROM hr.employees;

-- Sum of all order amounts
SELECT SUM(amount) AS total_sales
FROM sales.orders;

-- Average employee salary
SELECT AVG(salary) AS average_salary
FROM hr.employees;

-- Minimum and maximum salary
SELECT MIN(salary) AS min_salary, MAX(salary) AS max_salary
FROM hr.employees;

-- Average salary per department (grouping preview)
SELECT deptid, AVG(salary) AS avg_salary
FROM hr.employees
GROUP BY deptid;
```

**Note:**

* 👉 `GROUP BY` is needed when you want aggregates **per group**, not the whole table.
* 👉 `COUNT`, `SUM`, `AVG`, `MIN`, `MAX` are the **most common starting point** when preparing dashboards or reports.

---

## 📝 Notes

* **String cleaning**: Always check for case (`UPPER`/`LOWER`) and spaces (`TRIM`).
* **Numeric rounding**: Round carefully in financial reports; sometimes exact values are required.
* **Date operations**: These are essential for calculating tenures, durations, and trends.
* **Aggregates**: By themselves, they summarize entire tables; with `GROUP BY`, they summarize by groups.

---
