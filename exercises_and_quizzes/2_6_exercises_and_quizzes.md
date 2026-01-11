# Exercises & Quizzes

## Exercises

1. List employees with sales in any year
2. Employees with sales in both years
3. Employees only active in 2022
4. Employees only active in 2023
5. Total sales per employee across years
6. Difference between UNION and UNION ALL
7. Why UNION ALL is faster?

---

## Quiz

### Multiple Choice

1. What is the primary requirement for using SQL set operations (UNION, INTERSECT, EXCEPT)?

    - a. Tables must have the same name
    - b. Columns must have identical names
    - c. Each SELECT must return the same number of columns with compatible data types
    - d. Both queries must use the same table

2. Which SQL set operation removes duplicate rows by default?

    - a. UNION ALL
    - b. UNION
    - c. INTERSECT ALL
    - d. EXCEPT ALL

3. Which set operation returns only rows that exist in both result sets?

    - a. UNION
    - b. EXCEPT
    - c. INTERSECT
    - d. JOIN

4. Which SQL set operation is the most efficient when combining large datasets and duplicates do not matter?

    - a. UNION
    - b. INTERSECT
    - c. UNION ALL
    - d. EXCEPT

5. If an employee appears in orders_2022 but not in orders_2023, which operation will correctly identify that employee?

    - a. UNION
    - b. INTERSECT
    - c. EXCEPT
    - d. JOIN

6. Where can ORDER BY be applied when using SQL set operations?

    - a. Inside each SELECT statement
    - b. Inside the first SELECT only
    - c. Inside the last SELECT only
    - d. After the final combined result

7. Which operation would you use to identify employees who made sales in every year?

    - a. UNION
    - b. UNION ALL
    - c. INTERSECT
    - d. EXCEPT

8. Which of the following is NOT a valid use case for SQL set operations?

    - a. Combining rows from multiple years
    - b. Finding overlapping employees
    - c. Calculating total sales per employee
    - d. Identifying differences between datasets

9. What happens if column data types are incompatible in a UNION query?

    - a. SQL automatically converts them
    - b. The query executes but returns NULL
    - c. The query fails with an error
    - d. SQL ignores mismatched columns

10. Why do analysts often prefer UNION ALL over UNION?

    - a. It removes duplicates automatically
    - b. It is faster and avoids unnecessary deduplication
    - c. It sorts the data automatically
    - d. It allows different column structures

---

### Answers

1. ✅ **Answer**: c
2. ✅ **Answer**: b
3. ✅ **Answer**: c
4. ✅ **Answer**: c
5. ✅ **Answer**: c
6. ✅ **Answer**: d
7. ✅ **Answer**: c
8. ✅ **Answer**: c
9. ✅ **Answer**: c
10. ✅ **Answer**: b
