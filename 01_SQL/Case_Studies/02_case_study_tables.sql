use de_practice;


CREATE TABLE orders02 (
    order_id INT,
    customer_id INT,
    order_date DATE,
    amount INT
);

INSERT INTO orders02 VALUES
(1, 101, '2023-01-01', 500),
(2, 101, '2023-01-05', 700),
(3, 102, '2023-01-02', 300),
(4, 103, '2023-01-03', 800);

CREATE TABLE products02 (
    product_id INT,
    product_name VARCHAR(50),
    price INT
);

INSERT INTO products02 VALUES
(1, 'Laptop', 500),
(2, 'Phone', 300),
(3, 'Tablet', 200),
(4, 'Headphones', 100),
(5, 'Charger', 200);



CREATE TABLE order_items02 (
    order_id INT,
    product_id INT,
    quantity INT
);

INSERT INTO order_items02 VALUES
(1, 1, 1),
(1, 2, 1),
(1, 4, 2),
(2, 2, 2),
(2, 3, 1),
(3, 1, 1),
(4, 3, 3);


#####################################################
#🚀 🧠 Case Study 2: Banking Transactions Analytics
####################################################

CREATE TABLE customers02 (
    customer_id INT,
    customer_name VARCHAR(50),
    city VARCHAR(50)
);

INSERT INTO customers02 VALUES
(1, 'Amit', 'Delhi'),
(2, 'Rahul', 'Mumbai'),
(3, 'Neha', 'Delhi'),
(4, 'Priya', 'Bangalore'),
(5, 'Karan', 'Pune');

CREATE TABLE accounts02 (
    account_id INT,
    customer_id INT,
    account_type VARCHAR(20)
);

INSERT INTO accounts02 VALUES
(101, 1, 'Savings'),
(102, 1, 'Current'),
(103, 2, 'Savings'),
(104, 3, 'Savings'),
(105, 4, 'Current'),
(106, 5, 'Savings');

CREATE TABLE transactions02 (
    txn_id INT,
    account_id INT,
    txn_date DATE,
    amount INT,
    txn_type VARCHAR(10) -- Credit / Debit
);

INSERT INTO transactions02 VALUES
(1, 101, '2023-01-01', 1000, 'Credit'),
(2, 101, '2023-01-03', 500, 'Debit'),
(3, 102, '2023-01-02', 2000, 'Credit'),
(4, 103, '2023-01-01', 1500, 'Credit'),
(5, 103, '2023-01-05', 700, 'Debit'),
(6, 104, '2023-01-02', 800, 'Credit'),
(7, 104, '2023-01-06', 300, 'Debit'),
(8, 105, '2023-01-01', 1200, 'Credit'),
(9, 105, '2023-01-04', 400, 'Debit'),
(10, 106, '2023-01-03', 900, 'Credit'),
(11, 106, '2023-01-07', 200, 'Debit');

 


