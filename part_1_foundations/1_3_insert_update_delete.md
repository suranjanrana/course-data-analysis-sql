# Topic 3 — Inserting, Updating, and Deleting Data

## 3.1 INSERT Statement

* Used to add **new rows** into a table.
* You can insert **all columns** or **specific columns**.

**Syntax (General):**

```sql
INSERT INTO table_name (column1, column2, ...)
VALUES (value1, value2, ...);
```

---

### Example 1 — Insert into all columns

```sql
INSERT INTO hr.employees (empid, firstname, lastname, deptid, salary, hire_date)
VALUES (4, 'David', 'Lee', 2, 68000, '2023-05-01');
-- Adds a new employee David Lee into the employees table
```

---

### Example 2 — Insert into specific columns

```sql
INSERT INTO hr.departments (deptid, deptname)
VALUES (4, 'Finance');
-- Only inserts deptid and deptname (other columns not required)
```

---

### Example 3 — Insert multiple rows at once

```sql
INSERT INTO sales.orders (orderid, empid, amount, order_date)
VALUES
(104, 2, 900.00, '2023-04-05'),
(105, 1, 1500.00, '2023-04-10');
-- Two new orders are added at the same time
```

📝 **Note** Inserting multiple rows in one query is faster than inserting one by one.

## 3.2 UPDATE Statement

* Used to **modify existing data** in a table.
* Always use a **WHERE clause** to avoid updating all rows accidentally.

**Syntax:**

```sql
UPDATE table_name
SET column1 = value1, column2 = value2
WHERE condition;
```

---

### Example 1 — Update salary for one employee

```sql
UPDATE hr.employees
SET salary = 80000
WHERE empid = 2;
-- Updates Bob Nguyen's salary to 80,000
```

---

### Example 2 — Update multiple columns

```sql
UPDATE hr.employees
SET salary = 55000, deptid = 1
WHERE empid = 3;
-- Updates Clara: moves her to HR and increases salary
```

---

### Example 3 — Update multiple rows

```sql
UPDATE hr.employees
SET salary = salary * 1.05
WHERE deptid = 2;
-- Increases salary of all IT department employees by 5%
```

📝 **Note**
Updating data permanently changes it. Always double-check your `WHERE` condition.

## 3.3 DELETE Statement

* Used to **remove rows** from a table.
* Like UPDATE, always use a **WHERE clause** to avoid deleting everything.

**Syntax:**

```sql
DELETE FROM table_name
WHERE condition;
```

---

### Example 1 — Delete one row

```sql
DELETE FROM sales.orders
WHERE orderid = 101;
-- Deletes the order with ID 101
```

---

### Example 2 — Delete multiple rows

```sql
DELETE FROM sales.orders
WHERE amount < 700;
-- Deletes all orders with amount less than 700
```

---

### Example 3 — Delete all rows from a table

```sql
DELETE FROM sales.orders;
-- Removes ALL orders (but keeps the table structure)
```

📝 **Note**

* `DELETE` removes rows but keeps the table.
* `DROP TABLE` removes the entire table structure — avoid this unless necessary.

## 3.4 Transactions (Optional but Useful for Analysts)

* A **transaction** groups multiple SQL statements so they succeed or fail together.
* Commands:

  * `BEGIN` → Start a transaction.
  * `COMMIT` → Save changes.
  * `ROLLBACK` → Undo changes.

**Example:**

```sql
BEGIN;

UPDATE hr.employees
SET salary = 90000
WHERE empid = 2;

DELETE FROM sales.orders
WHERE orderid = 105;

ROLLBACK; -- undoes both update and delete if you change your mind
-- Use COMMIT instead if you want to save
```

📝 **Note** Transactions are very handy when testing queries on real databases.

---
