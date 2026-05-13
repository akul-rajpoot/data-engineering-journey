# SQL Theory Notes: SELECT, WHERE, ORDER BY

---

## 1. SELECT

SELECT is used to retrieve data from a database table.

### Concepts

- Defines which columns should be returned
- Output structure depends on selected columns
- Can be used with expressions, functions, and aliases

### Key Points

- `SELECT *` returns all columns (not recommended in production)
- You can select specific columns for better performance
- Column order in SELECT defines output order

---

## 2. WHERE

WHERE is used to filter rows based on conditions.

### Concepts

- Applies conditions to individual rows
- Only rows satisfying the condition are returned

### Key Points

- Executed before grouping and aggregation
- Cannot use aggregate functions (COUNT, SUM, etc.)
- Supports comparison and logical operators
- Works at row-level (not group-level)

---

## 3. ORDER BY

ORDER BY is used to sort query results.

### Concepts

- Controls the order of returned rows
- Sorting can be ascending or descending

### Key Points

- Default sorting is ascending (ASC)
- DESC is used for descending order
- Can sort by multiple columns
- Sorting happens after filtering (WHERE)

---

## 4. LIMIT

LIMIT is used to restrict the number of rows returned.

### Concepts

- Controls how many rows are included in output
- Useful for large datasets and pagination

### Key Points

- Applied at the end of query execution
- Often used with ORDER BY to get top/bottom results
- Improves performance by reducing result size

---

## 5. AND / OR (Logical Operators)

Used to combine multiple conditions in a query.

### Concepts

- AND: all conditions must be true
- OR: at least one condition must be true

### Key Points

- AND has higher precedence than OR
- Parentheses should be used for clarity in complex conditions
- Logical conditions are evaluated row by row

---

## SQL Execution Order (Important)

Understanding execution order is critical for writing correct queries.

```text
FROM → WHERE → SELECT → ORDER BY → LIMIT
```
 ## Explanation

- FROM: identifies source table
- WHERE: filters rows
- SELECT: chooses columns
- ORDER BY: sorts data
- LIMIT: restricts output

## Notes for Interviews

- WHERE cannot use aggregate functions
- ORDER BY is applied after filtering
- LIMIT is used for pagination
- Logical conditions should be carefully structured