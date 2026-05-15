# SQL Window Functions

## 📌 Topics Covered

- ROW_NUMBER()
- RANK()
- DENSE_RANK()
- PARTITION BY
- ORDER BY

---

## 🎯 Goal

Understand how to:
- rank data within groups
- perform calculations without grouping
- solve advanced SQL problems

---

## What is a Window Function?

A window function performs calculations across a set of rows while retaining individual row details.

---
### ROW_NUMBER() : Assigns unique number to each row
```sql 
SELECT name, department, salary,
ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) as rn
FROM employees;
```

### 2. RANK() : Same rank for same values, but skips numbers

```sql
SELECT name, department, salary,
RANK() OVER (PARTITION BY department ORDER BY salary DESC) as rnk
FROM employees;
```

### 3. DENSE_RANK() : Same rank for ties, no skipping

```sql
SELECT name, department, salary,
DENSE_RANK() OVER (PARTITION BY department ORDER BY salary DESC) as drnk
FROM employees;
```


## Key Takeaways

* Does not reduce rows
* Works with partitions
* Used for ranking and analytics
* Replaces complex joins/subqueries

## 🔥 Why This Is Important : With window functions you can:
* replace subqueries
* simplify joins
* solve advanced interview problems

## Practice File
```text
01_Ranking.sql
```





