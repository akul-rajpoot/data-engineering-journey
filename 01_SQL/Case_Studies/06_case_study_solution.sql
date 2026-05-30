###########################################################
# 🚀 🧠 CASE STUDY 11: Employee Promotion & Salary Analytics
###########################################################

#Q1: Find each employee’s latest salary.
with cte as (select emp_id ,effective_date,salary,
row_number() over(partition by emp_id order by effective_date desc) as rn
from salary_history11)
select c.emp_id,e.emp_name,c.salary from cte c 
join employees11 e on e.emp_id=c.emp_id
where c.rn=1;

#Q2:Find employees whose latest salary is higher than their previous salary.
with cte as (select *,
row_number() over(partition by emp_id order by effective_date desc) as rn,
lead(salary) over(partition by emp_id order by effective_date desc) as prev_sal
from salary_history11)
select emp_id,effective_date,salary,prev_sal from cte 
where rn=1 and salary>prev_sal;

#Q3:Find employees who never received a salary increase.
with cte as (select *,lag(salary) over(partition by emp_id order by effective_date) as prev_sal
    from salary_history11
)
select emp_id from cte group by emp_id
having sum(case when prev_sal is not null and salary > prev_sal then 1 else 0 end)=0;


#Q4: Find employees whose salary decreased at least once.
with cte as (select *,
lag(salary) over(partition by emp_id order by effective_date) as prev_sal 
from salary_history11)
select distinct emp_id from cte where salary<prev_sal;

#Q5: Find employees whose salary increased every time.
with cte as (select *,
lag(salary) over(partition by emp_id order by effective_date) as prev_sal 
from salary_history11)
select emp_id from cte 
group by emp_id
having sum(case when prev_sal is not null and salary<=prev_sal then 1 else 0 end)=0;

#Q6: Find department-wise average of latest salary.
with cte as (
select e.emp_id,s.salary,e.department,s.effective_date,
row_number() over(partition by emp_id order by effective_date desc) as rn 
from salary_history11 s join employees11 e on e.emp_id=s.emp_id)
select department,avg(salary) from cte 
where rn=1 
group by department;

#Q7=Find employees satisfying ALL conditions:
#1:At least 3 salary records (sorted)
#2:Salary never decreased (sorted)
#3:Latest salary > first salary 
#4:No salary remained unchanged (sort)

with cte as (select *,
count(*) over(partition by emp_id) as cnt,
lag(salary) over(partition by emp_id order by effective_date) as prev_sal,
first_value(salary) over(partition by emp_id order by effective_date) as first_sal,
first_value(salary) over(partition by emp_id order by effective_date desc) as latest_sal
from salary_history11)

select emp_id from cte
group by emp_id
having max(cnt)>2 
and sum(case when prev_sal is not null and prev_sal>=salary then 1 else 0 end)=0
and max(latest_sal) > max(first_sal);


###########################################################
# 🚀 🧠 CASE STUDY 11: Employee Promotion & Salary Analytics
###########################################################

#Q1: Find each customer’s latest subscription plan.
select customer_id,plan from(select *,
row_number() over(partition by customer_id order by end_date desc,sub_id desc) as rn from subscriptions12)s
where s.rn=1;

#Q2:Find customers who upgraded from Basic to Premium.
with cte as(select *,
lead(plan) over(partition by customer_id order by end_date,sub_id) as next_plan from  subscriptions12)

select customer_id from cte 
group by customer_id 
having sum(case when plan='Basic' and next_plan='Premium' then 1 else 0 end)>=1;

#Q3: Find customers who had a gap between subscriptions.
with cte as(select *,
lag(end_date) over(partition by customer_id order by end_date,sub_id) as prev_end_date from subscriptions12)
select customer_id from cte
group by customer_id
having sum(case when prev_end_date is not null and datediff(start_date,prev_end_date)>1 then 1 else 0 end)>=1; 

#Q4: Find customers who were continuously subscribed.
with cte as(select *,
lag(end_date) over(partition by customer_id order by end_date,sub_id) as prev_end_date from subscriptions12)
select customer_id from cte
group by customer_id
having sum(case when prev_end_date is not null and datediff(start_date,prev_end_date)>1 then 1 else 0 end)=0; 

#Q5: Find customers whose plan never changed.
select customer_id from subscriptions12
group by customer_id 
having count(distinct(plan))=1;

#Q6: Find customers whose latest plan is Premium AND who never had a gap.
with cte as (select *,
lag(end_date) over(partition by customer_id order by end_date,sub_id) as prev_date,
first_value(plan) over(partition by customer_id order by end_date desc,sub_id desc ) as lat_plan
from subscriptions12),
cte2 as(
select customer_id,lat_plan from cte
group by customer_id,lat_plan
having sum(case when prev_date is not null and datediff(start_date,prev_date)>1 then 1 else 0 end)=0)
select customer_id from cte2 where lat_plan='Premium';

#Q7: Find customers satisfying ALL conditions:
#1:✔ At least 3 subscriptions
#2:✔ No gaps
#3:✔ Upgraded exactly once
#4:✔ Latest plan = Premium
#5:✔ Never downgraded

with cte as (select *,
count(*) over(partition by customer_id) as cnt, 
lag(end_date) over(partition by customer_id order by end_date,sub_id) as prev_date,
lag(plan) over(partition by customer_id order by end_date,sub_id) as prev_plan,
first_value(plan) over(partition by customer_id order by end_date desc,sub_id desc ) as lat_plan
from subscriptions12)
select customer_id
from cte
group by customer_id
having max(cnt)>2 and
sum(case when prev_date is not null and datediff(start_date,prev_date)>1 then 1 else 0 end)=0 and
sum(case when prev_plan is not null and prev_plan='Basic' and plan='Premium' then 1 else 0 end)=1 and
sum(case when prev_plan='Premium' and plan='Basic' then 1 else 0 end)=0 and
max(case when lat_plan='Premium' then 1 else 0 end)=1










