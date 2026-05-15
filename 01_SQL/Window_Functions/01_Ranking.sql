##################
#  Window Function
##################

#Q1:Assign row number to employees within each department.
select *,
row_number() over(partition by department order by salary desc) as un
from employees;

#Q2:Rank employees based on salary within each department.
select *,
rank() over (partition by department order by salary desc) as rnk
from employees;

#Q3:Find top 2 highest paid employees in each department.
select * from (select *,
rank() over (partition by department order by salary desc) as rnk
from employees) s  where s.rnk<3;

#Q4:Find employees with highest salary in each department (using window function).
select * from (
select *,
Rank() over(partition by department order by salary desc) as rnk 
 from employees )s where s.rnk =1;
 
#Q5:Find employees whose salary is in top 3 in their department.
select * from (select * ,
Rank() over (Partition by department order by salary desc) as rnk
from employees)s
where s.rnk <4;

