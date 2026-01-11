# Topic 8 — JOINS II (Self Join & Cross Join)

## 8.1 Self Join

* A **SELF JOIN** is when a table is joined to itself.
* Useful for comparing rows within the same table (e.g., employee–manager, hierarchy, same city comparisons).

**Syntax:**

```sql
SELECT a.col, b.col
FROM table a
JOIN table b
ON a.key = b.key;
```

👉 Both `a` and `b` are aliases for the same table.

## 8.2 Cross Join

* A **CROSS JOIN** returns the **Cartesian product** of two tables: every row from one combined with every row from the other.
* Useful for:

  * Generating combinations (e.g., all products × all regions).
  * Creating test data.
  * Running "what-if" analysis.

## Syntax

```sql
SELECT *
FROM table1
CROSS JOIN table2;
```

👉 No `ON` condition is needed (but you can add a `WHERE` later to filter).

## 8.3 Practice table

Let’s add a `managerid` column to `employees` for this example:

```sql
ALTER TABLE hr.employees ADD COLUMN managerid INT;

UPDATE hr.employees SET managerid = NULL WHERE empid = 1; -- Alice = CEO
UPDATE hr.employees SET managerid = 1 WHERE empid IN (2, 3); -- Bob, Clara report to Alice
UPDATE hr.employees SET managerid = 2 WHERE empid = 4; -- Diana reports to Bob
UPDATE hr.employees SET managerid = 3 WHERE empid = 5; -- Eve reports to Clara

```

## 8.4 Example (Self Join)

### Self Join (Employee–Manager relationship)

```sql
-- List employees with their managers
SELECT e.firstname AS employee,
       m.firstname AS manager
FROM hr.employees e
LEFT JOIN hr.employees m
ON e.managerid = m.empid;
-- Self join: employees joined with the same table
-- Employees with no manager show manager = NULL
```

## 8.5 Example (Cross Join)

### Cross Join (all combinations of departments and locations)

```sql
SELECT d.deptname, l.city
FROM hr.departments d
CROSS JOIN (VALUES ('New York'), ('Chicago'), ('San Francisco')) AS l(city);
-- Produces every department with every city (Cartesian product)
```

---

### Cross join employees with departments

```sql
-- not meaningful without filter
SELECT e.firstname, d.deptname
FROM hr.employees e
CROSS JOIN hr.departments d;
-- Every employee paired with every department (over 20 combinations here)
```

👉 Usually filtered:

```sql
-- Employees × departments, but keep only matching location
SELECT e.firstname, d.deptname, e.location
FROM hr.employees e
CROSS JOIN hr.departments d
WHERE e.location = d.location;
```

## 8.6 Other examples

### Scenario 1 — Find employees reporting to the same manager

```sql
SELECT e1.firstname AS emp1, e2.firstname AS emp2, m.firstname AS manager
FROM hr.employees e1
JOIN hr.employees e2
  ON e1.managerid = e2.managerid AND e1.empid < e2.empid
JOIN hr.employees m
  ON e1.managerid = m.empid;
-- Self join: pairs employees with the same manager
```

---

### Scenario 2 — Generate all possible department–year combinations

```sql
-- Useful for forecasting/reporting when some years have no data
SELECT d.deptname, y.year
FROM hr.departments d
CROSS JOIN (VALUES (2021), (2022), (2023)) AS y(year);
```

## 8.7 Notes

* **SELF JOIN** is just a regular join, but the table is referenced twice.
* Always use **aliases** (`e` and `m`) in self joins to avoid confusion.
* **CROSS JOIN** = Cartesian product = all combinations.
* Without a filter, CROSS JOINs can explode row counts quickly ⚠️.

---
