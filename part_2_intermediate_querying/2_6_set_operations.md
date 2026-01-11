# Topic 10 — Set Operations (UNION, INTERSECT, EXCEPT)

## 10.1 What Are Set Operations?

- Set operations combine the results of two or more SELECT queries into a single result set.
- They are based on set theory (math concept) and operate row-wise, not column-wise.

### Why analysts use set operations

- Combine results from different time periods
- Compare datasets (overlap, differences)
- Validate data consistency
- Perform cohort analysis

---

## 10.2 Rules for Set Operations (Very Important)

For set operations to work:

1. Each SELECT must return same number of columns
2. Columns must have compatible data types
3. Column order must match
4. Column names come from the first SELECT

❌ You cannot use:

- ORDER BY inside individual queries
- Different column structures

---

## 10.3 Types of Set Operations

| Operation | Description                  | Removes Duplicates? |
| --------- | ---------------------------- | ------------------- |
| UNION     | Combines results             | Yes                 |
| UNION ALL | Combines results             | No                  |
| INTERSECT | Common rows only             | Yes                 |
| EXCEPT    | Rows in first, not in second | Yes                 |

---

## 10.4 Practice Tables

We’ll reuse employees and orders, plus add a second orders table to simulate multiple sources.

```sql
CREATE TABLE sales.orders_2022 (
    orderid INT PRIMARY KEY,
    empid INT,
    amount DECIMAL(10,2),
    order_date DATE
);

INSERT INTO sales.orders_2022 VALUES
(201, 1, 400.00, '2022-06-10'),
(202, 2, 650.00, '2022-07-15'),
(203, 3, 300.00, '2022-09-01');
```

`sales.orders` already contains 2023 data

---

## 10.5 UNION

### UNION (Removes Duplicates)

```sql
SELECT empid
FROM sales.orders_2022
UNION
SELECT empid
FROM sales.orders;
-- Combines employee IDs from both years
-- Duplicate empid values appear only once
```

**Use case**:

“Which employees have made sales at any time?”

### UNION with Multiple Columns

```sql
SELECT empid, amount
FROM sales.orders_2022
UNION
SELECT empid, amount
FROM sales.orders;
-- Rows must match exactly to be considered duplicates
```

---

## 10.6 UNION ALL (Keep Duplicates)

```sql
SELECT empid
FROM sales.orders_2022
UNION ALL
SELECT empid
FROM sales.orders;
-- Keeps all rows
-- Faster than UNION
```

**Tip:**

Use UNION ALL when:

- You don’t need deduplication
- You plan to aggregate later

### Total Sales Across Years (Correct Pattern)

```sql
SELECT empid, SUM(amount) AS total_sales
FROM (
    SELECT empid, amount
    FROM sales.orders_2022
    UNION ALL
    SELECT empid, amount
    FROM sales.orders
) t
GROUP BY empid;
-- Combines datasets first
-- Aggregates afterward (best practice)
```

---

## 10.6 INTERSECT

### INTERSECT (Common Rows Only)

```sql
SELECT empid
FROM sales.orders_2022
INTERSECT
SELECT empid
FROM sales.orders;
-- Returns employees who made sales in both years
```

**Use case:**

Identifying consistently active sales reps.

### INTERSECT with Multiple Columns

```sql
SELECT empid, amount
FROM sales.orders_2022
INTERSECT
SELECT empid, amount
FROM sales.orders;
-- Returns exact matches in both tables
-- Rare in real data
```

---

## 10.7 EXCEPT

### EXCEPT (Difference Between Sets)

```sql
SELECT empid
FROM sales.orders_2022
EXCEPT
SELECT empid
FROM sales.orders;
-- Employees who made sales in 2022 but not 2023
```

### Reverse EXCEPT

```sql
SELECT empid
FROM sales.orders
EXCEPT
SELECT empid
FROM sales.orders_2022;
-- Employees who are new in 2023
```

---

## 10.8 Set Operations vs Joins

| Scenario                | Better Choice |
| ----------------------- | ------------- |
| Combine rows vertically | UNION         |
| Compare overlap         | INTERSECT     |
| Find differences        | EXCEPT        |
| Combine columns         | JOIN          |
| Aggregate after merge   | UNION ALL     |

---

## 10.9 Realistic Analyst Scenarios

### Scenario 1: Employees Active Every Year

```sql
SELECT empid
FROM sales.orders_2022
INTERSECT
SELECT empid
FROM sales.orders;
-- Retention / consistency analysis
```

### Scenario 2: Employees Who Churned

```sql
SELECT empid
FROM sales.orders_2022
EXCEPT
SELECT empid
FROM sales.orders;
-- Attrition or inactivity detection
```

### Scenario 3: Combine Sales Data Before Dashboarding

```sql
SELECT empid, order_date, amount
FROM sales.orders_2022
UNION ALL
SELECT empid, order_date, amount
FROM sales.orders;
-- Prepares unified dataset for BI tools
```

---

## 10.10 Notes

- Set operations work row-wise, not column-wise
- UNION removes duplicates → slower
- UNION ALL is faster → preferred for analytics
- INTERSECT = overlap
- EXCEPT = difference
- ORDER BY applies only once at the end

### Example

```sql
SELECT empid
FROM sales.orders_2022
UNION
SELECT empid
FROM sales.orders
ORDER BY empid;
-- ORDER BY applies to final result
```
