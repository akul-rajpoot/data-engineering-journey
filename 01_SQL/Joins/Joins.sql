Use de_practice;

# =========================
# INNER JOIN
# =========================

#Q: Get employee name, department, and manager name.
select e.name,e.department,d.manager
from employees e join
departments d on e.department=d.dept_name;

#Q:Find average salary per department along with manager name.
select e.department,avg(e.salary) as avg_Salary,d.manager
from employees e
join departments d on d.dept_name=e.department
group by e.department,d.manager;

#Q: Find employees who belong to departments managed by ‘Suresh’.
select e.name,d.manager
from employees e join departments d
on e.department=d.dept_name
where d.manager='Suresh';

# =========================
# LEFT JOIN
# =========================

#Q: Get all employees with their manager (include employees with no manager).
select e.name,d.manager
from employees e left join
departments d on e.department=d.dept_name;

#Q: Find employees whose department does NOT exist in departments table.
select e.name,e.department from 
employees e left join
departments d on e.department = d.dept_name
where d.dept_name is null;

# =========================
# RIGHT JOIN
# =========================

#Q: Find departments that have NO employees.
select d.dept_name
from employees e right join 
departments d on e.department=d.dept_name
where e.department is null;

#Q:Get all departments and their employees(including departments with no employees)
select e.name,d.dept_name
from employees e right join
departments d on d.dept_name=e.department;


#🚀 NEXT LEVEL JOINS 
#Q1: Find employees who are not assigned to any project.
select e.name ,p.project_name
from employees e
left join projects p on e.department=p.department
where p.project_name is null;

#Q2 : Find projects that have no employees working on them.
select p.project_name from employees e 
right join projects p on e.department=p.department
where e.department is null;

#Q3 Find employees who work in departments that have more than 1 project.
select e.name
from employees e
join (
    select department
    from projects
    group by department
    having count(*) > 1
) p
on e.department = p.department;

#Q4:Find employees whose salary is greater than average salary of their department
select e.name,e.salary,e.avg_sal from employees e join
(select department,avg(salary) as avg_sal from 
employees group by department)s
on e.department=s.department
where e.salary > s.avg_sal;

select name from employees e
where salary > (select avg(salary) from employees e2 where e.department=e2.department);

#Q5:Find employees with highest salary in each department
select name from employees e
where salary=(select max(salary) from employees e2 where e.department=e2.department);

#ADVANCE JOIN
#Q1:Find employees who earn more than another employee in the same department.
select distinct e1.name 
from employees e1 join employees e2 
on e1.department=e2.department
and e1.emp_id != e2.emp_id
where e1.salary>e2.salary;

#Q2:Find pairs of employees who work in the same department.
SELECT e1.name AS employee_1, e2.name AS employee_2
FROM employees e1
JOIN employees e2 ON e1.department = e2.department
and e1.emp_id<e2.emp_id;

#Q4: Find projects that no employee is working on
select distinct p.project_name from projects p
left join employees e on e.department=p.department
where e.department is null;


