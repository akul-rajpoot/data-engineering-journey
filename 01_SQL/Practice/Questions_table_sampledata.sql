-- Salaries Differences
/*Q1:Calculates the difference between the highest salaries in the marketing and engineering departments. 
Output just the absolute difference in salaries.*/

CREATE DATABASE Practice;
Use Practice;

CREATE TABLE db_employee (
    id BIGINT PRIMARY KEY,
    first_name TEXT,
    last_name TEXT,
    salary BIGINT,
    department_id BIGINT
);

-- Department Table
CREATE TABLE db_dept (
    id BIGINT PRIMARY KEY,
    department TEXT
);

INSERT INTO db_dept (id, department) VALUES
(1, 'Engineering'),
(2, 'HR'),
(3, 'Finance'),
(4, 'Marketing'),
(5, 'Sales');

INSERT INTO db_employee (id, first_name, last_name, salary, department_id) VALUES
(101, 'Amit', 'Sharma', 70000, 1),
(102, 'Neha', 'Verma', 65000, 1),
(103, 'Raj', 'Singh', 50000, 2),
(104, 'Priya', 'Mehta', 60000, 3),
(105, 'Karan', 'Malhotra', 55000, 4),
(106, 'Sneha', 'Kapoor', 72000, 1),
(107, 'Vikas', 'Yadav', 48000, 2),
(108, 'Anjali', 'Gupta', 53000, 5),
(109, 'Rohit', 'Agarwal', 80000, 3),
(110, 'Pooja', 'Bansal', 62000, 4);

#######################################

#Total Cost Of Orders
/* Q2: Find the total cost of each customer's orders. Output customer's id, first name, and the total order cost. 
Order records by customer's first name alphabetically.*/

CREATE TABLE customers (
    id BIGINT PRIMARY KEY,
    first_name TEXT,
    last_name TEXT,
    city TEXT,
    address TEXT,
    phone_number TEXT
);

CREATE TABLE orders (
    id BIGINT PRIMARY KEY,
    cust_id BIGINT,
    order_date DATE,
    order_details TEXT,
    total_order_cost BIGINT
);

INSERT INTO customers (id, first_name, last_name, city, address, phone_number) VALUES
(1, 'Amit', 'Sharma', 'Delhi', 'Karol Bagh', '9991112221'),
(2, 'Neha', 'Verma', 'Mumbai', 'Andheri', '9991112222'),
(3, 'Raj', 'Singh', 'Delhi', 'Saket', '9991112223'),
(4, 'Priya', 'Mehta', 'Bangalore', 'Whitefield', '9991112224'),
(5, 'Karan', 'Malhotra', 'Mumbai', 'Bandra', '9991112225');

INSERT INTO orders (id, cust_id, order_date, order_details, total_order_cost) VALUES
(101, 1, '2024-01-10', 'Laptop', 70000),
(102, 1, '2024-02-15', 'Mouse', 1000),
(103, 2, '2024-01-20', 'Mobile', 50000),
(104, 3, '2024-03-05', 'Keyboard', 2000),
(105, 3, '2024-03-10', 'Monitor', 15000),
(106, 4, '2024-02-25', 'Tablet', 30000),
(107, 5, '2024-03-15', 'Headphones', 3000),
(108, 2, '2024-03-18', 'Charger', 1500);

/*Q3:Management wants to analyze only employees with official job titles. Find the job titles of the employees with the 
highest salary. If multiple employees have the same highest salary, include all their job titles.*/

CREATE TABLE worker (
    worker_id BIGINT PRIMARY KEY,
    first_name TEXT,
    last_name TEXT,
    salary BIGINT,
    joining_date DATE,
    department TEXT
);

CREATE TABLE title (
    worker_ref_id BIGINT,
    worker_title TEXT,
    affected_from DATE
);

