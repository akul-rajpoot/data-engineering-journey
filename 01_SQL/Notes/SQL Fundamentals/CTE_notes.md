

# SQL Theory Notes: CTE (Common Table Expression)

---

## 1. What is CTE?

CTE (Common Table Expression) is a temporary named result set that can be used within a SQL query.

---

## 2. Why Use CTE?

- Improves readability  
- Breaks complex queries into steps  
- Avoids deeply nested subqueries  
- Makes debugging easier  

---

## 3. Basic Syntax

```sql
WITH cte_name AS (
    SELECT ...
)
SELECT * FROM cte_name;
```

---

## 4. Key Characteristics

- Exists only for one query  
- Not stored permanently  
- Can be referenced multiple times in the same query  
- Improves query structure  

---

## 5. CTE vs Subquery

| Subquery | CTE |
|----------|-----|
| Nested | Named |
| Harder to read | More readable |
| Less reusable | Reusable |
| Complex structure | Cleaner structure |

---

## 6. Types of CTE

### Simple CTE
Used for a single temporary result.

---

### Multiple CTEs

```sql
WITH a AS (...),
     b AS (...)
SELECT ...
```

---

### Recursive CTE (Advanced)

- Used for hierarchical data (like org charts)
- Not commonly asked in basic interviews

---

## 7. CTE with Aggregation

```sql
WITH dept_avg AS (
    SELECT department, AVG(salary) as avg_salary
    FROM employees
    GROUP BY department
)
SELECT * FROM dept_avg;
```

---

## 8. CTE with JOIN

```sql
WITH dept_avg AS (
    SELECT department, AVG(salary) as avg_salary
    FROM employees
    GROUP BY department
)
SELECT e.name, e.salary
FROM employees e
JOIN dept_avg d ON e.department = d.department;
```

---

## 9. CTE with Window Functions

```sql
WITH ranked AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) as rn
    FROM employees
)
SELECT * FROM ranked WHERE rn <= 2;
```

---

## 10. Common Use Cases

- Top N per group  
- Filtering aggregated data  
- Breaking complex queries  
- Combining multiple transformations  

---

## 11. When to Use CTE

- When query becomes complex  
- When multiple steps are required  
- When readability matters  
- When working with window functions  

---

## 12. Common Mistakes

- Overusing CTE unnecessarily  
- Using SELECT * instead of specific columns  
- Thinking CTE stores data permanently  
- Writing inefficient logic inside CTE  

---

## 13. Interview Insights

- CTE is mainly used for structuring queries  
- Logic still depends on joins, aggregations, window functions  
- Often used with ranking and filtering  
- Improves clarity in complex queries  

---

## Summary

- CTE is a temporary named query  
- Improves readability and structure  
- Works well with joins, aggregations, and window functions  
- Helps solve complex SQL problems efficiently  