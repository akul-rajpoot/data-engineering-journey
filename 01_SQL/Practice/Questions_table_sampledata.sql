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


#Q11:Write a solution to report the name and balance of users with a balance higher than 10000. 
#The balance of an account is equal to the sum of the amounts of all transactions involving that account.

CREATE TABLE Users11 (
    account INT PRIMARY KEY,
    name VARCHAR(50)
);


CREATE TABLE Transactions11 (
    trans_id INT PRIMARY KEY,
    account INT,
    amount INT,
    transacted_on DATE
);

INSERT INTO Users11 VALUES
(9001, 'Amit'),
(9002, 'Neha'),
(9003, 'Raj'),
(9004, 'Priya'),
(9005, 'Karan');

INSERT INTO Transactions11 VALUES
(1, 9001, 5000, '2024-01-01'),
(2, 9001, 7000, '2024-01-10'),

(3, 9002, 8000, '2024-01-02'),
(4, 9002, -2000, '2024-01-15'),

(5, 9003, 15000, '2024-01-03'),
(6, 9003, -3000, '2024-01-20'),

(7, 9004, 6000, '2024-01-05'),
(8, 9004, 4000, '2024-01-25'),

(9, 9005, 12000, '2024-01-06'),
(10, 9005, -5000, '2024-01-28');


#Q12:Write a solution to calculate the total time in minutes spent by each employee on each day at the office.
CREATE TABLE Employees12 (
    emp_id INT,
    event_day DATE,
    in_time INT,
    out_time INT
);
INSERT INTO Employees12 VALUES
(1, '2024-01-01', 9, 12),
(1, '2024-01-01', 13, 17),

(1, '2024-01-02', 10, 15),

(2, '2024-01-01', 8, 11),
(2, '2024-01-01', 12, 16),

(2, '2024-01-02', 9, 18),

(3, '2024-01-01', 10, 12),
(3, '2024-01-01', 14, 18),

(3, '2024-01-03', 8, 17);

#Q13:Write a solution to report the latest login for all users in the year 2020. Do not include the users who did not login in 2020.
CREATE TABLE Logins13 (
    user_id INT,
    time_stamp DATETIME
);

INSERT INTO Logins13 VALUES
(1, '2020-01-15 08:00:00'),
(1, '2020-06-10 09:15:00'),
(1, '2020-12-31 23:59:59'),

(2, '2020-03-05 10:30:00'),

(3, '2019-12-31 23:50:00'),
(3, '2020-01-01 00:05:00'),
(3, '2020-07-20 14:00:00'),

(4, '2021-01-01 09:00:00'),

(5, '2020-02-14 11:00:00'),
(5, '2020-02-14 18:00:00'),
(5, '2020-11-25 20:00:00');

/*Q:14
Write a solution to find all the valid email addresses. A valid email address meets the following criteria:
It contains exactly one @ symbol.
It ends with .com.
The part before the @ symbol contains only alphanumeric characters and underscores.
The part after the @ symbol and before .com contains a domain name that contains only letters.
*/

CREATE TABLE Users14 (
    user_id INT,
    email VARCHAR(100),
    PRIMARY KEY (user_id)
);
INSERT INTO Users14 VALUES
(1, 'alice@example.com'),
(2, 'bob@gmail.com'),
(3, 'charlie@yahoo.com'),
(4, 'david@leetcode.com'),
(5, 'eve@gmail.com'),
(6, 'frank@example.com'),
(7, 'grace@outlookcom'),
(8, 'invalid_email'),
(9, 'john.doe@gmail.com'),
(10, 'test@leetcode');

/*Q15: There is a queue of people waiting to board a bus. However, the bus has a weight limit of 1000 kilograms, 
so there may be some people who cannot board.
Write a solution to find the person_name of the last person that can fit on the bus without exceeding the weight limit. 
The test cases are generated such that the first person does not exceed the weight limit.*/

CREATE TABLE Queue15 (
    person_id INT,
    person_name VARCHAR(50),
    weight INT,
    turn INT
);

INSERT INTO Queue15 (person_id, person_name, weight, turn) VALUES
(5, 'Alice', 250, 1),
(4, 'Bob', 175, 5),
(3, 'Alex', 350, 2),
(6, 'John Cena', 400, 3),
(1, 'Winston', 500, 6),
(2, 'Marie', 200, 4);

