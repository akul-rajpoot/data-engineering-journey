#creating_DB
CREATE DATABASE de_practice;
USE de_practice;

#creating tables
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    salary INT,
    department VARCHAR(50),
    city VARCHAR(50)
);

#inserting sample data
INSERT INTO employees VALUES
(1, 'Rahul', 28, 50000, 'IT', 'Delhi'),
(2, 'Amit', 32, 70000, 'Finance', 'Mumbai'),
(3, 'Neha', 26, 65000, 'HR', 'Delhi'),
(4, 'Priya', 30, 80000, 'IT', 'Bangalore'),
(5, 'Karan', 27, 45000, 'Finance', 'Delhi'),
(6, 'Sneha', 29, 72000, 'HR', 'Mumbai'),
(7, 'Vikas', 35, 90000, 'IT', 'Pune'),
(8, 'Anjali', 24, 40000, 'HR', 'Delhi');

#creating second table 
CREATE TABLE departments (
    dept_name VARCHAR(50),
    manager VARCHAR(50)
);

#inserting sample data
INSERT INTO departments VALUES
('IT', 'Suresh'),
('Finance', 'Ramesh'),
('HR', 'Anita');



