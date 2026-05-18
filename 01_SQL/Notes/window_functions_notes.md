# SQL Theory Notes: Window Functions

---

## 1. What is a Window Function?

A window function performs calculations across a set of rows related to the current row, without collapsing the result set.

---

## 2. Key Difference from GROUP BY

| GROUP BY | Window Function |
|--------|----------------|
| Reduces rows | Keeps all rows |
| One result per group | One result per row |
| Loses detail | Retains detail |

---

## 3. Basic Syntax

```sql
FUNCTION(column) OVER (
    PARTITION BY column
    ORDER BY column
)
```

## 4. Components of Window Function
### PARTITION BY
* Divides data into groups
* Works similar to GROUP BY but does not collapse rows

### ORDER BY

* Defines sequence of rows within partition
* Important for ranking and cumulative calculations

## 5. Types of Window Functions

### Ranking Functions

* ROW_NUMBER() → unique ranking
* RANK() → same rank, skips numbers
* DENSE_RANK() → same rank, no gaps

### Aggregate Window Functions

* SUM() → running total
* AVG() → running average
* COUNT() → cumulative count

### Analytical Functions

* LAG() → previous row value
* LEAD() → next row value

## 6. LAG & LEAD

LAG(column, offset, default)\
LEAD(column, offset, default)

Parameters

* column → value to fetch
* offset → number of rows
* default → value if no row exists

### Use Cases

* Compare current vs previous row
* Detect increase/decrease
* Time-series analysis


## 7. Running Totals (Cumulative Calculations)
Concept
* Running total calculates cumulative value up to current row.

```sql
SUM(salary) OVER (PARTITION BY department ORDER BY emp_id)
```


## 8. Window Frames : Defines range of rows used for calculation.

UNBOUNDED PRECEDING → CURRENT ROW\
UNBOUNDED PRECEDING → 1 PRECEDING

```sql 
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
```


## 9. Moving Window : Calculates values over a fixed number of previous rows.

ROWS BETWEEN N PRECEDING AND CURRENT ROW

```sql
ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
```

## 10 Running vs Moving
|  Type | Description |
|--------|----------------|
| Running | From start to current row |
| Moving | Fixed-size sliding window |


## 11. Important Rules
-   ORDER BY is required for meaningful results
-   Window functions do not reduce rows
-   Cannot nest window functions
-   Use subqueries for chaining

## 12. Common Mistakes

* Missing ORDER BY
* Using wrong window frame
* Including current row when it should be excluded
* Using GROUP BY instead of window functions
* Trying to nest window functions

## 13. Interview Insights

* Window functions are heavily used in Data Engineering
* Most questions combine ranking + aggregation
* Understanding window frame is key
* Real problems involve multiple window functions


## Summary

* Window functions retain row-level data
* Used for ranking, comparison, and analytics
* PARTITION BY defines groups
* ORDER BY defines sequence
* Window frames control calculation scope
