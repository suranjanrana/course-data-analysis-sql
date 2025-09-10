# Topic 2 — Creating & Managing Databases and Schemas

## 2.1 What is a Database?

* A **database** is a collection of related data stored in tables.
* Think of it like a **filing cabinet** where each drawer is a table, and each folder in the drawer is a row.
* Different **Database Management Systems (DBMS)** exist: PostgreSQL, MySQL, SQL Server, Oracle.

---

## 2.2 What is a Schema?

* A **schema** is a logical grouping of database objects (tables, views, functions).
* It helps **organize** data inside a database.
* Example: In a company database:

  * `hr` schema → employee tables
  * `sales` schema → sales-related tables

📝 **Note for Analysts:**

* You don’t always create schemas, but you will often query tables **inside schemas**.
* In PostgreSQL, the default schema is `public`.
* In SQL Server, the default schema is `dbo`.

---

## 2.3 Key Concepts & Definitions

* **Table** — a structured collection of data organized into **rows** and **columns**.
* **Row (record/tuple)** — one data entry in a table.
* **Column (field/attribute)** — a specific piece of data stored for each row.
* **Data type** — defines the type of data a column can store (`INTEGER`, `TEXT`, `DATE`, etc.).
* **Constraint** — rules enforced on columns/tables to maintain data integrity. Common constraints:

  * `PRIMARY KEY` — uniquely identifies a row (cannot be null, must be unique).
  * `FOREIGN KEY` — ensures a value must exist in another table.
  * `NOT NULL` — column cannot contain NULL values.
  * `UNIQUE` — ensures all values in a column are unique.
  * `CHECK` — enforces a condition on column values.
  * `DEFAULT` — assigns a default value if none is provided.
* **Serial / Identity** — special auto-incrementing column types in PostgreSQL.

---

## 2.4 Creating a Database

**PostgreSQL / MySQL Syntax:**

```sql
CREATE DATABASE companydb;   -- create a new database called companydb
```

**SQL Server Syntax:**

```sql
CREATE DATABASE companydb;   -- same command works
GO
```

---

## 2.5 Switching Between Databases

* In **PostgreSQL/MySQL**:

```sql
\c companydb   -- connect to database (psql command for Postgres)
USE companydb; -- in MySQL
```

* In **SQL Server**:

```sql
USE companydb;
```

---

## 2.6 Creating a Schema

**PostgreSQL / SQL Server:**

```sql
CREATE SCHEMA hr;   -- creates a new schema named hr
```

**MySQL:**
Schemas and databases are the same in MySQL.

---

## 2.7 Creating Table

### Syntax

```sql
CREATE TABLE table_name (
    column_name data_type constraints,
    column_name data_type constraints,
    ...
);
```

### Example

```sql
-- Create a table inside the hr schema
CREATE TABLE hr.employees (
    empid INT PRIMARY KEY,             -- unique employee id
    firstname VARCHAR(50) NOT NULL,    -- first name (cannot be null)
    lastname VARCHAR(50) NOT NULL,     -- last name (cannot be null)
    deptid INT,                        -- department id (reference to departments)
    salary DECIMAL(10,2),              -- employee salary
    hire_date DATE                     -- when employee was hired
);
```

👉 Notice how we used `hr.employees` → schema name + table name.

---

## 2.8 Adding Relationships (Foreign Keys)

We usually have multiple related tables. Let’s create a `departments` table and link employees to it.

```sql
CREATE TABLE departments (
    deptid SERIAL PRIMARY KEY,        -- auto-incrementing department ID
    deptname VARCHAR(100) NOT NULL UNIQUE
);

ALTER TABLE employees
ADD COLUMN deptid INT,
ADD CONSTRAINT fk_dept FOREIGN KEY (deptid)
    REFERENCES departments(deptid);
```

**Explanation:**

* `deptid SERIAL PRIMARY KEY` — each department has a unique auto-generated id.
* `deptname` — department names must be unique.
* In `employees`, we add `deptid INT` as a column.
* `FOREIGN KEY (deptid) REFERENCES departments(deptid)` — ensures employees belong to a valid department.

---

## 2.9 ALTER TABLE — Modifying Tables

PostgreSQL allows altering existing tables.

### Example: Add, Modify, Drop columns

```sql
-- Add new column
ALTER TABLE employees ADD COLUMN phone VARCHAR(15);

-- Rename column
ALTER TABLE employees RENAME COLUMN phone TO contact_number;

-- Change data type
ALTER TABLE employees ALTER COLUMN salary TYPE NUMERIC(12,2);

-- Drop column
ALTER TABLE employees DROP COLUMN contact_number;
```

### Example: Rename table

```sql
ALTER TABLE employees RENAME TO staff;
```

---

## 2.10 Dropping (Deleting) Databases, Schemas, and Tables

* **Drop Database:**

```sql
DROP DATABASE companydb;   -- permanently deletes the database
```

* **Drop Schema (PostgreSQL / SQL Server):**

```sql
DROP SCHEMA hr CASCADE;   -- removes schema and its objects
```

* **DROP TABLE — Deleting a Table:**

```sql
DROP TABLE IF EXISTS employees CASCADE;
```

**Explanation:**

* `IF EXISTS` — prevents error if table doesn’t exist.
* `CASCADE` — automatically drops dependent objects (like foreign keys in other tables).

⚠️ **Important Note for Analysts:**
You will **rarely** drop databases or schemas — that’s usually an admin’s job. But you should know what the commands do.

---

## 2.11 PostgreSQL Data Types (Commonly Used)

| Category     | Examples                                                  | Notes                                      |
| ------------ | --------------------------------------------------------- | ------------------------------------------ |
| Numeric      | `SMALLINT`, `INTEGER`, `BIGINT`, `NUMERIC(p,s)`, `SERIAL` | Use `NUMERIC` for precision (e.g., money). |
| Text         | `CHAR(n)`, `VARCHAR(n)`, `TEXT`                           | `TEXT` has unlimited length.               |
| Date/Time    | `DATE`, `TIME`, `TIMESTAMP`, `INTERVAL`                   | `CURRENT_DATE`, `NOW()` useful defaults.   |
| Boolean      | `BOOLEAN` (`TRUE`, `FALSE`, `NULL`)                       |                                            |
| UUID         | `UUID`                                                    | For unique IDs across systems.             |
| JSON / JSONB | `JSON`, `JSONB`                                           | For semi-structured data.                  |
| Others       | `BYTEA` (binary), `ARRAY`, `ENUM`                         | Useful for special cases.                  |

---

## 📝 Notes

1. Always start with `CREATE DATABASE` and `USE` it before creating tables.
2. Use **Primary Keys** to uniquely identify rows.
3. `VARCHAR(n)` → `n` defines the maximum characters allowed.
4. `DECIMAL(m,n)` → `m` = total digits, `n` = digits after decimal.
5. `DROP` is permanent ❌ (be careful).
6. Different SQL systems (MySQL, PostgreSQL, SQL Server, Oracle) have slightly different syntax.

---
