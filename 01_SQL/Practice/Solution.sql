use Practice;

#Calculates the difference between the highest salaries in the marketing and engineering departments. 
#Output just the absolute difference in salaries.

SELECT ABS(
    MAX(CASE WHEN d.department = 'Engineering' THEN em.salary END) -
    MAX(CASE WHEN d.department = 'Marketing' THEN em.salary END)
) AS salary_difference
FROM db_employee em
JOIN db_dept d 
ON d.id = em.department_id;

/*Find the total cost of each customer's orders. Output customer's id, first name, and the total order cost. 
Order records by customer's first name alphabetically.*/

select c.id,c.first_name,sum(o.total_order_cost)
from customers c
join orders o on o.cust_id=c.id
group by c.id;

/*Management wants to analyze only employees with official job titles. Find the job titles of the employees with the 
highest salary. If multiple employees have the same highest salary, include all their job titles.*/
SELECT DISTINCT t.worker_title
FROM worker w
JOIN title t 
ON w.worker_id = t.worker_ref_id
WHERE t.worker_title IS NOT NULL
AND t.worker_title <> ''
AND w.salary = (
    SELECT MAX(w2.salary)
    FROM worker w2
    JOIN title t2 
    ON w2.worker_id = t2.worker_ref_id
    WHERE t2.worker_title IS NOT NULL
    AND t2.worker_title <> ''
);

/*Find all posts which were reacted to with a heart. For such posts output all columns from facebook_posts table.*/
select distinct fp.post_id,fp.poster,fp.post_date,fp.post_text,fp.post_keywords from facebook_posts fp
join facebook_reactions fr on fp.post_id=fr.post_id
where fr.reaction='heart';

/*Find all the users who were active for 3 consecutive days or more.*/
with cte as(
select user_id,record_date,
row_number() over(partition by user_id order by record_date) as rn
from sf_events),
grp as (
select user_id,record_date,rn,
date_sub(record_date, interval rn day) as grp_id
from cte
)
select user_id
from grp
group by user_id, grp_id
having count(*) >= 3;

with cte as (
select user_id,record_date,
lag(record_date) over(partition by user_id order by record_date) as prev_date
from sf_events
),
grp as (select *,
       case 
			when datediff(record_date, prev_date) = 1 then 0
            else 1
            end as flag
            from cte),
grp_id as ( select *,
sum(flag) over(partition by user_id order by record_date) as grp
from grp
)
select user_id
from grp_id
group by user_id, grp
having count(*) >= 3;

## Find all numbers that appear at least three times consecutively.
with cte as(select num,
lag(num) over(order by id) as prev_num,
lead(num) over(order by id) as next_num
from logs)
select distinct num from cte
where num=prev_num and prev_num=next_num;


##Q7: Write a solution to find the employees who are high earners in each of the departments.
with cte as(select e.name as Employee ,d.name as Department,salary,
dense_rank() over(partition by e.departmentId order by e.salary desc) as rnk from Employee07 e join department07 d
on e.departmentId=d.id)
select employee,department,salary from cte where rnk <=3;



/* Q8 :The cancellation rate is computed by dividing the number of canceled (by client or driver) requests 
with unbanned usersby the total number of requests with unbanned users on that day.
Write a solution to find the cancellation rate of requests with unbanned users (both client and driver must not be banned)
 each day between "2013-10-01" and "2013-10-03" with at least one trip. Round Cancellation Rate to two decimal points.*/

select * from users08;
select * from Trips08;

with cte as (
select t.status,t.request_at,c.banned as cl_banned,d.banned as driver_banned from trips08 t
join users08 c on t.client_id=c.users_id
 join users08 d on t.driver_id=d.users_id )
 select request_at as Day,
 round(1.0*sum(case when cl_banned='No' and driver_banned='No' and status like 'cancelled%'then 1 else 0 end )/
 sum(case when cl_banned='No' and driver_banned='No' then 1 else 0 end),2) as 'Cancellation Rate'
from cte 
group by request_at ;

select request_at as Day,
round(1.0  * sum(case when status <> 'completed' then 1 else 0 end )/ count(*),2) as 'Cancellation Rate'
from Trips08 t join users08 c on t.client_id=c.users_id
join users08 d on t.driver_id=d.users_id
where c.banned='No' and d.banned='No' and t.request_at between '2013-10-01' and '2013-10-03'
group by request_at
order by request_at;

/*Q9:Write a solution to display the records with three or more rows with consecutive id's,and the number of people 
is greater than or equal to 100 for each.*/	
WITH cte AS (
    SELECT *,
           id - ROW_NUMBER() OVER(ORDER BY id) AS grp
    FROM stadium09
    WHERE people >= 100
)
SELECT id, visit_date, people
FROM cte
WHERE grp IN (
    SELECT grp
    FROM cte
    GROUP BY grp
    HAVING COUNT(*) >= 3
)
ORDER BY visit_date;

