
# Exercises & Quizzes

## Practice Tables

We’ll continue using:

* `hr.employees`
* `sales.orders`

---

## Exercises

1. Show all employees with their department names (INNER JOIN).
2. List all employees, including those without a department (LEFT JOIN).
3. Show all departments, even if no employees are assigned (RIGHT JOIN).
4. Return a list of all employees and departments, matched where possible (FULL JOIN).
5. Count the number of employees in each department.
6. Find employees who don’t belong to any department.
7. Show departments with no employees.
8. Join employees and orders to find how many orders each employee handled.
9. Get a list of departments with the average salary of their employees.
10. Which employees belong to the IT department?
11. List all employees with their department names (INNER JOIN).
12. Use `USING(deptid)` to join employees and departments.
13. Use `NATURAL JOIN` to connect employees and departments. What happens?
14. Join employees and departments on both `deptid` and `location`.
15. List employees working in the same **city** as their department.

---

## Quiz

### Multiple Choice

1. Which join returns only rows where there’s a match in both tables?

   * a) LEFT JOIN
   * b) RIGHT JOIN
   * c) INNER JOIN
   * d) FULL JOIN

2. Which join ensures that **all rows from the left table** are returned?

   * a) LEFT JOIN
   * b) RIGHT JOIN
   * c) FULL JOIN
   * d) INNER JOIN

3. Which join type may not be supported in MySQL?

   * a) LEFT JOIN
   * b) INNER JOIN
   * c) FULL JOIN
   * d) RIGHT JOIN

4. Which join auto-matches columns with the same name?

   * a) INNER JOIN
   * b) NATURAL JOIN
   * c) USING
   * d) FULL JOIN

---

### Short Answer

1. Write a query to show all departments with their total number of employees (include those with none).
2. Explain the difference between INNER JOIN and LEFT JOIN in your own words.
3. What is the main difference between `USING()` and `NATURAL JOIN`?

---

### Answers

1. Answer: c) INNER JOIN
2. Answer: a) LEFT JOIN
3. Answer: c) FULL JOIN
4. Answer: b) NATURAL JOIN

---
