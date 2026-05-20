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
