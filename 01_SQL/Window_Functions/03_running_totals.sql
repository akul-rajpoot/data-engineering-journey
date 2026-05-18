##################
#Running Totals
##################

#Q1: Find running total of salary within each department.

select name,department,
sum(salary) over(partition by department order by emp_id) as running_total
from employees;

#Q2: Find cumulative count of employees in each department.
select name,department,
count(*) over(partition by department order by emp_id) as cum_count
from employees;

#Q3: Find running average salary in each department.
select name,department,
avg(salary) over (partition by department order by emp_id) as avg_sal
from employees;

#Q4: Find total salary up to current employee (ordered by emp_id).
select name,salary,
sum(salary) over(order by emp_id ) as total_sal
from employees;

#Q5:Find difference between current running total and previous running total.
select * , running_total-prev_total as diff
from (select *,
LAG(running_total,1,0) over(partition by department order by emp_id) as prev_total
from
(select emp_id,name,department,salary,
sum(salary) over(partition by department order by emp_id) as running_total
from employees)s
)k;

SELECT name, department, salary,
SUM(salary) OVER (
    PARTITION BY department 
    ORDER BY emp_id
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
) as running_tot,
SUM(salary) OVER (
    PARTITION BY department 
    ORDER BY emp_id
    ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING
) AS prev_tot
FROM employees;

#Q6: Find employees where running total exceeds 150000 in their department.
select * from(
select *,
sum(salary) over(partition by department order by emp_id) as running_total
from employees) s
where s.running_total>150000;


#####################
#Moving Average / Rolling Window
#####################

#Q1:Find moving average of last 2 employees’ salary (per department).
select emp_id,name,salary,department,
avg(salary) over (partition by department order by emp_id
Rows between 1 Preceding and current row) as avg_sal
from employees;

#Q2: Find moving sum of last 3 employees
select emp_id,name,salary,department,
sum(salary) over (partition by department order by emp_id
Rows between 2 preceding and current row ) as sum_sal
from employees;

#Q3: Find employees where moving average is greater than 60000.
select * from (select emp_id,name,salary,department,
avg(salary) over (partition by department order by emp_id
rows between 1 preceding and current row) as avg_sal
from employees)s 
where s.avg_sal>60000;

#Q4 :Find difference between current salary and moving average.
select * , salary-avg_sal as diff from(select name,department,salary,
avg(salary) over(partition by department order by emp_id
rows between 1 preceding and current row) as avg_sal
from employees)s;

#Q5: Find employees where current salary is greater than moving average of last 2 employees.
select * from (select name,department,salary,
avg(salary) over(partition by department order by emp_id
rows between 2 preceding and 1 preceding ) as avg_sal
from employees)s where s.salary>avg_sal;

