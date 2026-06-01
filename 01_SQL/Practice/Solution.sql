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





 





