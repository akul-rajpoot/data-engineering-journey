####################
#.   CTE
###################

#Q1: Find employees whose salary is greater than average salary of their department using CTE
with average as (select department,avg(salary) as avg_salary from employees
group by department)
select e.emp_id,e.name,e.salary,e.department,a.avg_salary from employees e join average a
on e.department=a.department
where e.salary>a.avg_salary;

with CTE as (select *,
avg(salary) over(partition by department) as avg_sal
from employees)
select * from CTE
where salary>avg_sal order by emp_id;

#Q2: Find top 2 highest paid employees per department using CTE.
with ranking as (select name,salary,department,
rank() over (partition by department order by salary desc) as rnk
from employees)
select * from ranking where rnk<3;

#Q3: Find departments where average salary is greater than overall average salary.
with avg_per_dept as(
select department,
avg(salary) as  average_sal
from employees
group by department),
tot_avg as(
select avg(salary) as total from employees)
select department from avg_per_dept 
where average_sal >(select total from tot_avg) ;

#Q4:Find employees who earn more than overall average salary.

with total_avg as (
select avg(salary) as total from employees
)
select name,department,salary
from employees 
where salary>(select total from total_avg);

#Q5: Find employees whose salary is greater than average salary of their city.
with city_avg as (select city,avg(salary) as average
from employees 
group by city)
select name,department,salary
from employees e join city_avg c
on e.city=c.city
where e.salary>c.average;

with avg_city_sal as (select *,
AVG(salary) over (partition by city) as avg_salary
from employees)
select * from avg_city_sal
where salary>avg_salary;


