# Exercises & Quizzes

## Practice Tables

We’ll continue with the same tables:

* `hr.employees`
* `hr.departments`
* `sales.orders`

---

## Exercises

1. List all employees’ names and salaries.
2. Retrieve employees hired after `2021-06-01`.
3. Show employees in the IT department (deptid = 2).
4. Get a list of **unique department IDs** from employees.
5. Show the **top 2 highest paid employees**.
6. List employees with salary between 55,000 and 75,000.
7. Show employees whose names start with "C".
8. List all orders sorted by `amount` (highest first).
9. Find employees whose salary is greater than 60,000.
10. List employees who are **not in dept 2**.
11. Get all employees hired in 2022.
12. Show top 3 employees with the **lowest salaries**.
13. Display employees from dept 2 OR salary above 75,000.
14. Find all employees whose name contains "ar".
15. Retrieve employees not in IT or Sales (not dept 2 or 3).
16. Show first 5 orders sorted by date (newest first).

---

## Quiz

### Multiple Choice

1. Which keyword is used to remove duplicates?

   * a) UNIQUE
   * b) DISTINCT
   * c) ONLY
   * d) FILTER
     **Answer:** b) DISTINCT

2. What does `WHERE hire_date BETWEEN '2021-01-01' AND '2021-12-31'` return?

   * a) Employees hired only on Jan 1st and Dec 31st
   * b) Employees hired in the year 2021
   * c) Employees hired before 2021
   * d) Employees hired after 2021
     **Answer:** b) Employees hired in the year 2021

3. Which symbol is used in SQL for a wildcard (pattern matching)?

   * a) \*
   * b) %
   * c) #
   * d) &
     **Answer:** b) %

---

### Short Answer

1. Write a query to find all employees in the **Sales** department (deptid = 3).
2. How do you sort employees by salary (highest first)?
