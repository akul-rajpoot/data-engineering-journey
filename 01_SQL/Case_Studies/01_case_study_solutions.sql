use de_practice;

#########################
# Case Studies : Day 1
########################

# case study 1

#Scenario: E-Commerce Orders Analysis

#🎯 Business Goal : Analyze customer behavior and revenue patterns.

#Q1: Find total amount spent by each customer.
with cte as (
select customer_id,sum(amount)  as total_amount
from orders
group by customer_id)
select cus.customer_name,cus.city,cte.total_amount from
customers cus join cte on
cus. customer_id=cte.customer_id;

select cus.customer_name,cus.city,sum(ord.amount)  as total_amount
from customers cus join orders ord on cus.customer_id=ord.customer_id
group by cus.customer_id,cus.customer_name,cus.city;

#Q2 : Find top 3 customers based on total spending.

with cte as (
select cus.customer_name,cus.city,
sum(ord.amount) as total_amount,
rank() over (order by sum(ord.amount) desc) as rnk
from customers cus 
join orders ord 
on cus.customer_id=ord.customer_id
group by cus.customer_id,cus.customer_name,cus.city
)
select * from cte
where rnk <= 3;

#Q3: Find customers who spent more than average spending
WITH CTE AS(
select cus.customer_name,cus.city, sum(ord.amount) as amount
from customers cus join orders ord 
on cus.customer_id=ord.customer_id
group by cus.customer_name,cus.city)
select * from CTE
where amount > (select avg(amount) from CTE);

#Q4: Find each customer’s latest order.
select * from orders;
with cte as(
select ord.customer_id,cus.customer_name,ord.order_date, ord.amount,
Rank() over (partition by ord.customer_id order by ord.order_date desc) as rnk
from orders ord join customers cus 
on ord.customer_id=cus.customer_id)
select * from cte where rnk=1;

#Q5: Find customers who made more than 1 order in a single day.
with cte as (
select customer_id,count(customer_id) as cnt,order_date
from orders 
group by order_date,customer_id
)
select * from customers where customer_id in (select customer_id from cte where cnt>=2);

#Q6: Find running total of spending per customer (order by date).

select ord.customer_id,cus.customer_name,ord.order_date,ord.amount,
sum(amount) over(partition by ord.customer_id order by order_date
ROWS Between unbounded preceding and current row) as run_sum
from orders ord join customers cus on cus.customer_id=ord.customer_id;

#Q7: Find customers whose current order amount is greater than their previous order.

select s.customer_id,cus.customer_name,cus.city 
from (
select customer_id,amount,
LAg(amount) over(partition by customer_id order by order_date) as prev_amount
from orders)s join customers cus on cus.customer_id=s.customer_id
where s.amount>s.prev_amount;


####################
# Case study 2
###################

#🧠 Scenario: Employee Performance Analytics

#Q1: Find average rating per employee.
select p.emp_id,e.name,avg(p.rating) as avg_rat from 
performance p join employees02 e on e.emp_id=p.emp_id
group by p.emp_id,e.name;

#Q2: Find top 2 employees per department based on salary.
select name,salary,department from(select *, 
Rank() over(partition by department order by salary desc ) as rnk
from employees02)s 
where s.rnk<3;

#Q3: Find employees whose latest rating is greater than their previous rating.
select s.emp_id,e.name,s.rating,s.prev_rat from(select *,
lag(rating) over(partition by emp_id order by review_date) as prev_rat from performance)s 
join employees02 e on e.emp_id=s.emp_id
where s.rating>s.prev_rat;

#Q4: Find employees who have never received a rating less than 3.
select e.emp_id, e.name
from employees02 e
join performance p on e.emp_id = p.emp_id
group by e.emp_id, e.name
having min(p.rating) >= 3;


#Q5: Find employees whose average rating is greater than department average rating.
with cte as (select e.emp_id,e.name,e.department,avg(p.rating) as emp_avg from employees02 e 
join performance p on e.emp_id=p.emp_id
group by e.emp_id,e.name,e.department),
cte2 as (select e.department,avg(p.rating) as dept_avg from 
employees02 e join performance p on e.emp_id=p.emp_id
group by e.department )
select  cte.name,cte.department,cte.emp_avg,cte2.dept_avg from cte
join cte2 on cte.department=cte2.department
where cte.emp_avg>cte2.dept_avg;

#Q6: Find running average rating per employee (ordered by date).
select p.emp_id,e.name,p.rating,
avg(rating) over(partition by emp_id order by p.review_date 
rows between unbounded preceding and current row) as avg_emp
from performance p join employees02 e on p.emp_id=e.emp_id;

#Q7: Find employees whose salary is higher than the average salary of their department.
select * from (select name,department,salary,
avg(salary) over (partition by department)  as avg_dep_sal from employees02)s
where s.salary>s.avg_dep_sal;