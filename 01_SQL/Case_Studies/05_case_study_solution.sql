use de_practice;
###########################################################
# 🚀 🧠 CASE STUDY 9: Ride Sharing + User Behavior Analytics
###########################################################

#Q1: Find total rides and total fare per user
select u.user_name,r.user_id,count(*) as total_rides,
sum(fare) as total_fare 
from rides09 r join users09 u on r.user_id= u.user_id
group by u.user_name,r.user_id ;

#Q2: Find users who took rides on consecutive days
with cte as (select user_id,ride_date,
row_number() over(partition by user_id order by ride_date,ride_id) as rn from rides09),
grp as( select *,date_sub(ride_date,interval rn day) as flag from cte)
select distinct user_id from grp 
group by user_id,flag
having count(*)>1;

#Q3: Find users whose ride distance is strictly increasing:
with cte as(select *,
lag(distance) over (partition by user_id order by ride_date,ride_id)  as prev_ride from rides09)
select user_id
#,(case when prev_ride is not null and distance>prev_ride then 0 else 1 end) as sn 
from cte
group by user_id 
having count(*) > 1 and sum(case when prev_ride is not null and distance<=prev_ride then 1 else 0 end)=0;

#Q4: Find users who skipped at least 1 day between rides
with cte as (select *,
lag(ride_date) over(partition by user_id order by ride_date,ride_id) as prev_date
from rides09)
select distinct user_id from cte where 
prev_date is not null and datediff(ride_date,prev_date)>1;


#Q5: Find users whose latest ride fare > average of previous rides

with cte as (select user_id,fare,
row_number() over (partition by user_id order by ride_date desc,ride_id desc) as rn
from rides09),
#select * from cte;
cte2 as (select user_id,avg(case when rn<>1 then fare end) avr,
count(case when rn<>1 then 1 end) as cnt from cte
group by user_id)
select cte.user_id from cte
join cte2 on cte.user_id=cte2.user_id 
where cte.rn= 1 and cte2.avr<cte.fare and cte2.cnt>0;

#Q6: Find most frequently used payment method per user
with cte as(select r.user_id,p.payment_method,count(*) as cnt from rides09 r join payments09 p
on r.ride_id=p.ride_id
group by r.user_id,p.payment_method),
ranking as (select *,
rank() over (partition by user_id order by cnt desc) as rnk from cte)
select user_id,payment_method from ranking where rnk=1;


#Q7: Find users with consistent ride behavior -At least 3 rides , -Fare never decreases (increasing or equal):
with cte as (select user_id,fare,ride_date,
count(*) over (partition by user_id order by ride_date,ride_id) as cnt,
 lag(fare) over (partition by user_id order by ride_date,ride_id) as prev_fare from rides09)

 select user_id
from cte
group by user_id 
having max(cnt)>=3 and sum(case when  prev_fare is not null and fare<prev_fare then 1 else 0 end) =0;

select * from rides09;

#############################################
#🚀 🧠 CASE STUDY 10: E-Commerce Funnel & Conversion Analytics
############################################

#Q1: Find total number of each event type
select event_type,count(*) as total_no from events10
group by event_type;

#Q2:Find users who performed all 3 actions
select user_id from events10
group by user_id
having count(distinct(event_type))=3;

#Q3: Find users who viewed but never purchased
select user_id
from events10
group by user_id
having
sum(case when event_type='view' then 1 else 0 end) > 0
and
sum(case when event_type='purchase' then 1 else 0 end) = 0;

#Q4: Find conversion rate:
select 
count(distinct case when event_type='purchase' then user_id end) * 1.0
/
count(distinct case when event_type='view' then user_id end) 
as conversion_rate
from events10;

#Q5: Find users whose first event is purchase (suspicious behavior)
select user_id from (select *,
row_number() over (partition by user_id order by event_date,event_id) as rn
from events10)s where rn=1 and event_type='purchase';

#Q6: Find users who added to cart but did not purchase within 1 day
with cart_events as (select user_id,event_date as adate,event_type from events10
where event_type='add_to_cart'),
purchase_events  as (select user_id,event_date  as pdate ,event_type from events10
where event_type='purchase')
select distinct c.user_id
from cart_events c
left join purchase_events p
on c.user_id = p.user_id
and datediff(p.pdate, c.adate) between 0 and 1
where p.user_id is null;


#Q7: Find users who followed correct funnel order:
with funnel as (select user_id,min(case when event_type='view' then event_date end) as view_date,
				min(case when event_type='add_to_cart' then event_date end) as cart_date,
                min(case when event_type='purchase' then event_date end) as purchase_date
from events10
group by user_id
)
select * from funnel
where view_date is not null
  and cart_date is not null
  and purchase_date is not null
  and view_date <= cart_date
  and cart_date <= purchase_date;














