# Exercises & Quizzes

## Practice Tables

We’ll expand our **companydb** database with a new schema: `sales`.  
*Please find the query in the folder **practice_tables**.*

---

## Exercise

1. Create a schema named **finance**.
2. Inside `finance`, create a table `expenses` with:

   * `expenseid` (Primary Key)
   * `description`
   * `amount`
   * `expense_date`
3. Insert 3 rows into `finance.expenses`.
4. Retrieve all rows from `finance.expenses`.
5. What’s the difference between `hr.employees` and `employees`?

---

## Quiz

### Multiple Choice

1. In PostgreSQL, what is the default schema if none is specified?

   * a) system
   * b) main
   * c) public
   * d) default

2. In MySQL, a **schema** is the same as a:

   * a) database
   * b) table
   * c) column
   * d) schema (they’re different)

3. Which command deletes an entire schema in PostgreSQL?

   * a) REMOVE SCHEMA hr;
   * b) DROP SCHEMA hr CASCADE;
   * c) DELETE SCHEMA hr;
   * d) ERASE SCHEMA hr;

---

### Short Answer

1. Write the SQL to create a schema `analytics`.
2. Why do we use schemas in databases?

---

### Answers

1. ✅ **Answer:** c) public
2. ✅ **Answer:** a) database
3. ✅ **Answer:** b) DROP SCHEMA hr CASCADE;
