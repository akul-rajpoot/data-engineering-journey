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

 






