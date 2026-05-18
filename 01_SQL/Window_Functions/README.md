# SQL Window Functions

## 📌 Topics Covered

- ROW_NUMBER()
- RANK()
- DENSE_RANK()
- PARTITION BY
- ORDER BY
- LEAD & LAG
- Running Totals
- Moving Average / Rolling Window
- Window Frames

---

## 🎯 Goal

Understand how to:
- rank data within groups  
- perform calculations without grouping  
- compare rows  
- calculate cumulative and rolling metrics  
- solve advanced SQL problems  

---

## 🧠 What is a Window Function?

A window function performs calculations across a set of rows while **retaining individual row details**.

---

# 🔹 Ranking Functions

### 1. ROW_NUMBER() — Assigns unique number to each row

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


## LEAD & LAG

### LAG() : function is used to get value from the row that precedes the current row

```sql
LAG(expr, N, default) 
          OVER (Window_specification | Window_name)
```

### LEAD() : function is used to get value from a row that succeeds the current row.
'''sql
LEAD(expr, N, default) 
          OVER (Window_specification | Window_name)
'''

## Use Cases
* Compare rows
* Detect changes
* Track trends
* Time-series analysis

## 🧠 Real-World Use :LEAD/LAG is used in:

* stock price changes
* user activity tracking
* ETL pipelines
* audit logs

## Running Totals (Cumulative) the continuous addition of a sequence of numbers
```sql
SELECT name, department, salary,
AVG(salary) OVER (PARTITION BY department ORDER BY emp_id) as running_avg
FROM employees;
```

## Cumulative Count
```sql
SELECT name, department,
COUNT(*) OVER (PARTITION BY department ORDER BY emp_id) as cum_count
FROM employees;
```

### Window Frames (Important) :Default Running Frame
- Includes current row
```sql
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
```
-Excludes current row
```sql
-ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING
```

## Moving Average / Rolling Window
- Moving Average (Last 2 Rows)
```sql
SELECT name, department, salary,
AVG(salary) OVER (
    PARTITION BY department 
    ORDER BY emp_id
    ROWS BETWEEN 1 PRECEDING AND CURRENT ROW
) as moving_avg
FROM employees;
```
- Moving Sum (Last 3 Rows)
```sql
SELECT name, department, salary,
SUM(salary) OVER (
    PARTITION BY department 
    ORDER BY emp_id
    ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
) as moving_sum
FROM employees;
```
### 🧠 Key Concept

```text
N PRECEDING + CURRENT ROW = N+1 rows
```

## 🔥 Key Takeaways

* Window functions do not reduce rows
* PARTITION BY splits data into groups
* ORDER BY defines calculation sequence
* LAG/LEAD help compare rows
* Running totals calculate cumulative values
* Moving windows calculate rolling metrics
* Window frames control data scope


## 🚀 Why This Is Important

With window functions you can:

* replace complex subqueries
* simplify joins
* perform analytics easily
* solve advanced interview problems

## 🧠 Real-World Use Cases

* financial dashboards
* revenue tracking
* stock price analysis
* user behavior analytics
* ETL pipelines


## 📁 Practice Files
```text
01_ranking.sql
02_lead_lag.sql
03_running_totals.sql
```



