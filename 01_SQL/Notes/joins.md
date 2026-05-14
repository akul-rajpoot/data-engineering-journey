
---

## 1. What is a JOIN?

A JOIN is used to combine rows from two or more tables based on a related column.

---

## 2. Types of Joins

### INNER JOIN

- Returns only matching rows  
- Excludes unmatched data  

---

### LEFT JOIN

- Returns all rows from left table  
- Returns NULL for unmatched rows from right table  

---

### RIGHT JOIN

- Returns all rows from right table  
- Returns NULL for unmatched rows from left table  

---

### FULL OUTER JOIN

- Returns all rows from both tables  
- NULL where no match exists  
- Not directly supported in MySQL (use UNION)

---

## 3. SELF JOIN

- Table joined with itself  
- Used for comparisons, hierarchies, pairing  

---

## 4. ANTI JOIN

- Used to find missing data  
- Implemented using LEFT JOIN + IS NULL  

---

## 5. JOIN Behavior

### Row Multiplication

- If multiple matches exist, rows increase  
- Example: 3 employees × 2 projects = 6 rows  

---

## 6. NULL Behavior

- NULL appears when no match is found  
- Used for detecting missing relationships  

---

## 7. Execution Concept

```text
FROM → JOIN → ON → WHERE → GROUP BY → HAVING → SELECT → ORDER BY