/*Q16:Write a solution to find all products whose description contains a valid serial number pattern. A valid serial number follows these rules:
It starts with the letters SN (case-sensitive).
Followed by exactly 4 digits.
It must have a hyphen (-) followed by exactly 4 digits.
The serial number must be within the description (it may not necessarily start at the beginning).*/

CREATE TABLE Products16 (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    description VARCHAR(255)
);

INSERT INTO Products16 VALUES
(1, 'Widget A', 'This is a sample product with SN1234-5678'),
(2, 'Widget B', 'A product with serial SN9876-1234 in the description'),
(3, 'Widget C', 'Product SN1234-56789 is available now'),
(4, 'Widget D', 'No serial number here'),
(5, 'Widget E', 'Check out SN4321-8765 in this description');

/*Q17:Write a solution to find the sum of amounts for odd and even transactions for each day. If there are no odd or even 
transactions for a specific date, display as 0.*/

CREATE TABLE transactions17 (
    transaction_id INT PRIMARY KEY,
    amount INT,
    transaction_date DATE
);
INSERT INTO transactions17 VALUES
(1, 150, '2024-07-01'),
(2, 200, '2024-07-01'),
(3, 75,  '2024-07-01'),
(4, 300, '2024-07-02'),
(5, 50,  '2024-07-02'),
(6, 120, '2024-07-03');


/*Q18: Write a solution to find the students who have shown improvement. A student is considered to have shown 
improvement if they meet both of these conditions:
Have taken exams in the same subject on at least two different dates
Their latest score in that subject is higher than their first score
*/

CREATE TABLE Scores18 (
    student_id INT,
    subject VARCHAR(50),
    score INT,
    exam_date DATE,
    PRIMARY KEY (student_id, subject, exam_date)
);

INSERT INTO Scores18 VALUES
(101, 'Math',    70, '2023-01-15'),
(101, 'Math',    85, '2023-02-15'),
(101, 'Math',    50, '2022-12-15'),
(101, 'Physics', 65, '2023-01-15'),
(101, 'Physics', 60, '2023-02-15'),
(102, 'Math',    80, '2023-01-15'),
(102, 'Math',    85, '2023-02-15'),
(103, 'Math',    90, '2023-01-15'),
(104, 'Physics', 75, '2023-01-15'),
(104, 'Physics', 85, '2023-02-15');



#Q19:Write a solution to report the Capital gain/loss for each stock.

CREATE TABLE Stocks19 (
    stock_name VARCHAR(50),
    operation ENUM('Buy','Sell'),
    operation_day INT,
    price INT
);

INSERT INTO Stocks19 VALUES
('Leetcode','Buy',1,1000),
('Corona Masks','Buy',2,10),
('Leetcode','Sell',5,9000),
('Handbags','Buy',17,30000),
('Corona Masks','Sell',3,1010),
('Corona Masks','Buy',4,1000),
('Corona Masks','Sell',5,500),
('Corona Masks','Buy',6,1000),
('Handbags','Sell',29,7000),
('Corona Masks','Sell',10,10000);

/*Q20:Write a solution to:
Find users who converted from free trial to paid subscription
Calculate each user's average daily activity duration during their free trial period (rounded to 2 decimal places)
Calculate each user's average daily activity duration during their paid subscription period (rounded to 2 decimal places)
Return the result table ordered by user_id in ascending order.
The result format is in the following example.
*/
CREATE TABLE UserActivity20 (
    user_id INT,
    activity_date DATE,
    activity_type VARCHAR(20),
    activity_duration INT
);

INSERT INTO UserActivity20 VALUES
(1,'2023-01-01','free_trial',45),
(1,'2023-01-02','free_trial',30),
(1,'2023-01-05','free_trial',60),
(1,'2023-01-10','paid',75),
(1,'2023-01-12','paid',90),
(1,'2023-01-15','paid',65),

(2,'2023-02-01','free_trial',55),
(2,'2023-02-03','free_trial',25),
(2,'2023-02-07','free_trial',50),
(2,'2023-02-10','cancelled',0),

(3,'2023-03-05','free_trial',70),
(3,'2023-03-06','free_trial',60),
(3,'2023-03-08','free_trial',80),
(3,'2023-03-12','paid',50),
(3,'2023-03-15','paid',55),
(3,'2023-03-20','paid',85),

(4,'2023-04-01','free_trial',40),
(4,'2023-04-03','free_trial',35),
(4,'2023-04-05','paid',45),
(4,'2023-04-07','cancelled',0);




