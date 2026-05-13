# SQL Basics - Day 1

## Topics Covered

- SELECT
- WHERE
- ORDER BY
- LIMIT
- AND / OR

## Goal

Understand how to:
- fetch data
- filter rows
- sort results
- limit output

# SQL Basics - Day 1

## 1. SELECT

Used to fetch data from a table.

### Syntax

'''sql
SELECT column1, column2
FROM table_name;'''

## 2. WHERE

Used to filter rows based on conditions.

Operators

* = (equal)
* (greater than)
* < (less than)
* = (greater than or equal)
* <= (less than or equal)
* != (not equal)

### Example
''' SELECT * FROM employees WHERE salary > 50000;
SELECT * FROM employees WHERE department = 'IT'; '''


## 3. ORDER BY

Used to sort results.
### Syntax
'''
SELECT * FROM table_name
ORDER BY column_name [ASC | DESC];
'''

## 4. LIMIT

Used to restrict number of rows returned.

### Syntax
''' SELECT * FROM table_name
LIMIT n;'''

## 5. AND / OR

Used to combine multiple conditions.
### Example
SELECT * FROM employees 
WHERE salary > 50000 AND department = 'IT';

SELECT * FROM employees 
WHERE department = 'IT' OR department = 'HR';

##Key Takeaways

* SELECT → fetch data
* WHERE → filter rows
* ORDER BY → sort results
* LIMIT → restrict output
* AND/OR → combine conditions

Practice File
All queries are available in:
01_select_where_order_limit.sql
