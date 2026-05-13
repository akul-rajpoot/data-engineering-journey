-- =========================
--  GROUP BY + AGGREGATIONS
-- =========================
use de_practice;

select * from employees;
-- Q1: Count total employees
select count(*) from employees;

-- Q2: Count employees per department
select count(*) as cnt, department
from employees group by department;

-- Q3: Total salary per department
select sum(salary) as sal , department from employees
group by department;


-- Q4: Average salary per department
select avg(salary) sal , department from employees
group by department;


-- Q5: Highest salary in each department
select max(salary) as salary, department from employees
group by department;

-- Q6: Lowest salary in each department
select min(salary) as salary , department from employees
group by department;

-- Q7: Average salary by city
select avg(salary) as salary,city from employees
group by city;

-- Q8: Count employees by city
select city,count(*) as cnt from employees
group by city;

-- Q9: Using ROUND()
select round(avg(salary),2) as rounded_sal,department
from employees
group by department;

-- Q10 using IFNULL
select Name,IFNULL(salary,0)
from employees;

-- Q11 COALESCE 
SELECT name, COALESCE(salary, 0) AS salary
FROM employees;

SELECT name, COALESCE(city, department, 'Unknown') AS location
FROM employees;

SELECT 
    name,
    ROUND(COALESCE(salary, 0), 0) AS final_salary
FROM employees;

-- Q12 Find departments having less than 2 employees.
select department from employees
group by department
having count(*)<2;

-- Q13 Find cities where more than 3 employee exists.
select city from employees
group by city
having count(*)>3;

-- Q14 Find departments where average salary is greater than 60000
select department
from employees
group by department
having avg(salary)>60000;











