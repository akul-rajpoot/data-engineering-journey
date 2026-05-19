

# SQL CTE (Common Table Expression)

## 📌 Topics Covered

- Basic CTE
- Multiple CTEs
- CTE with JOIN
- CTE with Window Functions

---

## 🎯 Goal

Understand how to:
- simplify complex queries  
- improve readability  
- reuse query results  
- structure SQL efficiently  

---

## 🧠 What is CTE?

CTE (Common Table Expression) is a temporary result set that can be referenced within a query.

---

## 🔹 Basic Syntax

```sql
WITH cte_name AS (
    SELECT ...
)
SELECT * FROM cte_name;
```

---

## 🔹 Example 1: Basic CTE

```sql
WITH dept_avg AS (
    SELECT department, AVG(salary) as avg_salary
    FROM employees
    GROUP BY department
)
SELECT * FROM dept_avg;
```

---

## 🔹 Example 2: CTE with JOIN

```sql
WITH dept_avg AS (
    SELECT department, AVG(salary) as avg_salary
    FROM employees
    GROUP BY department
)
SELECT e.name, e.salary, e.department
FROM employees e
JOIN dept_avg d ON e.department = d.department
WHERE e.salary > d.avg_salary;
```

---

## 🔹 Example 3: CTE with Window Function

```sql
WITH ranked AS (
    SELECT *,
    ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) as rn
    FROM employees
)
SELECT * FROM ranked
WHERE rn <= 2;
```

---

## 🔹 Multiple CTEs

```sql
WITH dept_avg AS (
    SELECT department, AVG(salary) as avg_sal
    FROM employees
    GROUP BY department
),
overall_avg AS (
    SELECT AVG(salary) as total_avg
    FROM employees
)
SELECT department
FROM dept_avg
WHERE avg_sal > (SELECT total_avg FROM overall_avg);
```

---

## 🔥 Key Takeaways

- CTE improves readability  
- CTE is temporary (exists only for one query)  
- Can be used with JOIN, GROUP BY, Window functions  
- Helps break complex queries into steps  

---

## 🚀 Why This Is Important

- simplifies nested queries  
- improves debugging  
- widely used in real-world SQL  
- common in interviews  

---

## 📁 Practice File

```
01_cte_basics.sql
```