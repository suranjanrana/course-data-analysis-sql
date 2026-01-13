# Exercises & Quizzes

## Practice Tables

We’ll continue using employee sales data. i.e., `sale.orders`

---

## Exercises

1. Rank orders per employee by amount
2. Find top 2 orders per employee
3. Calculate running total per employee
4. Show each order with employee’s total sales
5. Compare each order with employee average
6. Identify lowest order per employee
7. Explain ROW_NUMBER vs RANK
8. When should GROUP BY be avoided?
9. Rewrite a GROUP BY query using window function
10. Predict output of a ranking query

---

## Quiz

### Multiple Choice

1. What is the main difference between GROUP BY and window functions?

    * a. GROUP BY is faster than window functions
    * b. Window functions require joins
    * c. GROUP BY reduces the number of rows, window functions do not
    * d. Window functions cannot perform aggregation

2. Which keyword is mandatory when using a window function?

    * a. PARTITION
    * b. GROUP
    * c. OVER
    * d. WINDOW

3. What does PARTITION BY do in a window function?

    * a. Sorts the result set
    * b. Filters rows
    * c. Divides rows into groups without collapsing them
    * d. Limits the number of rows returned

4. Which window function assigns a unique sequential number to rows even if values are the same?

    * a. RANK()
    * b. DENSE_RANK()
    * c. ROW_NUMBER()
    * d. COUNT()

5. Which window function is most suitable for calculating a running total?

    * a. SUM() with GROUP BY
    * b. SUM() OVER (ORDER BY ...)
    * c. COUNT()
    * d. RANK()

---

### Answers

1. ✅ **Answer**: c
2. ✅ **Answer**: c
3. ✅ **Answer**: c
4. ✅ **Answer**: c
5. ✅ **Answer**: b
