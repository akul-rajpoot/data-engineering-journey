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
select * from stores30;
with cte1 as (
select *,
row_number() over(partition by store_id order by price desc) as rn1,
row_number() over(partition by store_id order by price) as rn2,
count(*) over(partition by store_id) as cnt
from inventory30)

select c1.store_id,s.store_name,s.location,c1.product_name as most_exp_product,
c2.product_name as cheapest_product , round(c2.quantity/c1.quantity,2) as imbalance_ratio
from cte1 c1 join cte1 c2 on c1.store_id=c2.store_id join stores30 s on s.store_id=c1.store_id
where c1.rn1=1 and c2.rn2=1 and c1.quantity<c2.quantity and c1.cnt>=3
order by round(c2.quantity/c1.quantity,2) desc
;


 /*Q31: Write a solution to find drivers whose fuel efficiency has improved by comparing their average fuel efficiency in the first half of the year with the second half of the year.

Calculate fuel efficiency as distance_km / fuel_consumed for each trip ----
First half: January to June, Second half: July to December
Only include drivers who have trips in both halves of the year
Calculate the efficiency improvement as (second_half_avg - first_half_avg)
Round all results to 2 decimal places
*/

select * from drivers31;
with cte as(
select t.driver_id,d.driver_name,round(distance_km/fuel_consumed,2)  as efficiency,
(case when month(trip_Date) between 1 and 6 then 'first' else 'second' end ) as halfs 
from trips31 t join drivers31 d on d.driver_id=t.driver_id)

select driver_id,driver_name,round(avg(case when halfs='first' then efficiency else null end),2) as first_half_avg ,
round(avg(case when halfs='second' then efficiency else null end),2) as second_half_avg,
round(avg(case when halfs='second' then efficiency else null end) - avg(case when halfs='first' then efficiency else null end),2) as efficiency_improvement
from cte
group by 1,2
having(count(distinct(halfs)))=2 
order by efficiency_improvement desc;


with cte as(SELECT
    t.driver_id,
    d.driver_name,
    ROUND(
        AVG(
            CASE
                WHEN MONTH(trip_date) BETWEEN 1 AND 6
                THEN distance_km / fuel_consumed
            END
        ), 2
    ) AS first_half_avg,

    ROUND(
        AVG(
            CASE
                WHEN MONTH(trip_date) BETWEEN 7 AND 12
                THEN distance_km / fuel_consumed
            END
        ), 2
    ) AS second_half_avg,

    ROUND(
        AVG(
            CASE
                WHEN MONTH(trip_date) BETWEEN 7 AND 12
                THEN distance_km / fuel_consumed
            END
        )
        -
        AVG(
            CASE
                WHEN MONTH(trip_date) BETWEEN 1 AND 6
                THEN distance_km / fuel_consumed
            END
        ), 2
    ) AS efficiency_improvement
FROM trips t
JOIN drivers d
    ON d.driver_id = t.driver_id
GROUP BY t.driver_id, d.driver_name
HAVING
    COUNT(
        DISTINCT CASE
            WHEN MONTH(trip_date) BETWEEN 1 AND 6 THEN 'first'
            ELSE 'second'
        END
    ) = 2
order by efficiency_improvement desc,d.driver_name)
select * from cte where efficiency_improvement>0;

/*Q32: Write a solution to find books that have polarized opinions - books that receive both very high 
ratings and very low ratings from different readers.

A book has polarized opinions if it has at least one rating ≥ 4 and at least one rating ≤ 2
Only consider books that have at least 5 reading sessions
Calculate the rating spread as (highest_rating - lowest_rating)
Calculate the polarization score as the number of extreme ratings (ratings ≤ 2 or ≥ 4) divided by total sessions
Only include books where polarization score ≥ 0.6 (at least 60% extreme ratings)
*/

with cte as (
select b.book_id,b.title,b.author,b.genre,b.pages,max(session_rating)-min(session_rating) as rating_spread,
round(sum(case when session_rating>=4 or session_rating<=2 then 1 else 0 end)/count(*),2) as polarization_score
from books b 
join reading_sessions r on b.book_id=r.book_id 
group by b.book_id,b.title,b.author,b.genre,b.pages
having count(r.book_id)>=5 and min(session_rating)<=2 and max(session_rating) >= 4)
select * from cte where polarization_score>=0.6
order by polarization_score desc ,title desc ;


/*Q33: Write a solution to find employees who are meeting-heavy - employees who spend more than 50% of 
their working time in meetings during any given week.

Assume a standard work week is 40 hours
Calculate total meeting hours per employee per week (Monday to Sunday)
An employee is meeting-heavy if their weekly meeting hours > 20 hours (50% of 40 hours)
Count how many weeks each employee was meeting-heavy
Only include employees who were meeting-heavy for at least 2 weeks
*/
select e.employee_id,e.employee_name,e.department
from employees33 e join meetings33 m ;

