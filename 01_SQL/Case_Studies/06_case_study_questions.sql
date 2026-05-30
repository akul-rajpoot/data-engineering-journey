###########################################################
# 🚀 🧠 CASE STUDY 11: Employee Promotion & Salary Analytics
###########################################################

-- Q1: Find each employee's latest salary.

-- Q2: Find employees whose latest salary is higher than their previous salary.

-- Q3: Find employees who never received a salary increase.
-- Examples:
-- 50000 → 50000 → 50000 ✔
-- 50000 → 45000 → 40000 ✔
-- 50000 → 55000 → 60000 ❌

-- Q4: Find employees whose salary decreased at least once.

-- Example:
-- 42000 → 41000 ✔

-- Q5: Find employees whose salary increased every time.

-- Examples:
-- 50000 → 55000 → 60000 ✔
-- 45000 → 45000 → 50000 ❌
-- (Equal salary is NOT considered an increase)

-- Q6: Find department-wise average of latest salary.

-- Q7: Find employees satisfying ALL conditions:

-- ✔ At least 3 salary records
-- ✔ Salary never decreased
-- ✔ Latest salary > First salary
-- ✔ No salary remained unchanged




###########################################################
# 🚀 🧠 CASE STUDY 12: Customer Subscription Retention Analytics
###########################################################

-- Q1: Find each customer's latest subscription plan.

-- Q2: Find customers who upgraded from Basic to Premium.
-- Note:
-- Customer must actually transition from Basic → Premium.
-- Latest Premium alone is not sufficient.

-- Q3: Find customers who had a gap between subscriptions.
-- Definition:
-- next_start_date > previous_end_date + 1 day

-- Q4: Find customers who were continuously subscribed.
-- Definition:
-- No gaps between any consecutive subscriptions.

-- Q5: Find customers whose plan never changed.

-- Examples:
-- Basic → Basic ✔
-- Premium → Premium ✔
-- Basic → Premium ❌
-- Basic → Premium → Basic ❌

-- Q6: Find customers whose latest plan is Premium
-- AND who never had a gap.

-- Q7: Find customers satisfying ALL conditions:

-- ✔ At least 3 subscriptions
-- ✔ No gaps
-- ✔ Upgraded exactly once
-- ✔ Latest plan = Premium
-- ✔ Never downgraded
