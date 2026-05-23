###########################################################
#🚀 🧠 CASE STUDY 7: Fraud & Transaction Analytics (Banking)
##########################################################

#Q1: Find total balance per account

select account_id,
sum( case when txn_type='Credit' then amount
		  when txn_type='Debit' then -amount
          end) as balance
from transactions07
group by account_id;

#Q2: Find customers with more than 1 account
select a.customer_id,c.customer_name
from accounts07 a join customers07 c on a.customer_id=c.customer_id
group by a.customer_id,c.customer_name 
having count(*) >1;

#Q3: Find accounts where debit > credit (potential risk)
select account_id
from transactions07
group by account_id
having 
    sum(case when txn_type='Debit' then amount else 0 end) >
    sum(case when txn_type='Credit' then amount else 0 end);

#Q4: Find customers whose total balance is negative
with cte as (
    select a.customer_id,t.account_id,
           sum(case when t.txn_type='Credit' then t.amount
					when t.txn_type='Debit' then -t.amount
           end) as balance
    from transactions07 t
    join accounts07 a 
    on t.account_id = a.account_id
    group by a.customer_id, t.account_id
)
select customer_id
from cte
group by customer_id
having sum(balance) < 0;

#Q5: Accounts where transactions are continuously decreasing
with cte as (
    select account_id,amount,
           lag(amount) over(partition by account_id order by txn_date, txn_id) as prev_amount
    from transactions07
)
select account_id
from cte
group by account_id
having sum(
    case 
        when prev_amount is not null 
             and amount >= prev_amount 
        then 1 else 0 
    end
) = 0;

#Q6: Running balance per account
select account_id,amount,txn_type,
sum(case when txn_type='Credit' then amount 
when txn_type='Debit' then -amount end) over (partition by account_id order by txn_date,txn_id 
				  Rows between unbounded preceding and current row) as run_total from transactions07;

#Q7: Find customers whose latest transaction: is Debit : AND amount > previous transaction
with cte as (select account_id,txn_type,amount,txn_date,
           lag(amount) over(partition by account_id order by txn_date, txn_id) as prev_amount,
           row_number() over(partition by account_id order by txn_date desc, txn_id desc) as rn
    from transactions07
)
select c.customer_name, cte.account_id from cte
join accounts07 a 
on cte.account_id = a.account_id
join customers07 c 
on a.customer_id = c.customer_id
where rn = 1 and txn_type = 'Debit' and amount > prev_amount;

################################################################
#🚀 🧠 CASE STUDY 8: E-Commerce Retention & Behavior Analytics
##############################################################


select * from customers08;
select * from orders08;
select * from order_items08;

#Q1: Find total orders and total spending per customer
select c.customer_name,o.customer_id,count(*) as total_order, sum(o.amount) as total_amount
from orders08 o join customers08 c on c.customer_id=o.customer_id
 group by o.customer_id,c.customer_name;
 
 #Q2: Find customers who placed orders on consecutive days
 with cte as (select *,
 row_number() over(partition by customer_id order by order_date,order_id) as rn 
 from orders08),
 grp as (select *, 
		date_sub(order_date,interval rn day ) as flag from cte)
select distinct customer_id from grp 
group by customer_id,flag having count(*)>1;

#Q3: Find customers whose order amount is strictly decreasing over time
with cte as (select *,
 lag(amount) over(partition by customer_id order by order_date  ,order_id  ) as prev_amount from 
orders08)
select customer_id
from cte group by customer_id
having count(*) > 1
   and sum(
       case 
           when prev_amount is not null 
                and amount >= prev_amount 
           then 1 else 0 
       end
   ) = 0;


#Q4: Find customers who skipped at least 1 day between orders
with cte as (
select * ,lag(order_date) over(partition by customer_id order by order_date,order_id ) as prev_date from 
orders08)
select distinct customer_id from cte where
datediff(order_Date,prev_date) >1 ;

#Q5: Find customers whose latest order amount > average of previous orders
with cte as (select customer_id,amount,
           row_number() over(partition by customer_id order by order_date desc, order_id desc) as rn
    from orders08
),
cte2 as (Select customer_id,
           avg(case when rn <> 1 then amount end) as avg_prev,
           count(case when rn <> 1 then 1 end) as prev_cnt
    from cte
    group by customer_id
)
select c1.customer_id
from cte c1 join cte2 c2 on c1.customer_id = c2.customer_id
where c1.rn = 1 and c2.prev_cnt > 0 and c1.amount > c2.avg_prev;


#Q6: Find running total spending per customer
select customer_id,order_date,amount,
sum(amount) over (partition by customer_id order by order_date ,order_id 
				  Rows between unbounded preceding and current row) as run_total from orders08;

#Q7: Find customers who have consistent buying behavior - Have at least 3 orders,
#AND order amounts never increase (only decreasing or equal):

with cte as (select customer_id,amount,
lag(amount) over(partition by customer_id order by order_id,order_date) as prev_amount,
count(*) over(partition by customer_id) as cnt
from orders08)

select customer_id from cte
group by customer_id
having max(cnt) >= 3 and sum( case when prev_amount is not null and amount > prev_amount then 1 else 0 end) = 0;