#Q10:Write a solution to find the people who have the most friends and the most friends number

with cte as(
select requester_id as id from RequestAccepted10
union all
select accepter_id  as id
from RequestAccepted10)
SELECT id, COUNT(*) AS num
FROM cte
GROUP BY id
ORDER BY num DESC
LIMIT 1;



#Q11:Write a solution to report the name and balance of users with a balance higher than 10000. 
#The balance of an account is equal to the sum of the amounts of all transactions involving that account.

select u.name,t.account,sum(t.amount) from transactions11 t
join users11 u on t.account=u.account
group by u.name,t.account
having sum(t.amount)>10000;

#Q12: Write a solution to calculate the total time in minutes spent by each employee on each day at the office.
select emp_id,event_day as day ,sum(out_time-in_time) as total_time
from Employees
group by emp_id,event_day
order by event_day;

#Q13: Write a solution to report the latest login for all users in the year 2020. 
#Do not include the users who did not login in 2020.

select user_id,time_stamp as last_time from(select user_id,time_stamp,
row_number() over (partition by user_id order by time_stamp desc) as rn
from logins13
where Year(time_stamp)=2020)s where s.rn=1;

 
/*Q:14
Write a solution to find all the valid email addresses. A valid email address meets the following criteria:
It contains exactly one @ symbol.
It ends with .com.
The part before the @ symbol contains only alphanumeric characters and underscores.
The part after the @ symbol and before .com contains a domain name that contains only letters.
*/

SELECT * 
FROM users14
WHERE REGEXP_LIKE(email, '^[A-Za-z0-9_]+@[A-Za-z]+\.com$');
;


/*Q15: There is a queue of people waiting to board a bus. However, the bus has a weight limit of 1000 kilograms, 
so there may be some people who cannot board.
Write a solution to find the person_name of the last person that can fit on the bus without exceeding the weight limit. 
The test cases are generated such that the first person does not exceed the weight limit.*/

with cte as (select person_name,weight,turn,
sum(weight) over(order by turn) as run_sum from queue15)
select person_name from cte
where run_sum <=1000
order by turn desc 
limit 1;

/*Q16:Write a solution to find all products whose description contains a valid serial number pattern. A valid serial number follows these rules:
It starts with the letters SN (case-sensitive).
Followed by exactly 4 digits.
It must have a hyphen (-) followed by exactly 4 digits.
The serial number must be within the description (it may not necessarily start at the beginning).*/

SELECT *
FROM products where
REGEXP_LIKE(
    description,
    '(^|[^A-Za-z0-9])SN[0-9]{4}-[0-9]{4}([^A-Za-z0-9]|$)',
    'c'
)
order by product_id;


/*Q17:Write a solution to find the sum of amounts for odd and even transactions (amounts) for each day. If there are no odd or even 
transactions for a specific date, display as 0.*/

select transaction_date,
sum(case when amount%2!=0 then amount else 0 end) as odd_sum,
sum(case when amount%2=0 then amount else 0 end) as even_sum
from transactions
group by transaction_date
order by transaction_date ;


