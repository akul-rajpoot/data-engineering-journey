###########################################################
# 🚀 🧠 CASE STUDY 13: Employee Retention & Attrition Analytics
###########################################################

-- Q1: Find each employee's latest status.

-- Q2: Find employees who are currently Active.

-- Q3: Find employees who became Inactive at least once.

-- Q4: Find employees who were re-hired.
-- Definition:
-- Inactive → Active

-- Q5: Find employees who are currently Active
-- but were Inactive in the past.

-- Q6: Find employees whose status changed exactly once.

-- Examples:
-- Active → Inactive ✔
-- Active → Active → Inactive ✔
-- Active → Inactive → Active ❌
-- Active → Active → Active ❌

-- Q7: Find employees satisfying ALL conditions:

-- ✔ Latest status = Active
-- ✔ Became Inactive at least once
-- ✔ Re-hired exactly once
-- ✔ Never became Inactive again after re-hire



###########################################################
# 🚀 🧠 CASE STUDY 14: Customer Order Behavior Analytics
###########################################################

-- Q1: Find total orders and total spending per customer.

-- Q2: Find customers whose order amount is strictly increasing.

-- Examples:
-- 100 → 120 → 150 ✔
-- 100 → 100 → 150 ❌
-- 100 → 120 → 110 ❌

-- Q3: Find customers whose order amount is strictly decreasing.

-- Examples:
-- 200 → 180 → 160 ✔
-- 200 → 200 → 160 ❌
-- 200 → 180 → 190 ❌

-- Q4: Find customers who placed orders on consecutive days only.

-- Definition:
-- No gaps between any two consecutive orders.

-- Q5: Find customers whose latest order amount
-- is greater than ALL previous order amounts.

-- Examples:
-- 100 → 120 → 150 ✔
-- 100 → 200 → 150 ❌

-- Q6: Find customers who never repeated the same order amount.

-- Examples:
-- 100 → 120 → 150 ✔
-- 100 → 100 → 150 ❌

-- Q7: Find customers satisfying ALL conditions:

-- ✔ At least 3 orders
-- ✔ No gaps between orders
-- ✔ Latest order is highest order
-- ✔ Order amount never decreased
-- ✔ No repeated order amount