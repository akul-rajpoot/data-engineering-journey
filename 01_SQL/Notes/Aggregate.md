# SQL Theory Notes: GROUP BY & Aggregations

---

## 1. GROUP BY

GROUP BY is used to group rows based on one or more columns.

### Concepts

- Combines rows that have the same values in specified columns  
- Creates groups for aggregation  
- Each group returns a single row in output  

### Key Points

- Used with aggregation functions  
- Every column in SELECT must either be:
  - part of GROUP BY  
  - or used inside an aggregate function  
- Changes row-level data into grouped data  

---

## 2. Aggregation Functions

Aggregation functions perform calculations on a group of rows and return a single value.

---

## COUNT()

Counts number of rows.

### Concepts

- Can count all rows or specific column values  
- Ignores NULL values (except COUNT(*))

### Key Points

- COUNT(*) → counts all rows  
- COUNT(column) → ignores NULL values  

---

## SUM()

Calculates total of numeric values.

### Concepts

- Works only on numeric columns  
- Ignores NULL values  

### Key Points

- Used for totals (e.g., total salary, total revenue)  

---

## AVG()

Calculates average value.

### Concepts

- Uses SUM / COUNT internally  
- Ignores NULL values  

### Key Points

- Returns decimal values  
- Can be affected by outliers  

---

## MAX() / MIN()

Finds highest and lowest values.

### Concepts

- Works on numeric, date, and string columns  

### Key Points

- MAX → highest value  
- MIN → lowest value  

---

## 3. GROUP BY Behavior

### Important Rules

- GROUP BY reduces number of rows  
- Each group produces one output row  
- Used for summarizing data  

---

## 4. WHERE vs GROUP BY

### Difference

| Clause | Purpose |
|--------|--------|
| WHERE | filters rows |
| GROUP BY | groups rows |

### Key Idea

- WHERE filters data BEFORE grouping  
- GROUP BY organizes data AFTER filtering  

---

## 5. Common Mistakes

- Using non-grouped columns in SELECT  
- Forgetting GROUP BY when using aggregation  
- Confusing WHERE with HAVING  

---

## 6. SQL Execution Order (With GROUP BY)

```text
FROM → WHERE → GROUP BY → SELECT → ORDER BY → LIMIT
```
# SUMMARY
- GROUP BY groups data
- Aggregations summarize data
- COUNT, SUM, AVG, MAX, MIN are core functions
- WHERE works before grouping
- Aggregations work on grouped data

# Notes for Interviews

* GROUP BY is heavily used in analytics
* COUNT(*) vs COUNT(column) is commonly asked
* Aggregations ignore NULL values
* Understanding execution order is critical