with cte as(
SELECT
    employee_id,
    YEARWEEK(meeting_date,1) AS week_id,
    SUM(duration_hours) AS weekly_hours
FROM meetings33
GROUP BY employee_id, YEARWEEK(meeting_date,1)
)

select e.employee_id,e.employee_name,e.department,
count(case when weekly_hours>20 then 1 end ) as meeting_heavy_weeks
from employees33 e join cte c on  e.employee_id=c.employee_id
group by e.employee_id,e.employee_name,e.department 
having meeting_heavy_weeks>=2 ;

/*Q34:Write a solution to identify skill mastery pathways by analyzing course completion sequences among 
top-performing students:
Consider only top-performing students (those who completed at least 5 courses with an average rating of 4 or 
higher).
For each top performer, identify the sequence of courses they completed in chronological order.
Find all consecutive course pairs (Course A → Course B) taken by these students.
Return the pair frequency, identifying which course transitions are most common among high achievers.
*/

with cte as(
select course_name,
count(*) over(partition by user_id) as cnt,
avg(course_rating) over(partition by user_id) as average,
lead(course_name) over(partition by user_id order by completion_date) as next_course 
from course_completions34)

select course_name as first_course,next_course as second_course , count(*) as transition_count
from cte
where cnt>=5 and average>=4 and next_course is not null
group by course_name,next_course
order by transition_count desc,first_course,second_course;


/*Q35: Amazon wants to understand shopping patterns across product categories. Write a solution to:
Find all category pairs (where category1 < category2)
For each category pair, determine the number of unique customers who purchased products from both categories
A category pair is considered reportable if at least 3 different customers have purchased products from both 
categories.
*/

WITH cte AS (
    SELECT DISTINCT
           pp.user_id,
           pi.category
    FROM ProductPurchases35 pp
    JOIN ProductInfo35 pi
      ON pp.product_id = pi.product_id
)
select c1.category as category1 ,c2.category as category2,count(distinct(c1.user_id)) as customer_count
from cte c1 join cte c2 on c1.user_id=c2.user_id
where c1.category<c2.category
group by c1.category,c2.category
having count(distinct(c1.user_id))>=3;

/*Q36:Write a solution to identify behaviorally stable users based on the following definition:
A user is considered behaviorally stable if there exists a sequence of at least 5 consecutive days such that:
The user performed exactly one action per day during that period.
The action is the same on all those consecutive days.
If a user has multiple qualifying sequences, only consider the sequence with the maximum length.
*/

with cte as(
select *,date_sub(action_date,interval rn day) as flag_date from (
select *,
row_number() over(partition by user_id,action order by action_date) as rn 
from activity36)s)
select user_id,action,count(*) as streak_length,min(action_date) as start_date,
max(action_date) as end_date
from cte group by user_id,action,flag_date 
having count(user_id)>=5 ;



/*Q37:Write a solution to find students who follow the Study Spiral Pattern - students who consistently study multiple subjects in a rotating cycle.

A Study Spiral Pattern means a student studies at least 3 different subjects in a repeating sequence
The pattern must repeat for at least 2 complete cycles (minimum 6 study sessions)
Sessions must be consecutive dates with no gaps longer than 2 days between sessions
Calculate the cycle length (number of different subjects in the pattern)
Calculate the total study hours across all sessions in the pattern
Only include students with cycle length of at least 3 subjects
*/

WITH sessions AS (SELECT *,
ROW_NUMBER() OVER(PARTITION BY student_id ORDER BY session_date) AS rn,
LAG(session_date) OVER(PARTITION BY student_id ORDER BY session_date) AS prev_date
FROM study_sessions37
),
student_info AS (SELECT student_id,COUNT(DISTINCT subject) AS cycle_length,COUNT(*) AS total_sessions,
SUM(hours_studied) AS total_study_hours FROM study_sessions37
GROUP BY student_id
HAVING COUNT(DISTINCT subject) >= 3
AND COUNT(*) >= COUNT(DISTINCT subject) * 2
),
matches AS (SELECT s1.student_id,COUNT(*) AS matched_pairs
FROM sessions s1 JOIN student_info si
ON s1.student_id = si.student_id
JOIN sessions s2
ON s1.student_id = s2.student_id
AND s2.rn = s1.rn + si.cycle_length
AND s1.subject = s2.subject
GROUP BY s1.student_id
),
gap_check AS (SELECT student_id,MAX(
CASE WHEN prev_date IS NULL THEN 0 ELSE DATEDIFF(session_date, prev_date)END
) AS max_gap
FROM sessions
GROUP BY student_id
)

SELECT st.student_id,st.student_name,st.major,si.cycle_length,si.total_study_hours
FROM student_info si JOIN matches m
ON si.student_id = m.student_id
JOIN students37 st ON st.student_id = si.student_id
join gap_check	g ON si.student_id = g.student_id
WHERE m.matched_pairs >= si.cycle_length  AND g.max_gap <= 2;

