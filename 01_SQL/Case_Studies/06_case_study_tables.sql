###########################################################
# 🚀 🧠 CASE STUDY 11: Employee Promotion & Salary Analytics
###########################################################

CREATE TABLE employees11 (
    emp_id INT,
    emp_name VARCHAR(50),
    department VARCHAR(30),
    join_date DATE
);

INSERT INTO employees11 VALUES
(1,'Amit','IT','2020-01-01'),
(2,'Rahul','IT','2020-02-01'),
(3,'Neha','HR','2020-01-15'),
(4,'Priya','HR','2020-03-01'),
(5,'Karan','Finance','2020-01-10');

CREATE TABLE salary_history11 (
    emp_id INT,
    effective_date DATE,
    salary INT
);

INSERT INTO salary_history11 VALUES
(1,'2020-01-01',50000),
(1,'2021-01-01',55000),
(1,'2022-01-01',60000),

(2,'2020-02-01',45000),
(2,'2021-02-01',45000),
(2,'2022-02-01',50000),

(3,'2020-01-15',40000),
(3,'2021-01-15',45000),

(4,'2020-03-01',42000),
(4,'2021-03-01',41000),

(5,'2020-01-10',70000),
(5,'2021-01-10',80000),
(5,'2022-01-10',90000);

#
#🚀 🧠 CASE STUDY 12: Customer Subscription Retention Analytics
#

CREATE TABLE customers12 (
    customer_id INT,
    customer_name VARCHAR(50)
);

INSERT INTO customers12 VALUES
(1,'Amit'),
(2,'Rahul'),
(3,'Neha'),
(4,'Priya'),
(5,'Karan');

CREATE TABLE subscriptions12 (
    sub_id INT,
    customer_id INT,
    start_date DATE,
    end_date DATE,
    plan VARCHAR(20)
);

INSERT INTO subscriptions12 VALUES

(1,1,'2023-01-01','2023-01-31','Basic'),
(2,1,'2023-02-01','2023-02-28','Premium'),
(3,1,'2023-03-01','2023-03-31','Premium'),

(4,2,'2023-01-01','2023-01-31','Basic'),
(5,2,'2023-02-10','2023-03-10','Premium'),

(6,3,'2023-01-01','2023-01-31','Premium'),
(7,3,'2023-02-01','2023-02-28','Premium'),

(8,4,'2023-01-01','2023-01-31','Basic'),

(9,5,'2023-01-01','2023-01-31','Basic'),
(10,5,'2023-02-01','2023-02-28','Basic'),
(11,5,'2023-03-01','2023-03-31','Premium');