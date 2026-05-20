#Day2

#🚀 🧠 Case Study 1: Sales & Orders Analytics


#Q1: Find total revenue per product.
select p.product_name,sum(oi.quantity*p.price) as total
from order_items02 oi join products02 p
on oi.product_id=p.product_id
group by p.product_name;

#Q2: Find top 2 highest selling products based on quantity.
select oi.product_id,sum(quantity) as total from order_items02 oi
group by oi.product_id order by total  desc limit 2;

with cte as (
    select p.product_name,
           sum(oi.quantity) as total_qty,
           rank() over(order by sum(oi.quantity) desc) as rnk
    from order_items02 oi
    join products02 p 
    on oi.product_id = p.product_id
    group by p.product_name
)
select * from cte where rnk <= 2;

# Q3: Customers who purchased more than 2 different products
select o.customer_id
from orders02 o
join order_items02 oi 
on o.order_id = oi.order_id
group by o.customer_id
having count(distinct oi.product_id) > 2;

# Q4: Most recent order per customer
select customer_id,order_date from (select o.customer_id,o.order_date,
row_number() over(partition by customer_id order by order_date desc) as ordering
from orders02 o) s where s.ordering=1;

#Q5: Products that were never ordered

select p.product_name from products02 p
where p.product_id not in (select distinct product_id from order_items02);

select p.product_name
from products02 p
left join order_items02 oi
on p.product_id = oi.product_id
where oi.product_id is null;

#Q6: Total revenue per customer
select o.customer_id,sum(oi.quantity*p.price) as total_revenue from orders02 o join
order_items02 oi  on o.order_id=oi.order_id
join products02 p on oi.product_id=p.product_id
group by customer_id
;

#Q7: Customers whose current order amount > previous order amount
select *
from (
    select o.customer_id,o.order_date,sum(oi.quantity * p.price) as total_rev,
	lag(sum(oi.quantity * p.price)) over(partition by o.customer_id order by o.order_date) as prev_order
    from orders02 o
    join order_items02 oi on o.order_id = oi.order_id
    join products02 p on oi.product_id = p.product_id
    group by o.order_id, o.customer_id, o.order_date
) s
where total_rev > prev_order;


#####################################################
#🚀 🧠 Case Study 2: Banking Transactions Analytics
####################################################

#Q1: Find total balance per customer
select c.customer_id,c.customer_name,
sum(case 
		when txn.txn_type='Credit' then txn.amount
		when txn.txn_type='Debit' then -txn.amount
        end ) as balance
from customers02 c join accounts02 a on c.customer_id=a.customer_id
join transactions02 txn on txn.account_id=a.account_id
group by c.customer_id,c.customer_name;
    

#Q2: Find total transactions per account
select account_id,count(txn_id) as total
from transactions02
group by account_id;

#Q3: Customers having more than 1 account

select c.customer_id,c.customer_name
from customers02 c join accounts02 a on 
c.customer_id=a.customer_id 
group by c.customer_id,c.customer_name
having count(a.account_id)>1;

#Q4: Latest transaction per account
select * from customers02;
select * from accounts02;

select * from (select account_id,txn_date,
row_number() over(partition by account_id order by txn_date desc) as num
from transactions02)s where s.num=1;

#Q5: Accounts where balance is negative
select account_id,
sum(case 
        when txn_type='Credit' then amount
        when txn_type='Debit' then -amount
        end) as balance
from transactions02
group by account_id 
having balance<0;

# Q6: Running balance per account (ordered by date)
select account_id,amount,txn_type,txn_date,
sum(case 
        when txn_type='Credit' then amount
        when txn_type='Debit' then -amount
        end) over(partition by account_id order by txn_date
        Rows between unbounded preceding  and current row) as balance
from transactions02;

#Q7: Customers whose current transaction > previous transaction
select *
from (
    select a.customer_id,
           t.txn_date,
           t.amount,
           lag(t.amount) over(
               partition by a.customer_id 
               order by t.txn_date
           ) as prev_txn
    from transactions02 t
    join accounts02 a 
    on t.account_id = a.account_id
) s
where prev_txn is not null
  and amount > prev_txn;

