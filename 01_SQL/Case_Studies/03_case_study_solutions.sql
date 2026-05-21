########################################################
#🚀 🧠 CASE STUDY 1: Ride Sharing Analytics (Uber/Ola)
#######################################################
use de_practice;
#Q1 :Find total rides and total fare per user
select user_id,count(*) as total_ride ,sum(fare) as total_fare
from rides03 group by user_id;

#Q2: Find top 2 users based on total spending
select * from (select user_id,sum(fare) total,
rank() over (order by sum(fare) desc) as rnk
from rides03 group by user_id)s where s.rnk<3;


with cte as (
    select user_id,sum(fare) as total_fare
    from rides03 group by user_id
)
select *,rank() over(order by total_fare desc) as rnk
from cte where rnk <= 2;

#Q3: Users who took rides on consecutive days
with cte as 
(select user_id,ride_date,
row_number() over (partition by user_id order by ride_date) as rn
from rides03
),
grp as (
    select *,
           date_sub(ride_date, interval rn day) as grp_id
    from cte
)
select user_id
from grp
group by user_id, grp_id
having count(*) > 1;

#Q4: Most frequent payment method per user
select * from users03;
select * from rides03;
select * from payments03;

with cte as (select r.user_id,p.payment_method ,count(*) as cnt from rides03 r join
payments03 p on r.ride_id=p.ride_id
group by r.user_id,p.payment_method),
ranked as (
    select *,rank() over(partition by user_id order by cnt desc) as rnk
    from cte
)
select user_id, payment_method
from ranked
where rnk = 1;

#Q5: Users whose current ride fare > previous ride
select user_id from (select user_id,fare,ride_date,
lag(fare) over(partition by user_id order by ride_date) as prev_amount 
from rides03)s where s.prev_amount is not null and s.fare>s.prev_amount;

 #Q6: Running total fare per user
 select ride_id,user_id,fare,
 sum(fare) over (partition by user_id order by ride_date, ride_id) as run
 from rides03;
 
 
 ####################
 #🚀 🧠 CASE STUDY 2: Subscription & Revenue Analytics
 ###############

#Q1: Find total revenue per user
select user_id,sum(amount) as total_revenue
from payments_details03 group by user_id;

#Q2: Find users who upgraded their plan (Basic → Premium)
select distinct user_id from (select *,
lag(plan) over(partition by user_id order by start_date) as prev_plan
from subscriptions03)s where s.plan='Premium' and s.prev_plan='Basic' ;

#Q3: Users who had gaps between subscriptions
with cte as (select user_id,start_date,end_date,
lead(start_date) over(partition by user_id order by start_date) as sub_start
from subscriptions03)
select distinct user_id from cte where sub_start is not null and
datediff(sub_start,end_date)>1;

#Q4: Latest subscription per user
select user_id,plan from (select user_id,plan,
row_number() over(partition by user_id order by start_date desc,sub_id desc) as rn from subscriptions03)s
where s.rn=1;

#Q5: give username,id of users whose payment increased compared to previous payment
select distinct s.user_id,u.user_name from (select *,
lag(amount) over(partition by user_id order by payment_date) as prev_payment from payments_details03)s
join user_details03 u on s.user_id=u.user_id
where s.prev_payment is not null and s.prev_payment<amount ;

#Q6: Running total revenue per user
select user_id,amount,
sum(amount) over(partition by user_id order by payment_date) as run_total from payments_details03;

#Q7: Users who were continuously subscribed (no gaps)
with cte as (select user_id,start_date,
             lag(end_date) over(partition by user_id order by start_date, sub_id) as prev_end
             from subscriptions03)
select user_id from cte group by user_id
having sum(case 
			when prev_end is not null 
            and datediff(start_date, prev_end) > 0 
        then 1 else 0 end) = 0;

