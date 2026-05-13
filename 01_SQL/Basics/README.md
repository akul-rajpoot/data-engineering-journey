# SQL Basics - Day 1

## 📌 Topics Covered

- SELECT  
- WHERE  
- ORDER BY  
- LIMIT  
- AND / OR  

---

## 🎯 Goal

Understand how to:
- Fetch data from tables  
- Filter rows using conditions  
- Sort results  
- Limit output  
- Combine multiple conditions  

---

## 1️⃣ SELECT

Used to fetch data from a table.

### Syntax

```sql
SELECT column1, column2
FROM table_name;
```

### Examples

```sql
SELECT * FROM employees;

SELECT name, salary FROM employees;
```

---

## 2️⃣ WHERE

Used to filter rows based on conditions.

### Operators

- = (equal)  
- > (greater than)  
- < (less than)  
- >= (greater than or equal)  
- <= (less than or equal)  
- != (not equal)  

### Examples

```sql
SELECT * FROM employees WHERE salary > 50000;

SELECT * FROM employees WHERE department = 'IT';
```

---

## 3️⃣ ORDER BY

Used to sort results.

### Syntax

```sql
SELECT * FROM table_name
ORDER BY column_name ASC;
```

### Examples

```sql
SELECT * FROM employees ORDER BY salary;

SELECT * FROM employees ORDER BY salary DESC;
```

---

## 4️⃣ LIMIT

Used to restrict number of rows returned.

### Syntax

```sql
SELECT * FROM table_name
LIMIT n;
```

### Example

```sql
SELECT * FROM employees LIMIT 5;
```

---

## 5️⃣ AND / OR

Used to combine multiple conditions.

### Examples

```sql
SELECT * FROM employees 
WHERE salary > 50000 AND department = 'IT';

SELECT * FROM employees 
WHERE department = 'IT' OR department = 'HR';
```

---

## 🧠 Key Takeaways

- SELECT → Fetch data  
- WHERE → Filter rows  
- ORDER BY → Sort results  
- LIMIT → Restrict output  
- AND / OR → Combine conditions  

---

## 📂 Practice File

All queries are available in:

```text
01_select_where_order_limit.sql
```

---

## 🚀 Next Step

Move to:
- GROUP BY  
- Aggregations (COUNT, SUM, AVG)  
- Real-world query patterns  


# SQL Aggregations 

## Topics Covered

- GROUP BY
- COUNT()
- SUM()
- AVG()
- MIN()
- MAX()
- IFNULL()
- COALESCE()

---

## GROUP BY

Used to group rows based on a column.

### Example

```sql
SELECT department, COUNT(*)
FROM employees
GROUP BY department;
```

## Aggregation Functions
### COUNT() : Counts number of rows.
```sql
SELECT COUNT(*) FROM employees;
```
### SUM() : Calculates total.
```sql
SELECT SUM(salary) FROM employees;
```
### AVG() : Calculates average.
```sql
SELECT AVG(salary) FROM employees;
```

### MAX() / MIN() : Find highest / lowest value.
```sql
SELECT MAX(salary), MIN(salary) FROM employees;
```

### IFNULL() : Return the specified value IF the expression is NULL, otherwise return the expression
```sql 
SELECT IFNULL(NULL, value);
```

### COALESCE() : Return the first non-null value in a list
```SQL
SELECT COALESCE(NULL, NULL, NULL, 'value', NULL, 'another value');
```

### Having() to filter the results of a GROUP BY
```text
WHERE → filters rows
GROUP BY → groups data
```
```sql
SELECT column1, aggregate_function(column2), column3, ...
FROM table_name
WHERE condition
GROUP BY column1, column3
HAVING condition -- The condition on grouped data
ORDER BY column_name;
```


## 🧠 Key Takeaways
- GROUP BY is used for grouping data
- Aggregations summarize data
- Used heavily in analytics & reporting
- WHERE → before grouping  
- HAVING → after grouping