#########################################################
# 🚀 🧠 CASE STUDY 13: Employee Retention & Attrition Analytics
##########################################################

use de_practice;

select * from employees13;
select * from employment_history13;

#Q1:Find each employee’s latest status
select emp_id,status as latest_status from (
select *,
row_number() over(partition by emp_id order by status_date desc,record_id desc) as rn from 
employment_history13)s
where s.rn=1;

#Q2: Find employees who are currently Active.
select emp_id,status as latest_status from (
select *,
row_number() over(partition by emp_id order by status_date desc,record_id desc) as rn from 
employment_history13)s
where s.rn=1 and status='Active';

#Q3:Find employees who became Inactive at least once.
select emp_id
from employment_history13
group by emp_id
having sum(
    case
        when status='Inactive'
        then 1
        else 0
    end
) > 0;

#Q4:Find employees who were re-hired.
select distinct emp_id from (select *,
lag(status) over(partition by emp_id order by status_date,record_id) as prev_status
from employment_history13)s
where s.status='Active' and s.prev_status='Inactive';

#Q5:Find employees who are currently Active but were Inactive in the past.
select emp_id from (select *,
row_number() over(partition by emp_id order by status_date desc,record_id desc) as rn from 
employment_history13)s
group by emp_id
having sum(case when rn=1 and status='Active' then 1 else 0 end)=1 and 
count(distinct(status))=2;

#Q6: Find employees whose status changed exactly once.
with cte as (select *,
lag(status) over(partition by emp_id order by status_date ,record_id) as prev_status from 
employment_history13)
select emp_id from cte
group by emp_id
having sum(case when prev_status is not null and  status<>prev_status then 1 else 0 end)=1;

/*Q7: Find employees satisfying ALL conditions:
✔ Latest status = Active
✔ Became Inactive at least once
✔ Re-hired exactly once
✔ Never became Inactive again after re-hire */

with cte as(select *,
row_number() over(partition by emp_id order by status_date desc,record_id desc) as rn,
lag(status)  over(partition by emp_id order by status_date,record_id) as prev_status
from employment_history13)

select emp_id from cte
group by emp_id
having sum(case when rn=1 and status='Active' then 1 else 0 end)=1 and
sum(case when status='Inactive' then 1 else 0 end)>=1
and sum(case when status='Active' and prev_status = 'Inactive' then 1 else 0 end)=1 and
sum(case when status='Inactive' and prev_status = 'Active' then 1 else 0 end)=1 ;


###########################################################
#🚀 🧠 CASE STUDY 14: Customer Order Behavior Analytics
###########################################################

select * from customers14;
select * from orders14;

#Q1:Find total orders and total spending per customer.
select c.customer_name,o.customer_id,count(*) as total_order,sum(amount) as total_spending
from orders14 o join customers14 c on c.customer_id=o.customer_id
group by 1,2;

#Q2:Find customers whose order amount is strictly increasing.
select c.customer_id,c.customer_name from (select *,
lag(amount) over(partition by customer_id order by order_date) as prev_am from orders14)s
join customers14 c on c.customer_id=s.customer_id
group by c.customer_id,c.customer_name 
having sum(case when prev_am is not null and prev_am >=amount then 1 else 0 end )=0;

#Q3: Find customers whose order amount is strictly decreasing.
select c.customer_id,c.customer_name from (select *,
lag(amount) over(partition by customer_id order by order_date) as prev_am from orders14)s
join customers14 c on c.customer_id=s.customer_id
group by c.customer_id,c.customer_name 
having sum(case when prev_am is not null and prev_am <=amount then 1 else 0 end )=0;

#Q4:Find customers who placed orders on consecutive days only.
with cte as(select customer_id,
date_sub(order_date,interval (row_number() over(partition by customer_id order by order_date)) day) as rn
from orders14)
#select * from cte;
select c.customer_id,c1.customer_name from cte c join customers14 c1
on c.customer_id=c1.customer_id
group by c.customer_id,c1.customer_name
having count(distinct(rn))=1 ;

#Q5:Find customers whose latest order amount is greater than all previous orders.
with cte as (
    select customer_id,
           amount,
           row_number() over(
               partition by customer_id
               order by order_date desc, order_id desc
           ) as rn
    from orders14
),
cte2 as (
    select customer_id,
           max(case when rn <> 1 then amount end) as max_prev,
           count(case when rn <> 1 then 1 end) as prev_cnt
    from cte
    group by customer_id
)
select c.customer_id
from cte c
join cte2 p
on c.customer_id = p.customer_id
where c.rn = 1
  and p.prev_cnt > 0
  and c.amount > p.max_prev;

#Q6:Find customers who never repeated the same order amount.
select customer_id
from orders14
group by customer_id
having count(*) = count(distinct amount);

#Q7:Find customers satisfying ALL conditions:
#✔ At least 3 orders
#✔ No gaps between orders
#✔ Latest order is highest order
#✔ Order amount never decreased
#✔ No repeated order amount
with base as (
    select *,
           count(*) over(partition by customer_id) as cnt,

           lag(amount) over(
               partition by customer_id
               order by order_date,order_id
           ) as prev_amount,

           row_number() over(
               partition by customer_id
               order by order_date,order_id
           ) as rn_asc,

           row_number() over(
               partition by customer_id
               order by order_date desc,order_id desc
           ) as rn_desc
    from orders14
),
grp as (
    select *,
           date_sub(order_date, interval rn_asc day) as island
    from base
),
latest_prev as (
    select customer_id,
           max(case when rn_desc <> 1 then amount end) as max_prev
    from grp
    group by customer_id
)

select g.customer_id
from grp g
join latest_prev lp
on g.customer_id = lp.customer_id
group by g.customer_id
having

-- At least 3 orders
max(cnt) >= 3

-- No gaps
and count(distinct island) = 1

-- Latest order is highest order
and max(
        case
            when rn_desc = 1
             and amount > lp.max_prev
            then 1
            else 0
        end
    ) = 1

-- Order amount never decreased
and sum(
        case
            when prev_amount is not null
             and amount < prev_amount
            then 1
            else 0
        end
    ) = 0

-- No repeated order amount
and count(*) = count(distinct amount);





