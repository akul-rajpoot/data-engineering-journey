#RECURSIVE CTE

#Q1:Generate Numbers 1 to 10

with recursive numbers as (
select 1 as num 
union all
select num+1 from numbers where num<10)
select * from numbers;


#Q2: Generate Numbers 1 to 20
with recursive cte as (
select 1 as num 
union all
select num+1 from cte where num<20)
select * from cte;

#Q3:Generate Even Numbers 2 to 20
with recursive cte as (
select 1 as num
union all
select (num+1)from cte where num<=9)
select num*2 from cte;

#Q4:Generate Multiples of 5 up to 50
with recursive cte as(
select 1 as num
union all
select num+1 from cte where num<10)
select num*5 from cte;

#Q5: Generate 10 dates after 2025-01-01
with recursive cte as(
select date('2025-01-01') as dt
union all
select date_add(dt,interval 1 day) from cte where dt<'2025-01-10')
select * from cte;
#------------------------------------------------------------------------#
#Practice question

#Q6: Employee Hierarchy and its place
with recursive cte as (
select emp_id,emp_name,manager_id,1 as level 
from employees_RC
where manager_id is null
union all
select e.emp_id,e.emp_name,e.manager_id,cte.level +1
from employees_RC e
join cte on e.manager_id=cte.emp_id
)
select * from cte;


#Q7: Find all employees under Amit
with recursive cte as (select emp_id,emp_name,manager_id
    from employees_RC where emp_name='Amit'
    union all
    select e.emp_id,
           e.emp_name,
           e.manager_id
    from employees_RC e
    join cte c
      on e.manager_id = c.emp_id
)
select * from cte;

#Q8:Find Reporting Path
with recursive cte as(
select emp_id,emp_name,manager_id,emp_name as path
from employees_RC
where manager_id is null
union all
select e.emp_id,e.emp_name,e.manager_id,CONCAT(path,' -> ',e.emp_name)
from employees_RC e
join cte on e.manager_id=cte.emp_id)
select * from cte;

#Q9:Find Hierarchy Depth
with recursive cte as(
select emp_id,emp_name,manager_id,1 as level
from  employees_RC
where manager_id is null
union all
select e.emp_id,e.emp_name,e.manager_id,level+1
from employees_RC e join cte c
on e.manager_id=c.emp_id)
select max(level)  as depth
from cte;

#Q10: Employees under a specific manager (10 min)

with recursive cte as(
select emp_id,emp_name,manager_id
from employees_RC
where emp_name='Rahul'
union all 
select e.emp_id,e.emp_name,e.manager_id
from employees_RC e join cte c
on e.manager_id=c.emp_id)
select * from cte;



