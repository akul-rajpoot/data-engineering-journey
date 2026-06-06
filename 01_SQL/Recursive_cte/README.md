

# Recursive CTE (Common Table Expression)

## What is a Recursive CTE?

A Recursive CTE is a CTE that references itself. It is used to solve problems where the next row depends on the previous row.

Typical use cases:
- Generate numbers
- Generate dates
- Employee hierarchy / org chart
- Parent-child relationships
- Folder structures
- Category trees
- Graph traversal
- Path building

---

## Syntax

```sql
WITH RECURSIVE cte_name AS (

    -- Anchor Query
    SELECT ...

    UNION ALL

    -- Recursive Query
    SELECT ...
    FROM cte_name
    WHERE condition
)
SELECT *
FROM cte_name;
```

---

## Components of a Recursive CTE

### 1. Anchor Query

The starting point.

```sql
SELECT 1 AS n
```

Produces the first row.

---

### 2. Recursive Query

References the CTE itself.

```sql
SELECT n + 1
FROM numbers
WHERE n < 10
```

Keeps generating rows until the condition becomes false.

---

### 3. Termination Condition

```sql
WHERE n < 10
```

Without a termination condition, recursion can continue indefinitely or hit the database recursion limit.

---

## Example 1: Generate Numbers 1 to 10

```sql
WITH RECURSIVE numbers AS (

    SELECT 1 AS n

    UNION ALL

    SELECT n + 1
    FROM numbers
    WHERE n < 10
)
SELECT *
FROM numbers;
```

Output:

```text
1
2
3
4
5
6
7
8
9
10
```

---

## Example 2: Generate Dates

```sql
WITH RECURSIVE dates AS (

    SELECT DATE('2025-01-01') AS dt

    UNION ALL

    SELECT DATE_ADD(dt, INTERVAL 1 DAY)
    FROM dates
    WHERE dt < '2025-01-10'
)
SELECT *
FROM dates;
```

---

## Example 3: Multiplication Table

```sql
WITH RECURSIVE nums AS (
    SELECT 1 AS n

    UNION ALL

    SELECT n + 1
    FROM nums
    WHERE n < 10
)
SELECT n,
       n * 5 AS table_of_5
FROM nums;
```

---

# Employee Hierarchy Example

## Table

```sql
CREATE TABLE employees (
    emp_id INT,
    emp_name VARCHAR(50),
    manager_id INT
);
```

Data:

```text
1  CEO     NULL
2  Amit    1
3  Rahul   1
4  Neha    2
5  Priya   2
6  Karan   4
```

Hierarchy:

```text
CEO
├── Amit
│   ├── Neha
│   │   └── Karan
│   └── Priya
└── Rahul
```

---

## Find Entire Hierarchy

```sql
WITH RECURSIVE emp_tree AS (

    SELECT emp_id,
           emp_name,
           manager_id,
           1 AS level
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    SELECT e.emp_id,
           e.emp_name,
           e.manager_id,
           t.level + 1
    FROM employees e
    JOIN emp_tree t
      ON e.manager_id = t.emp_id
)
SELECT *
FROM emp_tree;
```

---

## Find Reporting Level

```sql
WITH RECURSIVE emp_tree AS (

    SELECT emp_id,
           emp_name,
           manager_id,
           1 AS level
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    SELECT e.emp_id,
           e.emp_name,
           e.manager_id,
           t.level + 1
    FROM employees e
    JOIN emp_tree t
      ON e.manager_id = t.emp_id
)
SELECT emp_name,
       level
FROM emp_tree;
```

---

## Build Full Path

```sql
WITH RECURSIVE emp_tree AS (

    SELECT emp_id,
           emp_name,
           manager_id,
           emp_name AS path
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    SELECT e.emp_id,
           e.emp_name,
           e.manager_id,
           CONCAT(t.path,' -> ',e.emp_name)
    FROM employees e
    JOIN emp_tree t
      ON e.manager_id = t.emp_id
)
SELECT *
FROM emp_tree;
```

---

# Interview Questions

### Easy

1. Generate numbers from 1 to 100.
2. Generate dates for a month.
3. Generate multiplication table of 7.

### Medium

4. Employee hierarchy.
5. Find all employees under a manager.
6. Find hierarchy depth.
7. Build reporting path.

### Hard

8. Category hierarchy.
9. Folder structure traversal.
10. Graph traversal.
11. Find all descendants of a node.
12. Find shortest hierarchy path.

---

# Important Interview Notes

## UNION ALL vs UNION

Use:

```sql
UNION ALL
```

because:
- Faster
- No duplicate elimination
- Standard recursive pattern

---

## Recursion Limit

Different databases impose recursion limits.

Examples:
- SQL Server: MAXRECURSION option
- MySQL: recursive execution limits
- PostgreSQL: recursion continues until termination condition

---

## Common Mistakes

### Missing termination condition

```sql
SELECT n + 1
FROM numbers
```

Can cause infinite recursion.

---

### Wrong join condition

```sql
ON e.emp_id = t.emp_id
```

instead of

```sql
ON e.manager_id = t.emp_id
```

---

### Using UNION instead of UNION ALL

Can slow execution significantly.

---

# When To Use Recursive CTE

Use Recursive CTE when:
- Data has parent-child relationships
- Need hierarchy traversal
- Need path generation
- Need iterative row generation
- Need recursive dependency resolution

Avoid Recursive CTE when:
- Simple joins solve the problem
- Very large hierarchies cause performance issues
- Recursive logic can be replaced with a numbers/calendar table

---

# Quick Revision

A Recursive CTE always has:

1. Anchor Query
2. UNION ALL
3. Recursive Query
4. Termination Condition

Most common interview uses:
- Generate numbers
- Generate dates
- Employee hierarchy
- Manager reporting chain
- Folder/category tree
- Path generation