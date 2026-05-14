# SQL Joins

## 📌 Topics Covered

- INNER JOIN  
- LEFT JOIN  
- RIGHT JOIN  
- SELF JOIN  
- ANTI JOIN (LEFT JOIN + NULL)  
- Multi-table joins  

---

## 🎯 Goal

Understand how to:
- combine data from multiple tables  
- handle missing relationships  
- solve real-world data problems  

---

## 🔗 What is JOIN?

JOIN is used to combine data from two or more tables based on a common column.

---

## 🔹 INNER JOIN

Returns only matching rows from both tables.

```sql
SELECT e.name, d.manager
FROM employees e
JOIN departments d
ON e.department = d.dept_name;
```

## LEFT JOIN : Returns all rows from left table and matching rows from right table.
```sql
SELECT e.name, d.manager
FROM employees e
LEFT JOIN departments d
ON e.department = d.dept_name;
```

## RIGHT JOIN : Returns all rows from right table and matching rows from left table.
```sql
SELECT e.name, d.dept_name
FROM employees e
RIGHT JOIN departments d
ON e.department = d.dept_name;
```

## SELF JOIN : Joining a table with itself.
```sql
SELECT e1.name, e2.name
FROM employees e1
JOIN employees e2
ON e1.department = e2.department
AND e1.emp_id < e2.emp_id;
```

## 🧠 Key Takeaways

* JOIN combines tables
* ON defines relationship
* LEFT JOIN keeps all left rows
* RIGHT JOIN keeps all right rows
* NULL helps detect missing data
* JOIN can multiply rows

## 🚀 Practice Files

* Joins.sql