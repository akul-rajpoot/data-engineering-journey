##################
# Case study Day 1
##################

# case study 1 : table creation and insertion

use de_practice;

CREATE TABLE customers (
    customer_id INT,
    customer_name VARCHAR(50),
    city VARCHAR(50)
);

INSERT INTO customers VALUES
(1, 'Amit', 'Delhi'),
(2, 'Rahul', 'Mumbai'),
(3, 'Neha', 'Delhi'),
(4, 'Priya', 'Bangalore');

CREATE TABLE orders (
    order_id INT,
    customer_id INT,
    order_date DATE,
    amount INT
);

INSERT INTO orders VALUES
(101, 1, '2023-01-01', 500),
(102, 1, '2023-01-05', 700),
(103, 2, '2023-01-02', 300),
(104, 2, '2023-01-02', 400),
(105, 3, '2023-01-03', 800),
(106, 3, '2023-01-04', 200),
(107, 4, '2023-01-01', 1000),
(108, 4, '2023-01-06', 1500);

#############################
# Case study 2
############################
CREATE TABLE employees02 (
    emp_id INT,
    name VARCHAR(50),
    department VARCHAR(50),
    salary INT
);

INSERT INTO employees02 VALUES
(1, 'Amit', 'IT', 60000),
(2, 'Rahul', 'IT', 80000),
(3, 'Neha', 'HR', 50000),
(4, 'Priya', 'HR', 70000),
(5, 'Karan', 'Finance', 90000),
(6, 'Vikas', 'IT', 75000),
(7, 'Anjali', 'IT', 65000),
(8, 'Rohit', 'HR', 60000),
(9, 'Simran', 'HR', 55000),
(10, 'Arjun', 'Finance', 85000),
(11, 'Kavya', 'Finance', 70000);

CREATE TABLE performance (
    emp_id INT,
    review_date DATE,
    rating INT
);

INSERT INTO performance VALUES
-- Employee 1 (Amit)
(1, '2023-03-01', 5),

-- Employee 2 (Rahul)
(2, '2023-04-01', 3),

-- Employee 3 (Neha)
(3, '2023-03-01', 4),

-- Employee 4 (Priya)
(4, '2023-02-01', 5),
(4, '2023-03-01', 3),

-- Employee 5 (Karan)
(5, '2023-03-01', 4),

-- Employee 6 (Vikas)
(6, '2023-01-01', 3),
(6, '2023-02-01', 4),

-- Employee 7 (Anjali)
(7, '2023-01-01', 2),
(7, '2023-02-01', 3),

-- Employee 8 (Rohit)
(8, '2023-01-01', 4),

-- Employee 9 (Simran)
(9, '2023-01-01', 3),

-- Employee 10 (Arjun)
(10, '2023-01-01', 5),
(10, '2023-02-01', 4),

-- Employee 11 (Kavya)
(11, '2023-01-01', 2),
(11, '2023-02-01', 3);




