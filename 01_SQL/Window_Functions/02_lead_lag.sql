use de_practice ;
##############
#LEAD & LAG
#############

select * from employees;

#Q1: Show each employee with their previous employee’s salary (same department).
select name,department,
Lag(salary) over(partition by department order by emp_id ) as prev_sal
from employees;

#Q2:Show each employee with next employee’s salary.
select name ,department,
lead(salary,1,0) over (partition by department order by emp_id ) as next_sal
from employees;

#Q3:Find employees whose salary is higher than previous employee in same department.

select * from (select name, department, salary,
lag(salary) over (partition by department order by emp_id) as prev_sal
from employees)s
where s.salary>s.prev_sal;


#Q4:Find employees whose salary is lower than next employee.
select * from (select name,department,salary,
lead(salary) over(partition by department order by emp_id desc) as next_sal
from employees)s
where s.salary<next_sal;


#Q5:Find salary difference between current and previous employee.

select name,department,salary,
salary-lag(salary) over (partition by department order by emp_id desc) as diff
from employees;



