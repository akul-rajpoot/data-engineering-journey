use de_practice;

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










