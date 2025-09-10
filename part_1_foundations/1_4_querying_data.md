# Topic 4 — Querying Data for Analysis (Core SELECT)

## 4.1 SELECT Statement (Review)

We already saw the basics of `SELECT`.
Now let’s go **deeper** with the clauses analysts use every day.

**General Syntax (in order of execution):**

```sql
SELECT column_list        -- what data to return
FROM table_name           -- from which table
WHERE condition           -- filter rows
ORDER BY column ASC|DESC  -- sort results
LIMIT number;             -- restrict rows (Postgres/MySQL)
```

👉 In SQL Server: use `TOP` instead of `LIMIT`.

---

## 4.2 Aliases (`AS`)

* Aliases rename columns or tables to make results easier to read.
* Analysts often use aliases when writing reports.

**Example:**

```sql
SELECT firstname AS "First Name", salary AS "Employee Salary"
FROM hr.employees;
-- Renames columns in the result for readability
```

**Table alias:**

```sql
SELECT e.firstname, d.deptname
FROM hr.employees e   -- e is alias for employees
JOIN hr.departments d ON e.deptid = d.deptid;
```

📝 **Note:** Aliases don’t change the actual table/column, just the display in the query.

---

## 4.3 Filtering Data with WHERE

* Used to get only rows that meet certain conditions.
* Supports operators:

  * Comparison: `=`, `>`, `<`, `>=`, `<=`, `<>` (not equal)
  * Logical: `AND`, `OR`, `NOT`
  * Range: `BETWEEN ... AND ...`
  * List: `IN (...)`
  * Pattern: `LIKE`, `ILIKE` (case-insensitive in Postgres)

---

### Examples

The `WHERE` clause filters rows that meet specific conditions.

#### Comparison Operators

```sql
-- Equal operator (=): employees in dept 2
SELECT firstname, deptid
FROM hr.employees
WHERE deptid = 2;

-- Not equal (<>): employees not in dept 2
SELECT firstname, deptid
FROM hr.employees
WHERE deptid <> 2;

-- Greater than: salary > 60k
SELECT firstname, salary
FROM hr.employees
WHERE salary > 60000;

-- Less than: salary < 50k
SELECT firstname, salary
FROM hr.employees
WHERE salary < 50000;

-- Greater than or equal: salary ≥ 70k
SELECT firstname, salary
FROM hr.employees
WHERE salary >= 70000;

-- Less than or equal: salary ≤ 55k
SELECT firstname, salary
FROM hr.employees
WHERE salary <= 55000;
```

#### Logical Operators

```sql
-- AND: dept 2 AND salary > 60k
SELECT firstname, deptid, salary
FROM hr.employees
WHERE deptid = 2 AND salary > 60000;

-- OR: dept 2 OR salary > 70k
SELECT firstname, deptid, salary
FROM hr.employees
WHERE deptid = 2 OR salary > 70000;

-- NOT: exclude dept 3
SELECT firstname, deptid
FROM hr.employees
WHERE NOT deptid = 3;
```

#### Range & Lists

```sql
-- IN: employees in IT or Sales
SELECT firstname, deptid
FROM hr.employees
WHERE deptid IN (2, 3);

-- BETWEEN: hired in 2021
SELECT firstname, hire_date
FROM hr.employees
WHERE hire_date BETWEEN '2021-01-01' AND '2021-12-31';
```

#### Pattern Matching

```sql
-- LIKE: names starting with 'A'
SELECT firstname
FROM hr.employees
WHERE firstname LIKE 'A%';

-- LIKE: names containing 'ar'
SELECT firstname
FROM hr.employees
WHERE firstname LIKE '%ar%';

-- LIKE: names ending with 'n'
SELECT firstname
FROM hr.employees
WHERE firstname LIKE '%n';

-- ILIKE (Postgres only): case-insensitive
SELECT firstname
FROM hr.employees
WHERE firstname ILIKE 'a%';  -- matches Alice, alice
```

📝 **Note:**

* `%` matches **any sequence** of characters. `LIKE 'A%'` means “starts with A”. `%` is a wildcard.
* `_` matches exactly **one character** (try `LIKE 'B_b'` → matches "Bob").

---

## 4.4 Sorting Data with ORDER BY

* Sort results in **ascending (ASC)** or **descending (DESC)** order.

```sql
-- Highest salary first
SELECT firstname, salary
FROM hr.employees
ORDER BY salary DESC;

-- Sort by department first, then salary
SELECT firstname, deptid, salary
FROM hr.employees
ORDER BY deptid ASC, salary DESC;
```

---

## 4.5 Limiting Rows

* Sometimes you only want a **sample** of data.

**Postgres / MySQL:**

```sql
-- Postgres / MySQL: LIMIT
SELECT *
FROM hr.employees
LIMIT 3;   -- first 3 rows

-- With ORDER BY + LIMIT: top 2 highest salaries
SELECT firstname, salary
FROM hr.employees
ORDER BY salary DESC
LIMIT 2;
```

**SQL Server:**

```sql
-- SQL Server: TOP keyword
SELECT TOP 3 *
FROM hr.employees;

-- SQL Server: top 2 highest salaries
SELECT TOP 2 firstname, salary
FROM hr.employees
ORDER BY salary DESC;
```

📝 **Note:**

* In Postgres/MySQL: use `LIMIT`.
* In SQL Server: use `TOP`.
* For reproducible results, **always use `ORDER BY`** when limiting.

---

## 4.6 DISTINCT — Remove Duplicates

* Used to get only **unique values**.

```sql
-- List unique departments employees belong to
SELECT DISTINCT deptid
FROM hr.employees;
```

👉 Without DISTINCT, you’d see repeated deptids.

---