INSERT INTO worker (worker_id, first_name, last_name, salary, joining_date, department) VALUES
(1, 'Monika', 'Arora', 100000, '2021-02-20', 'HR'),
(2, 'Niharika', 'Verma', 80000, '2021-06-11', 'Admin'),
(3, 'Vishal', 'Singhal', 300000, '2021-02-20', 'HR'),
(4, 'Amitabh', 'Singh', 500000, '2021-02-20', 'Admin'),
(5, 'Vivek', 'Bhati', 500000, '2021-06-11', 'Admin'),
(6, 'Vipul', 'Diwan', 200000, '2021-06-11', 'Account'),
(7, 'Satish', 'Kumar', 75000, '2021-01-20', 'Account'),
(8, 'Geetika', 'Chauhan', 90000, '2021-04-11', 'Admin');

INSERT INTO title (worker_ref_id, worker_title, affected_from) VALUES
(1, 'Manager', '2023-02-20'),
(2, 'Executive', '2023-06-11'),
(8, 'Executive', '2023-06-11'),
(5, 'Manager', '2023-06-11'),
(4, 'Asst. Manager', '2023-06-11'),
(7, 'Executive', '2023-01-20'),
(6, 'Lead', '2023-06-11'),
(3, 'Lead', '2023-06-11');


#Q4: Find all posts which were reacted to with a heart
#Find all posts which were reacted to with a heart. For such posts output all columns from facebook_posts table.


CREATE TABLE facebook_posts (
    post_id BIGINT PRIMARY KEY,
    poster BIGINT,
    post_date DATE,
    post_text TEXT,
    post_keywords TEXT
);

CREATE TABLE facebook_reactions (
    post_id BIGINT,
    poster BIGINT,
    friend BIGINT,
    reaction TEXT,
    date_day INT
);

INSERT INTO facebook_posts VALUES
(1, 101, '2024-01-01', 'Happy New Year!', 'celebration'),
(2, 102, '2024-01-02', 'Workout done 💪', 'fitness'),
(3, 101, '2024-01-03', 'SQL is fun', 'tech'),
(4, 103, '2024-01-04', 'Travel diaries', 'travel'),
(5, 104, '2024-01-05', 'Healthy eating', 'fitness');

INSERT INTO facebook_reactions VALUES
(1, 101, 201, 'like', 1),
(1, 101, 202, 'love', 1),
(2, 102, 201, 'heart', 2),
(2, 102, 203, 'like', 2),
(3, 101, 202, 'heart', 3),
(3, 101, 204, 'like', 3),
(4, 103, 201, 'heart', 4),
(4, 103, 202, 'like', 4),
(5, 104, 203, 'heart', 5),
(5, 104, 204, 'like', 5);

#Q5: Find all the users who were active for 3 consecutive days or more.
CREATE TABLE sf_events (
    account_id TEXT,
    user_id TEXT,
    record_date DATE
);

INSERT INTO sf_events (record_date, account_id, user_id) VALUES

-- ✅ U1 → 3 consecutive days (should be included)
('2021-01-01', 'A1', 'U1'),
('2021-01-02', 'A1', 'U1'),
('2021-01-03', 'A1', 'U1'),

-- ❌ U2 → only 2 days (should NOT be included)
('2021-01-01', 'A1', 'U2'),
('2021-01-02', 'A1', 'U2'),

-- ⚠️ U3 → has gap (NOT consecutive)
('2021-01-01', 'A1', 'U3'),
('2021-01-03', 'A1', 'U3'),
('2021-01-04', 'A1', 'U3'),

-- ✅ U4 → 4 consecutive days (should be included)
('2021-01-02', 'A1', 'U4'),
('2021-01-03', 'A1', 'U4'),
('2021-01-04', 'A1', 'U4'),
('2021-01-05', 'A1', 'U4'),

-- ⚠️ U5 → two separate streaks (only 2 max → NOT included)
('2021-01-01', 'A1', 'U5'),
('2021-01-02', 'A1', 'U5'),
('2021-01-05', 'A1', 'U5'),
('2021-01-06', 'A1', 'U5'),

-- ✅ U6 → exactly 3 consecutive days (edge case → include)
('2021-01-07', 'A1', 'U6'),
('2021-01-08', 'A1', 'U6'),
('2021-01-09', 'A1', 'U6');

