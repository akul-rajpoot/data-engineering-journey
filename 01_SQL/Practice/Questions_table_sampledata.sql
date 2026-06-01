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

#Q6: Find all numbers that appear at least three times consecutively.

CREATE TABLE logs (
    id INT PRIMARY KEY,
    num VARCHAR(10)
);

INSERT INTO logs (id, num) VALUES
(1, '1'),
(2, '1'),
(3, '1'),

(4, '2'),
(5, '1'),

(6, '2'),
(7, '2'),

(8, '3'),
(9, '3'),
(10, '3'),
(11, '3'),

(12, '4'),
(13, '5'),
(14, '4'),

(15, '6'),
(16, '6'),
(17, '6'),

(18, '7'),
(19, '7'),

(20, '8'),
(21, '8'),
(22, '9'),
(23, '8');


#Q7: Write a solution to find the employees who are high earners in each of the departments.

CREATE TABLE Department07 (
    id INT PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE Employee07 (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    salary INT,
    departmentId INT,
    FOREIGN KEY (departmentId) REFERENCES Department07(id)
);

INSERT INTO Department07 (id, name) VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance');

INSERT INTO Employee07 (id, name, salary, departmentId) VALUES

-- IT Department
(1, 'Amit',   120000, 1),
(2, 'Neha',   110000, 1),
(3, 'Raj',    110000, 1),
(4, 'Priya',  100000, 1),
(5, 'Karan',   90000, 1),
(6, 'Sneha',   80000, 1),

-- HR Department
(7, 'Rohit',   95000, 2),
(8, 'Pooja',   90000, 2),
(9, 'Vikas',   85000, 2),
(10,'Anjali',  85000, 2),
(11,'Nitin',   80000, 2),

-- Finance Department
(12,'Arjun',  150000, 3),
(13,'Megha',  140000, 3),
(14,'Sonia',  130000, 3),
(15,'Deepak', 120000, 3),
(16,'Ravi',   130000, 3);

/* Q8 :The cancellation rate is computed by dividing the number of canceled (by client or driver) requests 
with unbanned usersby the total number of requests with unbanned users on that day.
Write a solution to find the cancellation rate of requests with unbanned users (both client and driver must not be banned)
 each day between "2013-10-01" and "2013-10-03" with at least one trip. Round Cancellation Rate to two decimal points.*/

 CREATE TABLE Users08 (
    users_id INT PRIMARY KEY,
    banned VARCHAR(3),
    role VARCHAR(10)
);

CREATE TABLE Trips08 (
    id INT PRIMARY KEY,
    client_id INT,
    driver_id INT,
    city_id INT,
    status VARCHAR(30),
    request_at DATE
);

INSERT INTO Users08 VALUES
(1, 'No', 'client'),
(2, 'Yes', 'client'),
(3, 'No', 'client'),
(4, 'No', 'client'),
(10, 'No', 'driver'),
(11, 'No', 'driver'),
(12, 'No', 'driver'),
(13, 'No', 'driver');

INSERT INTO Trips08 VALUES
(1, 1, 10, 1, 'completed', '2013-10-01'),
(2, 2, 11, 1, 'cancelled_by_driver', '2013-10-01'),
(3, 3, 12, 6, 'completed', '2013-10-01'),
(4, 4, 13, 6, 'cancelled_by_client', '2013-10-01'),
(5, 1, 10, 1, 'completed', '2013-10-02'),
(6, 2, 11, 6, 'completed', '2013-10-02'),
(7, 3, 12, 6, 'completed', '2013-10-02'),
(8, 2, 12, 12, 'completed', '2013-10-03'),
(9, 3, 10, 12, 'completed', '2013-10-03'),
(10, 4, 13, 12, 'cancelled_by_driver', '2013-10-03');


/*Q9:Write a solution to display the records with three or more rows with consecutive id's,and the number of people 
is greater than or equal to 100 for each.*/
CREATE TABLE Stadium09 (
    id INT PRIMARY KEY,
    visit_date DATE,
    people INT
);
INSERT INTO Stadium09 (id, visit_date, people) VALUES
(1, '2017-01-01', 10),
(2, '2017-01-02', 109),
(3, '2017-01-03', 150),
(4, '2017-01-04', 99),
(5, '2017-01-05', 145),
(6, '2017-01-06', 1455),
(7, '2017-01-07', 199),
(8, '2017-01-08', 188);


#Q10:Write a solution to find the people who have the most friends and the most friends number
CREATE TABLE RequestAccepted10 (
    requester_id INT,
    accepter_id INT,
    accept_date DATE,
    PRIMARY KEY (requester_id, accepter_id)
);

INSERT INTO RequestAccepted10 VALUES
(1, 2, '2024-01-01'),
(1, 3, '2024-01-02'),
(1, 4, '2024-01-03'),

(2, 3, '2024-01-04'),
(2, 5, '2024-01-05'),

(3, 4, '2024-01-06'),
(3, 5, '2024-01-07'),

(4, 5, '2024-01-08'),

(6, 1, '2024-01-09'),
(7, 1, '2024-01-10');



