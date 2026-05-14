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