use de_practice;
###########################################################
#🚀 🧠 CASE STUDY 7: Fraud & Transaction Analytics (Banking)
##########################################################

CREATE TABLE customers07 (
    customer_id INT,
    customer_name VARCHAR(50),
    city VARCHAR(50)
);

INSERT INTO customers07 VALUES
(1, 'Amit', 'Delhi'),
(2, 'Rahul', 'Mumbai'),
(3, 'Neha', 'Delhi'),
(4, 'Priya', 'Bangalore');


CREATE TABLE accounts07 (
    account_id INT,
    customer_id INT,
    account_type VARCHAR(20)
);

INSERT INTO accounts07 VALUES
(101, 1, 'Savings'),
(102, 1, 'Current'),
(103, 2, 'Savings'),
(104, 3, 'Savings'),
(105, 4, 'Current');



CREATE TABLE transactions07 (
    txn_id INT,
    account_id INT,
    txn_date DATE,
    amount INT,
    txn_type VARCHAR(10)
);

INSERT INTO transactions07 VALUES
(1, 101, '2023-01-01', 1000, 'Credit'),
(2, 101, '2023-01-02', 200, 'Debit'),
(3, 101, '2023-01-03', 300, 'Debit'),
(4, 102, '2023-01-01', 2000, 'Credit'),
(5, 102, '2023-01-05', 500, 'Debit'),
(6, 103, '2023-01-02', 1500, 'Credit'),
(7, 103, '2023-01-03', 700, 'Debit'),
(8, 104, '2023-01-01', 1200, 'Credit'),
(9, 104, '2023-01-02', 1300, 'Debit'),
(10,105, '2023-01-03', 2500, 'Credit');


################################################################
#🚀 🧠 CASE STUDY 8: E-Commerce Retention & Behavior Analytics
##############################################################

CREATE TABLE customers08 (
    customer_id INT,
    customer_name VARCHAR(50),
    signup_date DATE
);

INSERT INTO customers08 VALUES
(1, 'Amit', '2023-01-01'),
(2, 'Rahul', '2023-01-02'),
(3, 'Neha', '2023-01-03'),
(4, 'Priya', '2023-01-04');

CREATE TABLE orders08 (
    order_id INT,
    customer_id INT,
    order_date DATE,
    amount INT
);

INSERT INTO orders08 VALUES
(101, 1, '2023-01-01', 500),
(102, 1, '2023-01-02', 600),
(103, 1, '2023-01-05', 700),
(104, 2, '2023-01-01', 400),
(105, 2, '2023-01-03', 300),
(106, 3, '2023-01-02', 800),
(107, 3, '2023-01-03', 700),
(108, 3, '2023-01-04', 600),
(109, 4, '2023-01-01', 200);


CREATE TABLE order_items08 (
    order_id INT,
    product_id INT,
    quantity INT
);

INSERT INTO order_items08 VALUES
(101, 1, 2),
(101, 2, 1),
(102, 1, 1),
(103, 3, 2),
(104, 2, 1),
(105, 2, 2),
(106, 1, 3),
(107, 3, 1),
(108, 1, 2),
(109, 4, 1);