/*Q18: Write a solution to find the students who have shown improvement. A student is considered to have shown 
improvement if they meet both of these conditions:
Have taken exams in the same subject on at least two different dates
Their latest score in that subject is higher than their first score
*/
with student as(
select *,
First_value(exam_date) over(partition by student_id,subject ORDER BY exam_date) as first_date,
LAST_VALUE(exam_date) over(partition by student_id,subject ORDER BY exam_date ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as last_date,
First_value(score) over(partition by student_id,subject) as first_score,
LAST_VALUE(score) over(partition by student_id,subject) as latest_score,
count(*) over(partition by student_id,subject) as cnt
from scores18)
select distinct student_id,subject,first_score,latest_score 
from student
where first_date!=last_date 
and first_score<latest_score  and cnt>1; 

with cte as (select * ,
row_number() over(partition by student_id,subject ORDER BY exam_date)  as first_date,
row_number() over(partition by student_id,subject ORDER BY exam_date desc) as latest_date,
count(*) over(partition by student_id,subject) as cnt
from scores18)
select c1.student_id,c1.score as prev_score,c2.score as current_score,c1.subject from cte c1
join cte c2 on c1.first_date=c2.latest_date and c1.subject=c2.subject and c1.student_id=c2.student_id
where  c1.first_date =1
and c2.score>c1.score and c2.cnt>1;

#Q19:Write a solution to report the Capital gain/loss for each stock.

select stock_name,
sum(case when operation='Buy' then -price else +price end) as capital_gain_loss 
from stocks19
group by stock_name ;

/*Q20:Write a solution to:
Find users who converted from free trial to paid subscription
Calculate each user's average daily activity duration during their free trial period (rounded to 2 decimal places)
Calculate each user's average daily activity duration during their paid subscription period (rounded to 2 decimal places)
Return the result table ordered by user_id in ascending order.
The result format is in the following example.
*/
select user_id,
round(avg(case when activity_type='free_trial' then activity_duration end),2) as trial_avg_duration,
round(avg(case when activity_type='paid' then activity_duration end),2) as paid_avg_duration
from UserActivity20
group by user_id
having SUM(activity_type='free_trial') > 0
AND
SUM(activity_type='paid') > 0;



with cte as(
select user_id,activity_type,round(avg(activity_duration),2) as average
from UserActivity20
group by user_id ,activity_type),
cte2 as(
select *,
lag(activity_type) over(partition by user_id order by user_id,activity_type) as activity,
lag(average) over(partition by user_id order by user_id) as trial_avg_duration
from cte )
select user_id,trial_avg_duration, average as  paid_avg_duration
from cte2
where activity_type='paid' and activity='free_trial';


/*Q21:Write a solution to find all books that are currently borrowed (not returned) and have zero copies available
 in the library.A book is considered currently borrowed if there exists a borrowing record with a NULL return_date*/
select * from library_books21;
with cte as (
select book_id,count(*) as b_count
from borrowing_records21
where return_date is null
group by book_id)
select lb.book_id,lb.title,lb.author,lb.genre,lb.publication_year,cte.b_count as current_borrowers
from library_books21 lb join cte on cte.book_id=lb.book_id
where lb.total_copies-b_count=0;	
 
 
/*Q22: Write a solution to analyze AI prompt usage patterns based on the following requirements:
Only include users who have submitted at least 3 prompts.
Only include users who have submitted at least one prompt with tokens greater than their own average token usage.
*/

select user_id,count(*) as prompt_count,avg(tokens) as avg_tokens
from prompts22
group by user_id
having count(*)>=3 and avg(tokens)<max(tokens)
order by avg(tokens) desc ;

/*Q23:Identify distinct product pairs frequently purchased together by the same customers (where product1_id < product2_id)
For each product pair, determine how many customers purchased both products
A product pair is considered for recommendation if at least 3 different customers have purchased both products.*/

select pb1.product_id as product1_id,pb2.product_id as product2_id,
pi1.category as product1_category,
pi2.category as product2_category,
count(*) as customer_count
from ProductPurchases23 pb1
join ProductPurchases23 pb2 on pb1.user_id=pb2.user_id
left join ProductInfo23 pi1 on pb1.product_id=pi1.product_id
left join ProductInfo23 pi2 on pb2.product_id=pi2.product_id
where pb1.product_id<pb2.product_id
group by pb1.product_id ,pb2.product_id,pi1.category, pi2.category
having count(*)>2
order by count(*) desc,pb1.product_id ,pb2.product_id;

/*Q24: Write a solution to identify emotionally consistent users based on the following requirements:
For each user, count the total number of reactions they have given.
Only include users who have reacted to at least 5 different content items.
A user is considered emotionally consistent if at least 60% of their reactions are of the same type.
*/
with cte1 as(
select user_id,reaction,count(reaction) as reac_count
from reactions24
group by user_id,reaction),
cte2 as (
select user_id,count(*) as user_count
from reactions24
group by user_id
having COUNT(DISTINCT content_id)>4
)
select cte1.user_id,cte1.reaction,round(reac_count*1.0/user_count,2) as average
from cte1
join cte2 on cte1.user_id=cte2.user_id
where reac_count/user_count>=0.6;

with cte as (
    select user_id,reaction,count(*) as reaction_count,
    sum(count(*)) over (partition by user_id) as total_count
    from reactions24
    group by user_id, reaction
)
select user_id,reaction as dominant_reaction ,round(
    reaction_count/total_count
    ,2) as reaction_ratio from cte
    where total_count > 4  and round(reaction_count/total_count,2) >= 0.6
    order by reaction_ratio desc, user_id;
    
    
/*Q25:Write a solution to find employees who have consistently improved their performance over their last three reviews.
An employee must have at least 3 review to be considered -----sorted
The employee's last 3 reviews must show strictly increasing ratings (each review better than the previous)
Use the most recent 3 reviews based on review_date for each employee
Calculate the improvement score as the difference between the latest rating and the earliest rating among the last 3 reviews
*/


with cte as (select *,
row_number() over(partition by employee_id order by review_date desc,review_id desc) as rn,
count(*) over(partition by employee_id) as cnt,
lag(rating) over(partition by employee_id order by review_date desc,review_id desc) as prev_rating
from performance_reviews25)

select e.employee_id,e.name,sum(case when rn=1 then +rating when rn=3 then -rating else 0 end) as improvement_score
from cte join employees25 e on e.employee_id=cte.employee_id
where cnt>=3 and rn<=3
group by e.employee_id,e.name
having sum(case when prev_rating is not null and prev_rating>rating then 1 else 0 end)=2
order by sum(case when rn=1 then +rating when rn=3 then -rating else 0 end) desc;

/*Q26: find golden hour customers 
Made at least 3 orders.
At least 60% of their orders are during peak hours (11:00-14:00 or 18:00-21:00).
Their average rating for rated orders is at least 4.0, round it to 2 decimal places.
Have rated at least 50% of their orders.*/

with cte as (select *,
count(*) over(partition by customer_id) as cnt,
(case WHEN CAST(order_timestamp  AS TIME) BETWEEN '11:00:00' AND '14:00:00' THEN 1
when CAST(order_timestamp  AS TIME) BETWEEN '18:00:00' AND '21:00:00' THEN 1 else 0 end) as peak_check,
round(avg(order_rating) over(partition by customer_id),2) as average
from restaurant_orders26)
select customer_id,cnt as total_orders,round((sum(peak_check)/max(cnt))*100,0) as peak_hour_percentage,
max(average) as average_rating
from cte 
group by
customer_id,cnt
having cnt>=3 and (sum(peak_check)/max(cnt))*100>=60 
and (sum(case when order_rating is not null then 1 else 0 end )/max(cnt))>=0.5
and MAX(average) >= 4;

select customer_id,count(customer_id) as total_orders,round(sum(case when hour(order_timestamp) between 11 and 13 or hour(order_timestamp) between 18 and 20 then 1 else 0 end)*100/count(customer_id),0) as peak_hour_percentage,round(avg(order_rating),2) as average_rating 
from restaurant_orders
group by customer_id
having count(customer_id)>=3 and 
peak_hour_percentage >= 60 and average_rating >=4 
and count(order_rating)/count(customer_id)>=0.5
order by average_rating desc,customer_id desc;

#Q27:Write a solution to find loyal customers
#-Made at least 3 purchase transactions.
#-Have been active for at least 30 days.
#-Their refund rate is less than 20%
select * from customer_transactions27;

select customer_id
from customer_transactions27
group by customer_id
having COUNT(CASE WHEN transaction_type='purchase' THEN 1 END)>=3 and 
(count(case when transaction_type='refund' then 1 end)/count(customer_id))<0.2 
and DATEDIFF(MAX(transaction_date), Min(transaction_date)) >= 30;

/*Q28:Write a solution to find the most popular product category for each season. The seasons are defined as:
Winter: December, January, February
Spring: March, April, May
Summer: June, July, August
Fall: September, October, November
The popularity of a category is determined by the total quantity sold in that season. If there is a tie, 
select the category with the highest total revenue (quantity × price). If there is still a tie, 
return the lexicographically smaller category.
*/
with cte as(
select
(case when month(sale_date) in (12,1,2) then 'Winter'
	  when month(sale_date) in (3,4,5) then'Spring'
      when month(sale_date) in (6,7,8) then'Summer'
      else "Fall" end) as season,
sum(quantity) as total_quantity,p.category ,sum(quantity*price) as total_revenue
from sales28 s join products28 p on s.product_id=p.product_id
group by p.category,season)
select season,total_quantity,category,total_revenue from (select *,
row_number() over(partition by season order by total_quantity desc,total_revenue desc,category)  as rn 
from cte)s where s.rn=1 ;

/*29:Write a solution to find patients who have recovered from COVID
-A patient is considered recovered if they have at least one Positive test followed by at least one Negative 
test on a later date
-Calculate the recovery time in days as the difference between the first positive test and the first negative test after that positive test
-Only include patients who have both positive and negative test results
*/

with cte as(select patient_id,min(test_date) as positive_date
from covid_tests29
where result='positive'
group by patient_id),
cte2 as (select cte.patient_id,positive_date,min(ct.test_date) as negative_date
		from cte join covid_tests29 ct on cte.patient_id=ct.patient_id
        where positive_date<ct.test_date and ct.result = 'Negative' 
        group by cte.patient_id,positive_date)
select c2.patient_id ,p.patient_name,p.age,datediff(negative_date,positive_date) as recovery_time
from cte2 c2 join patients29 p on p.patient_id=c2.patient_id
order by datediff(negative_date,positive_date),c2.patient_id;

/*Q30:Write a solution to find stores that have inventory imbalance
For each store, identify the most expensive product (highest price) and its quantity
For each store, identify the cheapest product (lowest price) and its quantity
A store has inventory imbalance if the most expensive product's quantity is less than the cheapest product's quantity
Calculate the imbalance ratio as (cheapest_quantity / most_expensive_quantity)
Round the imbalance ratio to 2 decimal places
Only include stores that have at least 3 different products
*/
