# Topic 1 - Introduction to SQL

## 1.1 What is SQL?

**SQL (Structured Query Language)** is a standard programming language used to interact with relational databases.

* Relational databases store data in **tables** (rows & columns), and SQL helps us to:

  * **Retrieve data** (SELECT)
  * **Insert new data** (INSERT)
  * **Update existing data** (UPDATE)
  * **Delete data** (DELETE)
  * **Create and manage tables/databases** (CREATE, ALTER, DROP)
* i.e., It allows you to create, read, update, and delete (CRUD) data stored in a database.
* SQL is used by almost all database systems: MySQL, PostgreSQL, SQL Server, Oracle, SQLite, etc.

**Key Points to Remember:**

* SQL is **declarative**, meaning you tell the database *what* you want, not *how* to do it.
* SQL commands are **not case-sensitive** (but keywords are often written in UPPERCASE for readability).

## 1.2 Types of SQL Commands

SQL is broadly divided into categories:

| Category                               | Commands                     | Purpose                                  |
| -------------------------------------- | ---------------------------- | ---------------------------------------- |
| **DDL** (Data Definition Language)     | `CREATE`, `ALTER`, `DROP`    | Define or change database structure      |
| **DML** (Data Manipulation Language)   | `INSERT`, `UPDATE`, `DELETE` | Modify table data                        |
| **DQL** (Data Query Language)          | `SELECT`                     | Retrieve data (most used by analysts)    |
| **DCL** (Data Control Language)        | `GRANT`, `REVOKE`            | Permissions (not focus for analysts)     |
| **TCL** (Transaction Control Language) | `COMMIT`, `ROLLBACK`         | Save/undo changes (useful in some cases) |

> 🔑 **Note for students**: As analysts, you’ll spend **80–90% of your time writing SELECT queries** and a bit of `INSERT`, `UPDATE`, and `DELETE`.

## 1.3 Database, Table, and Schema

* **Database** → A collection of related data stored systematically.
  Example: `LibraryDB` stores all data about books, authors, members, etc.

* **Table** → A structure inside a database that stores data in **rows and columns**.
  Example: `Books` table with columns `BookID`, `Title`, `Author`, `Price`.

* **Schema** → A logical container for tables, views, procedures, etc. (like a folder inside a database).

## 1.4 Basic SQL Syntax Rules

* SQL is **case-insensitive** (but it’s good practice to write keywords in UPPERCASE).
* Each SQL statement ends with a **semicolon (`;`)**.
* Single quotes `' '` are used for string values.
* Comments:

  * `-- single line comment`
  * `/* multi-line comment */`

## 1.5 SELECT — The Most Important Command

The **SELECT** statement retrieves data from one or more tables.

**General Syntax:**

```sql
SELECT column1, column2, ...
FROM table_name
WHERE condition
ORDER BY column ASC|DESC
LIMIT number;
```

## 1.6 Examples (Cross-Database Compatible)

Let’s say we have a simple `employees` table:

| empid | firstname | lastname | dept  | salary |
| ----- | --------- | -------- | ----- | ------ |
| 1     | Alice     | Taylor   | HR    | 60000  |
| 2     | Bob       | Nguyen   | IT    | 75000  |
| 3     | Clara     | Khan     | Sales | 50000  |

---

### Example 1 — Select all columns

```sql
SELECT * 
FROM employees;
```

✅ Retrieves all rows and all columns.

---

### Example 2 — Select specific columns

```sql
SELECT firstname, lastname, salary
FROM employees;
```

✅ Shows only names and salary.

---

### Example 3 — Filtering with WHERE

```sql
SELECT firstname, salary
FROM employees
WHERE salary > 60000;
```

✅ Retrieves employees earning more than 60,000.

---

### Example 4 — Sorting results

```sql
SELECT firstname, lastname, salary
FROM employees
ORDER BY salary DESC;
```

✅ Shows employees sorted by salary (highest first).

---

### Example 5 — Limit results

```sql
-- PostgreSQL / MySQL
SELECT firstname, salary
FROM employees
LIMIT 2;

-- SQL Server
SELECT TOP 2 firstname, salary
FROM employees;
```

✅ Shows only first 2 rows.

## 📝 Notes

* Always use `SELECT column_names` instead of `SELECT *` in real-world analysis (more efficient, clearer).
* Use `WHERE` carefully — it’s the most common way to filter data.
* Sorting (`ORDER BY`) can slow queries on big tables — use only when needed.
* Remember SQL **may behave slightly differently** across databases:

  * PostgreSQL & MySQL use `LIMIT`.
  * SQL Server uses `TOP`.

---