/*Q38:Write a solution to identify zombie sessions, sessions where users appear active but show abnormal behavior patterns.
A session is considered a zombie session if it meets ALL the following criteria:
The session duration is more than 30 minutes.
Has at least 5 scroll events.
The click-to-scroll ratio is less than 0.20 .
No purchases were made during the session.
*/
select session_id,user_id,
TIMESTAMPDIFF(MINUTE, min(event_timestamp),max(event_timestamp)) as session_duration_minutes,
count(case when event_type='scroll' then 1 end ) as scroll_count
from app_events38
group by session_id,user_id
HAVING
	session_duration_minutes > 30
	AND COUNT(CASE WHEN event_type='scroll' THEN 1 END) >= 5
    AND (COUNT(CASE WHEN event_type='click' THEN 1 END) * 1.0/COUNT(CASE WHEN event_type='scroll' THEN 1 END)) < 0.20
    AND SUM( CASE WHEN event_type='purchase' THEN 1 ELSE 0 END) = 0;


/*Q39:Write a solution to transform the text in the content_text column by applying the following rules:

Convert the first letter of each word to uppercase and the remaining letters to lowercase
Special handling for words containing special characters:
For words connected with a hyphen -, both parts should be capitalized (e.g., top-rated → Top-Rated)
All other formatting and spacing should remain unchanged
*/

WITH RECURSIVE cte1 AS (
   SELECT content_id,
          content_text AS text,
          LENGTH(content_text) AS len 
   FROM user_content39
),

cte2 AS (
    SELECT content_id,1 AS idx,text,len,
           SUBSTRING(text,1,1) AS charr 
    FROM cte1
    
    UNION ALL
    
    SELECT content_id,idx+1,text,len,
           SUBSTRING(text,idx+1,1) AS charr
    FROM cte2
    WHERE idx+1 <= len
),

cte3 AS (
    SELECT content_id,idx,text,len,charr,
           LAG(charr,1,' ') OVER(PARTITION BY content_id ORDER BY idx) AS prv,
           LEAD(charr,1,' ') OVER(PARTITION BY content_id ORDER BY idx) AS nxt,
           SUM(CASE WHEN charr=' ' THEN 1 ELSE 0 END)
           OVER(PARTITION BY content_id ORDER BY idx) AS token_id
    FROM cte2
),

cte4 AS (
    SELECT content_id,idx,text,len,charr,prv,nxt,token_id,
    
           -- detect consecutive dashes ("--")
           SUM(CASE WHEN charr='-' AND prv='-' THEN 1 ELSE 0 END)
           OVER(PARTITION BY content_id,token_id) AS double_dash,
    
           -- detect invalid characters
           SUM(CASE 
               WHEN charr NOT REGEXP '^[A-Za-z0-9 \\-]$'
               THEN 1 ELSE 0 
           END) OVER(PARTITION BY content_id,token_id) AS invalid_count,
    
           -- detect boundary dashes
           SUM(CASE 
               WHEN charr='-' AND (prv=' ' OR nxt=' ') 
               THEN 1 ELSE 0 
           END) OVER(PARTITION BY content_id,token_id) AS bndry_dash
    
    FROM cte3
),

cte5 AS (
    SELECT content_id,idx,text,len,charr,
    
           CASE
               WHEN prv=' ' THEN UPPER(charr)
               WHEN prv='-' AND double_dash=0 AND invalid_count=0 AND bndry_dash=0
                    THEN UPPER(charr)
               ELSE LOWER(charr)
           END AS final_char
    
    FROM cte4
)

SELECT content_id,
       text AS original_text,
       GROUP_CONCAT(final_char ORDER BY idx ASC SEPARATOR '') AS converted_text
FROM cte5
GROUP BY content_id, text;


/*Q40:Write a solution to Find Churn Risk Customers - users who show warning signs before churning. A user is considered churn risk customer if they meet ALL the following criteria:

Currently have an active subscription (their last event is not cancel).
Have performed at least one downgrade in their subscription history.
Their current plan revenue is less than 50% of their historical maximum plan revenue.
Have been a subscriber for at least 60 days.*/
with cte as(
select *,
row_number() over(partition by user_id order by event_date desc,event_id desc) as rn,
MAX(monthly_amount) OVER (PARTITION BY user_id) AS max_revenue,
MIN(event_date) OVER (PARTITION BY user_id) AS first_event_date,
MAX(CASE WHEN event_type = 'downgrade' THEN 1 ELSE 0 END) OVER (PARTITION BY user_id) AS downgrade_flag
from subscription_events40)
select user_id,plan_name as  current_plan, monthly_amount as current_monthly_amount,
max_revenue as max_historical_amount ,DATEDIFF(event_date, first_event_date) AS  days_as_subscriber
from cte
WHERE rn = 1 and
event_type<>'cancel'  
AND downgrade_flag = 1
AND monthly_amount < max_revenue * 0.5
AND DATEDIFF(event_date, first_event_date)>=60
order by days_as_subscriber desc,user_id;