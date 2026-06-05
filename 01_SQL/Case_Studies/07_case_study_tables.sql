#########################################################
# 🚀 🧠 CASE STUDY 13: Employee Retention & Attrition Analytics
##########################################################

use de_practice;

CREATE TABLE employees13 (
    emp_id INT,
    emp_name VARCHAR(50),
    department VARCHAR(30)
);

INSERT INTO employees13 VALUES
(1,'Amit','IT'),
(2,'Rahul','IT'),
(3,'Neha','HR'),
(4,'Priya','HR'),
(5,'Karan','Finance');


CREATE TABLE employment_history13 (
    record_id INT,
    emp_id INT,
    status VARCHAR(20),   -- Active / Inactive
    status_date DATE
);


INSERT INTO employment_history13 VALUES

(1,1,'Active','2023-01-01'),
(2,1,'Inactive','2023-06-01'),
(3,1,'Active','2023-07-01'),

(4,2,'Active','2023-01-01'),

(5,3,'Active','2023-01-01'),
(6,3,'Inactive','2023-04-01'),

(7,4,'Active','2023-01-01'),
(8,4,'Inactive','2023-03-01'),
(9,4,'Active','2023-04-01'),
(10,4,'Inactive','2023-08-01'),

(11,5,'Active','2023-01-01'),
(12,5,'Inactive','2023-05-01'),
(13,5,'Active','2023-06-01');


###########################################################
#🚀 🧠 CASE STUDY 14: Customer Order Behavior Analytics
###########################################################


CREATE TABLE customers14 (
    customer_id INT,
    customer_name VARCHAR(50)
);

INSERT INTO customers14 VALUES
(1,'Amit'),
(2,'Rahul'),
(3,'Neha'),
(4,'Priya'),
(5,'Karan');

CREATE TABLE orders14 (
    order_id INT,
    customer_id INT,
    order_date DATE,
    amount INT
);

INSERT INTO orders14 VALUES

(1,1,'2023-01-01',100),
(2,1,'2023-01-02',120),
(3,1,'2023-01-03',150),

(4,2,'2023-01-01',200),
(5,2,'2023-01-05',180),
(6,2,'2023-01-10',160),

(7,3,'2023-01-01',100),
(8,3,'2023-01-02',100),
(9,3,'2023-01-03',100),

(10,4,'2023-01-01',100),
(11,4,'2023-01-03',150),
(12,4,'2023-01-04',200),

(13,5,'2023-01-01',300),
(14,5,'2023-01-02',250),
(15,5,'2023-01-03',350);
