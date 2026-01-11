# Topic 7 — JOINS I (INNER, LEFT, RIGHT, FULL)

## 7.1 What is a JOIN?

* A **JOIN** is used to combine rows from two or more tables based on a related column (usually a **primary key** in one table and a **foreign key** in another).
* Without joins, you can only query one table at a time — but real-world data is **spread across multiple tables**.

---

## 7.2 Types of Joins

| Join Type        | Description                                                                                     | Example Use Case                                           |
| ---------------- | ----------------------------------------------------------------------------------------------- | ---------------------------------------------------------- |
| **INNER JOIN**   | Returns rows where there’s a match in both tables                                               | Employees who belong to a department                       |
| **LEFT JOIN**    | Returns all rows from the left table, and matching rows from the right table (null if no match) | All employees, even if they don’t belong to a department   |
| **RIGHT JOIN**   | Returns all rows from the right table, and matching rows from the left table (null if no match) | All departments, even if no employees are assigned         |
| **FULL JOIN**    | Returns rows when there is a match in either table                                              | Union of left and right join results (who’s missing where) |
| **NATURAL JOIN** | Automatically joins on columns with the same name                                               | Simplified syntax (but less explicit)                      |
| **USING clause** | Shorthand when join column names are the same                                                   | Cleaner queries                                            |
| **SELF JOIN**    | Table joined to itself                                                                          | Hierarchies, comparisons                                   |
| **CROSS JOIN**   | All combinations                                                                                | Forecasting, combinations                                  |

👉 Not all databases support `FULL JOIN` directly (e.g., MySQL doesn’t).

---

## 7.3 Syntax

```sql
-- Explicit ON clause
SELECT t1.col1, t2.col2
FROM table1 t1
JOIN table2 t2
ON t1.key = t2.key;

-- USING clause (if both tables share 'key' column name)
SELECT t1.col1, t2.col2
FROM table1 t1
JOIN table2 t2
USING (key);

-- NATURAL JOIN (joins automatically on all columns with the same name)
SELECT t1.col1, t2.col2
FROM table1
NATURAL JOIN table2;
```

👉 Best practice: prefer **explicit ON or USING** for clarity. NATURAL JOIN can create surprises if multiple columns match.

---

## Practice Tables

We’ll add more data in department and employees table:

```sql
INSERT INTO hr.departments (deptid, deptname, location) VALUES
(4, 'Finance', 'Boston');


INSERT INTO hr.employees (empid, firstname, deptid, location, salary) VALUES
(104, 'Diana', 3, 'San Francisco', 80000),
(105, 'Eve', NULL, 'Remote', 55000); -- employee without department
```

---

## INNER JOIN (Only matching rows)

```sql
SELECT e.firstname, d.deptname
FROM hr.employees e
INNER JOIN hr.departments d
ON e.deptid = d.deptid;
-- Matches employees with their department
-- Eve will not appear because deptid is NULL
```

\-- Returns employees who are assigned to a department

---

## LEFT JOIN (All from left, matching from right)

```sql
SELECT e.firstname, d.deptname
FROM hr.employees e
LEFT JOIN hr.departments d
ON e.deptid = d.deptid;
-- Shows all employees, including Eve (deptname = NULL)
```

\-- Shows all employees, even if they have no department (deptname = NULL for Eve)

---

## RIGHT JOIN (All from right, matching from left)

```sql
SELECT e.firstname, d.deptname
FROM hr.employees e
RIGHT JOIN hr.departments d
ON e.deptid = d.deptid;
-- Shows all departments, even Finance (which has no employees)
```

\-- Shows all departments, even if no employees are assigned (Finance will appear with NULL employee)

---

## FULL JOIN (All rows from both sides)

```sql
SELECT e.firstname, d.deptname
FROM hr.employees e
FULL JOIN hr.departments d
ON e.deptid = d.deptid;
-- Includes all employees and all departments
-- NULLs where no match exists
```

\-- Shows all employees and all departments, filling NULLs where no match exists

---

### NATURAL JOIN (automatic on matching column names)

```sql
SELECT firstname, deptname, location
FROM hr.employees
NATURAL JOIN hr.departments;
-- Joins on deptid AND location automatically
-- Be careful: both deptid and location exist in both tables
```

---

### USING clause (shorthand for equal column names)

```sql
SELECT firstname, deptname
FROM hr.employees
JOIN hr.departments USING (deptid);
-- Cleaner syntax than ON e.deptid = d.deptid
```

---

### Multi-column Join (deptid + location)

```sql
SELECT e.firstname, d.deptname, e.location
FROM hr.employees e
JOIN hr.departments d
ON e.deptid = d.deptid AND e.location = d.location;
-- Ensures match only if both deptid and location align
```

---

## JOIN with Aggregation

```sql
-- Count employees per department
SELECT d.deptname, COUNT(e.empid) AS employee_count
FROM hr.departments d
LEFT JOIN hr.employees e
ON d.deptid = e.deptid
GROUP BY d.deptname;
-- Departments without employees still appear with count = 0
```

---

## JOIN Across More Than Two Tables

If we had an `orders` table with `empid` as salesperson:

```sql
SELECT e.firstname, d.deptname, COUNT(o.order_id) AS orders_handled
FROM hr.employees e
JOIN hr.departments d ON e.deptid = d.deptid
JOIN sales.orders o ON e.empid = o.empid
GROUP BY e.firstname, d.deptname;
```

\-- Combines employees, departments, and orders

---

## 📝 Notes

* **INNER JOIN** = intersection.
* **LEFT JOIN** = preserve all from left table.
* **RIGHT JOIN** = preserve all from right table.
* **FULL JOIN** = all rows from both tables (with NULLs).
* **USING()** is safe when column names are identical.
* **NATURAL JOIN** is risky: it auto-matches all same-named columns. Use carefully.
* When joining on multiple keys, always use explicit `ON col1 = col1 AND col2 = col2`.
* Always use **table aliases** (`e`, `d`) to keep queries readable.
* When aggregating with joins, use **LEFT JOIN** if you want to keep categories with zero counts.
* Watch out for **duplicate rows** when joining — if there are multiple matches, results multiply.

## Other examples

### Scenario 1 — Find employees without departments

```sql
SELECT e.firstname
FROM hr.employees e
LEFT JOIN hr.departments d
ON e.deptid = d.deptid
WHERE d.deptid IS NULL;
-- Useful for data quality checks
```

---

### Scenario 2 — Find departments without employees

```sql
SELECT d.deptname
FROM hr.departments d
LEFT JOIN hr.employees e
ON d.deptid = e.deptid
WHERE e.empid IS NULL;
-- Helps detect unused business units
```

---

### Scenario 3 — Average salary per department with department names

```sql
SELECT d.deptname, AVG(e.salary) AS avg_salary
FROM hr.departments d
LEFT JOIN hr.employees e
ON d.deptid = e.deptid
GROUP BY d.deptname;
-- HR metric: comparing average pay across departments
```

---

### Scenario 4 — Employees working in same location as their department

```sql
SELECT e.firstname, d.deptname, e.location
FROM hr.employees e
JOIN hr.departments d
ON e.deptid = d.deptid AND e.location = d.location;
-- Identifies employees colocated with their team
```

---

### Scenario 5 — Match employees with orders handled (if we join orders)

```sql
SELECT e.firstname, COUNT(o.order_id) AS orders_handled
FROM hr.employees e
LEFT JOIN sales.orders o
ON e.empid = o.empid
GROUP BY e.firstname;
-- Measures employee contribution to sales
```

---
