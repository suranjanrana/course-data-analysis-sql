# Exercises & Quizzes

## Practice Tables

We’ll continue using:

* `hr.employees`
* `sales.orders`

---

## Exercises

1. Count the number of employees in each department.
2. Show the average salary of employees in each department.
3. Find the department with the **highest number of employees**.
4. List products with a total sales quantity above 50.
5. Show the minimum and maximum salary per department.
6. Display departments where average salary > 70,000.
7. Find total revenue (`quantity * price`) by product.
8. Show the number of orders placed per customer.
9. List employees hired per year (group by hire\_date year).
10. Which product has the **highest total quantity ordered**?
11. Find departments with **more than 5 employees**.
12. Show customers who spent **over \$10,000 in total**.
13. List years where **average salary exceeded 70,000**.
14. Find the **month with the highest number of orders**.
15. Show employees grouped by **hire year**, only those years with **more than 2 hires**.
16. Find products with **average order quantity greater than 5**.
17. List all customers who placed orders **every month in 2022** (advanced!).

---

## Quiz

### Multiple Choice

1. Which clause filters rows **after aggregation**?

   * a) WHERE
   * b) HAVING
   * c) ORDER BY
   * d) GROUP

2. Which function gives the highest value in a column?

   * a) MAX()
   * b) HIGH()
   * c) TOP()
   * d) UPPER()

3. Which is true about `COUNT(column)`?

   * a) Counts all rows including NULL
   * b) Ignores NULL values
   * c) Returns only distinct values
   * d) Only works with integers

---

### Short Answer

1. Write a query to find the department with the lowest average salary.
2. Explain the difference between `WHERE` and `HAVING`.

---

### Answers

1. ✅ **Answer:** b) HAVING
2. ✅ **Answer:** a) MAX()
3. ✅ **Answer:** b) Ignores NULL values
