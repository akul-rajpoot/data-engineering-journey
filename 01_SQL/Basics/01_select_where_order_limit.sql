#query 1 to select all employees
select * from employees;
SELECT name, salary FROM employees; # selecting selected columns

#query2 to select all department
select * from departments;

#Query3 to select 2 employees using limit
select * from employees limit 2;

#Using Where Clause
select * from employees where name = 'Rahul';

select name from employees where age >'24';

select manager from departments where dept_name='IT';

select * from employees where salary > 50000;

#using order by (works ascending by default)

Select * from employees order by name;

select * from employees order by age desc;

select * from employees order by salary ;


#using and , OR

select * from employees where age= '35' or age= '29';

select * from employees where name='Amit' and department='Finance';

select name from employees where salary>'45000';







