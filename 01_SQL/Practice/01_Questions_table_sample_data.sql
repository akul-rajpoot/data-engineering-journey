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

/*Q21:Write a solution to find all books that are currently borrowed (not returned) and have zero copies available
 in the library.A book is considered currently borrowed if there exists a borrowing record with a NULL return_date*/
CREATE TABLE library_books21 (
    book_id INT PRIMARY KEY,
    title VARCHAR(100),
    author VARCHAR(100),
    genre VARCHAR(50),
    publication_year INT,
    total_copies INT
);

CREATE TABLE borrowing_records21 (
    record_id INT PRIMARY KEY,
    book_id INT,
    borrower_name VARCHAR(100),
    borrow_date DATE,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES library_books21(book_id)
);

INSERT INTO library_books21 VALUES
(1, 'The Great Gatsby', 'F. Scott', 'Fiction', 1925, 3),
(2, 'To Kill a Mockingbird', 'Harper Lee', 'Fiction', 1960, 3),
(3, '1984', 'George Orwell', 'Dystopian', 1949, 1),
(4, 'Pride and Prejudice', 'Jane Austen', 'Romance', 1813, 2),
(5, 'The Catcher in the Rye', 'J.D. Salinger', 'Fiction', 1951, 1),
(6, 'Brave New World', 'Aldous Huxley', 'Dystopian', 1932, 4);

INSERT INTO borrowing_records21 VALUES
(1, 1, 'Alice Smith', '2024-01-15', NULL),
(2, 1, 'Bob Johnson', '2024-01-20', NULL),
(3, 2, 'Carol White', '2024-01-10', '2024-01-25'),
(4, 3, 'David Brown', '2024-02-01', NULL),
(5, 4, 'Emma Wilson', '2024-01-05', NULL),
(6, 5, 'Frank Davis', '2024-01-18', '2024-02-10'),
(7, 1, 'Grace Miller', '2024-02-05', NULL),
(8, 6, 'Henry Taylor', '2024-01-12', NULL),
(9, 2, 'Ivan Clark', '2024-02-12', NULL),
(10, 2, 'Jane Adams', '2024-02-15', NULL);


/*Q22: Write a solution to analyze AI prompt usage patterns based on the following requirements:
Only include users who have submitted at least 3 prompts.
Only include users who have submitted at least one prompt with tokens greater than their own average token usage.
*/
CREATE TABLE prompts22 (
    user_id INT,
    prompt VARCHAR(255),
    tokens INT
);
INSERT INTO prompts22 VALUES
(1, 'Write a blog outline', 120),
(1, 'Generate SQL query', 80),
(1, 'Summarize an article', 200),

(2, 'Create resume bullet', 60),
(2, 'Improve LinkedIn bio', 70),

(3, 'Explain neural networks', 300),
(3, 'Generate interview Q&A', 250),
(3, 'Write cover letter', 180),
(3, 'Optimize Python code', 220);

/*Q23:Identify distinct product pairs frequently purchased together by the same customers (where product1_id < product2_id)
For each product pair, determine how many customers purchased both products
A product pair is considered for recommendation if at least 3 different customers have purchased both products.*/

CREATE TABLE ProductInfo23 (
    product_id INT PRIMARY KEY,
    category VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE ProductPurchases23 (
    user_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (product_id) REFERENCES ProductInfo23(product_id)
);

INSERT INTO ProductInfo23 VALUES
(101, 'Electronics', 100),
(102, 'Books', 20),
(103, 'Clothing', 35),
(104, 'Kitchen', 50),
(105, 'Sports', 75);

INSERT INTO ProductPurchases23 VALUES
(1, 101, 2),
(1, 102, 1),
(1, 103, 3),

(2, 101, 1),
(2, 102, 5),
(2, 104, 1),

(3, 101, 2),
(3, 103, 1),
(3, 105, 4),

(4, 101, 1),
(4, 102, 1),
(4, 103, 2),
(4, 104, 3),

(5, 102, 2),
(5, 104, 1);


/*Q24: Write a solution to identify emotionally consistent users based on the following requirements:
For each user, count the total number of reactions they have given.
Only include users who have reacted to at least 5 different content items.
A user is considered emotionally consistent if at least 60% of their reactions are of the same type.
*/
CREATE TABLE reactions24 (
    user_id INT,
    content_id INT,
    reaction VARCHAR(20)
);
INSERT INTO reactions24 VALUES
(1, 101, 'like'),
(1, 102, 'like'),
(1, 103, 'like'),
(1, 104, 'wow'),
(1, 105, 'like'),

(2, 201, 'like'),
(2, 202, 'wow'),
(2, 203, 'sad'),
(2, 204, 'like'),
(2, 205, 'wow'),

(3, 301, 'love'),
(3, 302, 'love'),
(3, 303, 'love'),
(3, 304, 'love'),
(3, 305, 'love');

/*Q25:Write a solution to find employees who have consistently improved their performance over their last three reviews.
An employee must have at least 3 review to be considered
The employee's last 3 reviews must show strictly increasing ratings (each review better than the previous)
Use the most recent 3 reviews based on review_date for each employee
Calculate the improvement score as the difference between the latest rating and the earliest rating among the last 3 reviews
*/

CREATE TABLE employees25 (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE performance_reviews25 (
    review_id INT PRIMARY KEY,
    employee_id INT,
    review_date DATE,
    rating INT,
    FOREIGN KEY (employee_id) REFERENCES employees25(employee_id)
);

INSERT INTO employees25 VALUES
(1, 'Alice Johnson'),
(2, 'Bob Smith'),
(3, 'Carol Davis'),
(4, 'David Wilson'),
(5, 'Emma Brown');

INSERT INTO performance_reviews25 VALUES
(1, 1, '2023-01-15', 2),
(2, 1, '2023-04-15', 3),
(3, 1, '2023-07-15', 4),
(4, 1, '2023-10-15', 5),

(5, 2, '2023-02-01', 3),
(6, 2, '2023-05-01', 2),
(7, 2, '2023-08-01', 4),
(8, 2, '2023-11-01', 5),

(9, 3, '2023-03-10', 1),
(10, 3, '2023-06-10', 2),
(11, 3, '2023-09-10', 3),
(12, 3, '2023-12-10', 4),

(13, 4, '2023-01-20', 4),
(14, 4, '2023-04-20', 4),
(15, 4, '2023-07-20', 4),

(16, 5, '2023-02-15', 3),
(17, 5, '2023-05-15', 2);

/*Q26: find golden hour customers 
Made at least 3 orders.
At least 60% of their orders are during peak hours (11:00-14:00 or 18:00-21:00).
Their average rating for rated orders is at least 4.0, round it to 2 decimal places.
Have rated at least 50% of their orders.*/

CREATE TABLE restaurant_orders26 (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_timestamp DATETIME,
    order_amount DECIMAL(10,2),
    payment_method VARCHAR(20),
    order_rating INT
);
INSERT INTO restaurant_orders26 VALUES
(1, 101, '2024-03-01 12:30:00', 25.50, 'card', 5),
(2, 101, '2024-03-02 19:15:00', 32.00, 'app', 4),
(3, 101, '2024-03-03 13:45:00', 28.75, 'card', 5),
(4, 101, '2024-03-04 20:30:00', 41.00, 'app', NULL),

(5, 102, '2024-03-01 11:30:00', 18.50, 'cash', 4),
(6, 102, '2024-03-02 12:00:00', 22.00, 'card', 3),
(7, 102, '2024-03-03 15:30:00', 19.75, 'cash', NULL),

(8, 103, '2024-03-01 19:00:00', 55.00, 'app', 5),
(9, 103, '2024-03-02 20:45:00', 48.50, 'app', 4),
(10, 103, '2024-03-03 18:30:00', 62.00, 'card', 5),

(11, 104, '2024-03-01 10:00:00', 15.00, 'cash', 3),
(12, 104, '2024-03-02 09:30:00', 18.00, 'cash', 2),
(13, 104, '2024-03-03 16:00:00', 20.00, 'card', 3),

(14, 105, '2024-03-01 12:15:00', 30.00, 'app', 4),
(15, 105, '2024-03-02 13:00:00', 35.50, 'app', 5),
(16, 105, '2024-03-03 11:45:00', 28.00, 'card', 4);

#Q27:Write a solution to find loyal customers
#-Made at least 3 purchase transactions.
#-Have been active for at least 30 days.
#-Their refund rate is less than 20%

CREATE TABLE customer_transactions27 (
    transaction_id INT PRIMARY KEY,
    customer_id INT,
    transaction_date DATE,
    amount DECIMAL(10,2),
    transaction_type VARCHAR(20)
);

INSERT INTO customer_transactions27 VALUES
(1, 101, '2024-01-05', 150.00, 'purchase'),
(2, 101, '2024-01-15', 200.00, 'purchase'),
(3, 101, '2024-02-10', 180.00, 'purchase'),
(4, 101, '2024-02-20', 250.00, 'purchase'),

(5, 102, '2024-01-10', 100.00, 'purchase'),
(6, 102, '2024-01-12', 120.00, 'purchase'),
(7, 102, '2024-01-15', 80.00, 'refund'),
(8, 102, '2024-01-18', 90.00, 'refund'),
(9, 102, '2024-02-15', 130.00, 'purchase'),

(10, 103, '2024-01-01', 500.00, 'purchase'),
(11, 103, '2024-01-02', 450.00, 'purchase'),
(12, 103, '2024-01-03', 400.00, 'purchase'),

(13, 104, '2024-01-01', 200.00, 'purchase'),
(14, 104, '2024-02-01', 250.00, 'purchase'),
(15, 104, '2024-02-15', 300.00, 'purchase'),
(16, 104, '2024-03-01', 350.00, 'purchase'),
(17, 104, '2024-03-10', 280.00, 'purchase'),
(18, 104, '2024-03-15', 100.00, 'refund');

/*Q28:Write a solution to find the most popular product category for each season. The seasons are defined as:
Winter: December, January, February
Spring: March, April, May
Summer: June, July, August
Fall: September, October, November
The popularity of a category is determined by the total quantity sold in that season. If there is a tie, 
select the category with the highest total revenue (quantity × price). If there is still a tie, 
return the lexicographically smaller category.
*/
CREATE TABLE products28 (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50)
);

CREATE TABLE sales28 (
    sale_id INT PRIMARY KEY,
    product_id INT,
    sale_date DATE,
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (product_id) REFERENCES products28(product_id)
);

INSERT INTO products28 VALUES
(1, 'Warm Jacket', 'Apparel'),
(2, 'Designer Jeans', 'Apparel'),
(3, 'Cutting Board', 'Kitchen'),
(4, 'Smart Speaker', 'Tech'),
(5, 'Yoga Mat', 'Fitness');

INSERT INTO sales28 VALUES
(1, 1, '2023-01-15', 5, 10.00),
(2, 2, '2023-01-20', 4, 15.00),
(3, 3, '2023-03-10', 3, 18.00),
(4, 4, '2023-04-05', 1, 20.00),
(5, 1, '2023-05-20', 2, 10.00),
(6, 2, '2023-06-12', 4, 15.00),
(7, 5, '2023-06-15', 5, 12.00),
(8, 3, '2023-07-24', 2, 18.00),
(9, 4, '2023-08-01', 5, 20.00),
(10, 5, '2023-09-03', 3, 12.00),
(11, 1, '2023-09-25', 6, 10.00),
(12, 2, '2023-11-10', 4, 15.00),
(13, 3, '2023-12-05', 6, 18.00),
(14, 4, '2023-12-22', 3, 20.00),
(15, 5, '2024-02-14', 2, 12.00);




/*29:Write a solution to find patients who have recovered from COVID
-A patient is considered recovered if they have at least one Positive test followed by at least one Negative 
test on a later date
-Calculate the recovery time in days as the difference between the first positive test and the first negative test after that positive test
-Only include patients who have both positive and negative test results
*/

CREATE TABLE patients29 (
    patient_id INT PRIMARY KEY,
    patient_name VARCHAR(100),
    age INT
);

CREATE TABLE covid_tests29 (
    test_id INT PRIMARY KEY,
    patient_id INT,
    test_date DATE,
    result VARCHAR(20),
    FOREIGN KEY (patient_id) REFERENCES patients29(patient_id)
);
INSERT INTO patients29 VALUES
(1, 'Alice Smith', 28),
(2, 'Bob Johnson', 35),
(3, 'Carol Davis', 42),
(4, 'David Wilson', 31),
(5, 'Emma Brown', 29);

INSERT INTO covid_tests29 VALUES
(1, 1, '2023-01-15', 'Positive'),
(2, 1, '2023-01-25', 'Negative'),

(3, 2, '2023-02-01', 'Positive'),
(4, 2, '2023-02-05', 'Inconclusive'),
(5, 2, '2023-02-12', 'Negative'),

(6, 3, '2023-01-20', 'Negative'),
(7, 3, '2023-02-10', 'Positive'),
(8, 3, '2023-02-20', 'Negative'),

(9, 4, '2023-01-10', 'Positive'),
(10, 4, '2023-01-18', 'Positive'),

(11, 5, '2023-02-15', 'Negative'),
(12, 5, '2023-02-20', 'Negative');

/*Q30:Write a solution to find stores that have inventory imbalance
For each store, identify the most expensive product (highest price) and its quantity
For each store, identify the cheapest product (lowest price) and its quantity
A store has inventory imbalance if the most expensive product's quantity is less than the cheapest product's quantity
Calculate the imbalance ratio as (cheapest_quantity / most_expensive_quantity)
Round the imbalance ratio to 2 decimal places
Only include stores that have at least 3 different products
*/

CREATE TABLE stores30 (
    store_id INT PRIMARY KEY,
    store_name VARCHAR(100),
    location VARCHAR(100)
);

CREATE TABLE inventory30 (
    inventory_id INT PRIMARY KEY,
    store_id INT,
    product_name VARCHAR(100),
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (store_id) REFERENCES stores30(store_id)
);

INSERT INTO stores30 VALUES
(1, 'Downtown Tech', 'New York'),
(2, 'Suburb Mall', 'Chicago'),
(3, 'City Center', 'Los Angeles'),
(4, 'Corner Shop', 'Miami'),
(5, 'Plaza Store', 'Seattle');

INSERT INTO inventory30 VALUES
(1, 1, 'Laptop', 5, 999.99),
(2, 1, 'Mouse', 50, 19.99),
(3, 1, 'Keyboard', 25, 79.99),
(4, 1, 'Monitor', 15, 299.99),

(5, 2, 'Phone', 3, 699.99),
(6, 2, 'Charger', 100, 25.99),
(7, 2, 'Case', 75, 15.99),
(8, 2, 'Headphones', 20, 149.99),

(9, 3, 'Tablet', 2, 499.99),
(10, 3, 'Stylus', 80, 29.99),
(11, 3, 'Cover', 60, 39.99),

(12, 4, 'Watch', 10, 299.99),
(13, 4, 'Band', 25, 49.99),

(14, 5, 'Camera', 8, 599.99),
(15, 5, 'Lens', 12, 199.99);



 /*Q31: Write a solution to find drivers whose fuel efficiency has improved by comparing their 
 average fuel efficiency in the first half of the year with the second half of the year.
Calculate fuel efficiency as distance_km / fuel_consumed for each trip
First half: January to June, Second half: July to December
Only include drivers who have trips in both halves of the year
Calculate the efficiency improvement as (second_half_avg - first_half_avg)
Round all results to 2 decimal places
*/
CREATE TABLE drivers31 (
    driver_id INT PRIMARY KEY,
    driver_name VARCHAR(100)
);

CREATE TABLE trips31 (
    trip_id INT PRIMARY KEY,
    driver_id INT,
    trip_date DATE,
    distance_km DECIMAL(10,2),
    fuel_consumed DECIMAL(10,2),
    FOREIGN KEY (driver_id) REFERENCES drivers31(driver_id)
);

INSERT INTO drivers31 VALUES
(1, 'Alice Johnson'),
(2, 'Bob Smith'),
(3, 'Carol Davis'),
(4, 'David Wilson'),
(5, 'Emma Brown');

INSERT INTO trips31 VALUES
(1, 1, '2023-02-15', 120.5, 10.2),
(2, 1, '2023-03-20', 200.0, 16.5),
(3, 1, '2023-08-10', 150.0, 11.0),
(4, 1, '2023-09-25', 180.0, 12.5),

(5, 2, '2023-01-10', 100.0, 9.0),
(6, 2, '2023-04-15', 250.0, 22.0),
(7, 2, '2023-10-05', 200.0, 15.0),

(8, 3, '2023-03-12', 80.0, 8.5),
(9, 3, '2023-05-18', 90.0, 9.2),

(10, 4, '2023-07-22', 160.0, 12.8),
(11, 4, '2023-11-30', 140.0, 11.0),

(12, 5, '2023-02-28', 110.0, 11.5);

/*Q32: Write a solution to find books that have polarized opinions - books that receive both very high ratings and very low ratings from different readers.

A book has polarized opinions if it has at least one rating ≥ 4 and at least one rating ≤ 2
Only consider books that have at least 5 reading sessions
Calculate the rating spread as (highest_rating - lowest_rating)
Calculate the polarization score as the number of extreme ratings (ratings ≤ 2 or ≥ 4) divided by total sessions
Only include books where polarization score ≥ 0.6 (at least 60% extreme ratings)
*/


CREATE TABLE books32 (
    book_id INT PRIMARY KEY,
    title VARCHAR(100),
    author VARCHAR(100),
    genre VARCHAR(50),
    pages INT
);

CREATE TABLE reading_sessions32 (
    session_id INT PRIMARY KEY,
    book_id INT,
    reader_name VARCHAR(100),
    pages_read INT,
    session_rating INT,
    FOREIGN KEY (book_id) REFERENCES books32(book_id)
);

INSERT INTO books32 VALUES
(1,'The Great Gatsby','F. Scott','Fiction',180),
(2,'To Kill a Mockingbird','Harper Lee','Fiction',281),
(3,'1984','George Orwell','Dystopian',328),
(4,'Pride and Prejudice','Jane Austen','Romance',432),
(5,'The Catcher in the Rye','J.D. Salinger','Fiction',277);

INSERT INTO reading_sessions32 VALUES
(1,1,'Alice',50,5),
(2,1,'Bob',60,1),
(3,1,'Carol',40,4),
(4,1,'David',30,2),
(5,1,'Emma',45,5),
(6,2,'Frank',80,4),
(7,2,'Grace',70,4),
(8,2,'Henry',90,5),
(9,2,'Ivy',60,4),
(10,2,'Jack',75,4),
(11,3,'Kate',100,2),
(12,3,'Liam',120,1),
(13,3,'Mia',80,2),
(14,3,'Noah',90,1),
(15,3,'Olivia',110,4),
(16,3,'Paul',95,5),
(17,4,'Quinn',150,3),
(18,4,'Ruby',140,3),
(19,5,'Sam',80,1),
(20,5,'Tara',70,2);

/*Q33: Write a solution to find employees who are meeting-heavy - employees who spend more than 50% of their working time in meetings during any given week.

Assume a standard work week is 40 hours
Calculate total meeting hours per employee per week (Monday to Sunday)
An employee is meeting-heavy if their weekly meeting hours > 20 hours (50% of 40 hours)
Count how many weeks each employee was meeting-heavy
Only include employees who were meeting-heavy for at least 2 weeks
*/
CREATE TABLE employees33 (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    department VARCHAR(50)
);

CREATE TABLE meetings33 (
    meeting_id INT PRIMARY KEY,
    employee_id INT,
    meeting_date DATE,
    meeting_type VARCHAR(50),
    duration_hours DECIMAL(5,2),
    FOREIGN KEY (employee_id) REFERENCES employees33(employee_id)
);

INSERT INTO employees33 VALUES
(1, 'Alice Johnson', 'Engineering'),
(2, 'Bob Smith', 'Marketing'),
(3, 'Carol Davis', 'Sales'),
(4, 'David Wilson', 'Engineering'),
(5, 'Emma Brown', 'HR');

INSERT INTO meetings33 VALUES
(1, 1, '2023-06-05', 'Team', 8.0),
(2, 1, '2023-06-06', 'Client', 6.0),
(3, 1, '2023-06-07', 'Training', 7.0),
(4, 1, '2023-06-12', 'Team', 12.0),
(5, 1, '2023-06-13', 'Client', 9.0),

(6, 2, '2023-06-05', 'Team', 15.0),
(7, 2, '2023-06-06', 'Client', 8.0),
(8, 2, '2023-06-12', 'Training', 10.0),

(9, 3, '2023-06-05', 'Team', 4.0),
(10, 3, '2023-06-06', 'Client', 3.0),

(11, 4, '2023-06-05', 'Team', 25.0),
(12, 4, '2023-06-19', 'Client', 22.0),

(13, 5, '2023-06-05', 'Training', 2.0);

/*Q34:Write a solution to identify skill mastery pathways by analyzing course completion sequences among 
top-performing students:
Consider only top-performing students (those who completed at least 5 courses with an average rating of 4 or 
higher).
For each top performer, identify the sequence of courses they completed in chronological order.
Find all consecutive course pairs (Course A → Course B) taken by these students.
Return the pair frequency, identifying which course transitions are most common among high achievers.
*/
CREATE TABLE course_completions34 (
    user_id INT,
    course_id INT,
    course_name VARCHAR(100),
    completion_date DATE,
    course_rating INT
);

INSERT INTO course_completions34 VALUES
(1,101,'Python Basics','2024-01-05',5),
(1,102,'SQL Fundamentals','2024-02-10',4),
(1,103,'JavaScript','2024-03-15',5),
(1,104,'React Basics','2024-04-20',4),
(1,105,'Node.js','2024-05-25',5),
(1,106,'Docker','2024-06-30',4),

(2,101,'Python Basics','2024-01-08',4),
(2,104,'React Basics','2024-02-14',5),
(2,105,'Node.js','2024-03-20',4),
(2,106,'Docker','2024-04-25',5),
(2,107,'AWS Fundamentals','2024-05-30',4),

(3,101,'Python Basics','2024-01-10',3),
(3,102,'SQL Fundamentals','2024-02-12',3),
(3,103,'JavaScript','2024-03-18',3),
(3,104,'React Basics','2024-04-22',2),
(3,105,'Node.js','2024-05-28',3),

(4,101,'Python Basics','2024-01-12',5),
(4,108,'Data Science','2024-02-16',5),
(4,109,'Machine Learning','2024-03-22',5);


/*Q35: Amazon wants to understand shopping patterns across product categories. Write a solution to:
Find all category pairs (where category1 < category2)
For each category pair, determine the number of unique customers who purchased products from both categories
A category pair is considered reportable if at least 3 different customers have purchased products from both 
categories.
*/
CREATE TABLE ProductInfo35 (
    product_id INT PRIMARY KEY,
    category VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE ProductPurchases35 (
    user_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (product_id) REFERENCES ProductInfo35(product_id)
);

INSERT INTO ProductInfo35 VALUES
(101, 'Electronics', 100),
(102, 'Books', 20),
(103, 'Books', 35),
(201, 'Clothing', 45),
(202, 'Clothing', 60),
(301, 'Sports', 75),
(401, 'Kitchen', 50);

INSERT INTO ProductPurchases35 VALUES
(1, 101, 2),
(1, 102, 1),
(1, 201, 3),
(1, 301, 1),

(2, 101, 1),
(2, 102, 2),
(2, 103, 1),
(2, 201, 5),

(3, 101, 2),
(3, 103, 1),
(3, 301, 4),
(3, 401, 2),

(4, 101, 1),
(4, 201, 3),
(4, 301, 1),
(4, 401, 2),

(5, 102, 2),
(5, 103, 1),
(5, 201, 2),
(5, 202, 3);


/*Q36:Write a solution to identify behaviorally stable users based on the following definition:
A user is considered behaviorally stable if there exists a sequence of at least 5 consecutive days such that:
The user performed exactly one action per day during that period.
The action is the same on all those consecutive days.
If a user has multiple qualifying sequences, only consider the sequence with the maximum length.
*/

CREATE TABLE activity36 (
    user_id INT,
    action_date DATE,
    action VARCHAR(20)
);

INSERT INTO activity36 VALUES
(1, '2024-01-01', 'login'),
(1, '2024-01-02', 'login'),
(1, '2024-01-03', 'login'),
(1, '2024-01-04', 'login'),
(1, '2024-01-05', 'login'),
(1, '2024-01-06', 'logout'),

(2, '2024-01-01', 'click'),
(2, '2024-01-02', 'click'),
(2, '2024-01-03', 'click'),
(2, '2024-01-04', 'click'),

(3, '2024-01-01', 'view'),
(3, '2024-01-02', 'view'),
(3, '2024-01-03', 'view'),
(3, '2024-01-04', 'view'),
(3, '2024-01-05', 'view'),
(3, '2024-01-06', 'view'),
(3, '2024-01-07', 'view');

/*Q37:Write a solution to find students who follow the Study Spiral Pattern - students who consistently study multiple subjects in a rotating cycle.

A Study Spiral Pattern means a student studies at least 3 different subjects in a repeating sequence
The pattern must repeat for at least 2 complete cycles (minimum 6 study sessions)
Sessions must be consecutive dates with no gaps longer than 2 days between sessions
Calculate the cycle length (number of different subjects in the pattern)
Calculate the total study hours across all sessions in the pattern
Only include students with cycle length of at least 3 subjects
*/



CREATE TABLE students37 (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100),
    major VARCHAR(100)
);

CREATE TABLE study_sessions37 (
    session_id INT PRIMARY KEY,
    student_id INT,
    subject VARCHAR(100),
    session_date DATE,
    hours_studied DECIMAL(4,1),
    FOREIGN KEY (student_id) REFERENCES students37(student_id)
);

INSERT INTO students37 VALUES
(1, 'Alice Chen', 'Computer Science'),
(2, 'Bob Johnson', 'Mathematics'),
(3, 'Carol Davis', 'Physics'),
(4, 'David Wilson', 'Chemistry'),
(5, 'Emma Brown', 'Biology');

INSERT INTO study_sessions37 VALUES
(1, 1, 'Math', '2023-10-01', 2.5),
(2, 1, 'Physics', '2023-10-02', 3.0),
(3, 1, 'Chemistry', '2023-10-03', 2.0),
(4, 1, 'Math', '2023-10-04', 2.5),
(5, 1, 'Physics', '2023-10-05', 3.0),
(6, 1, 'Chemistry', '2023-10-06', 2.0),

(7, 2, 'Algebra', '2023-10-01', 4.0),
(8, 2, 'Calculus', '2023-10-02', 3.5),
(9, 2, 'Statistics', '2023-10-03', 2.5),
(10, 2, 'Geometry', '2023-10-04', 3.0),
(11, 2, 'Algebra', '2023-10-05', 4.0),
(12, 2, 'Calculus', '2023-10-06', 3.5),
(13, 2, 'Statistics', '2023-10-07', 2.5),
(14, 2, 'Geometry', '2023-10-08', 3.0),

(15, 3, 'Biology', '2023-10-01', 2.0),
(16, 3, 'Chemistry', '2023-10-02', 2.5),
(17, 3, 'Biology', '2023-10-03', 2.0),
(18, 3, 'Chemistry', '2023-10-04', 2.5),

(19, 4, 'Organic', '2023-10-01', 3.0),
(20, 4, 'Physical', '2023-10-05', 2.5);


/*Q38:Write a solution to identify zombie sessions, sessions where users appear active but show abnormal behavior patterns.
A session is considered a zombie session if it meets ALL the following criteria:
The session duration is more than 30 minutes.
Has at least 5 scroll events.
The click-to-scroll ratio is less than 0.20 .
No purchases were made during the session.
*/


CREATE TABLE app_events38 (
    event_id INT PRIMARY KEY,
    user_id INT,
    event_timestamp DATETIME,
    event_type VARCHAR(20),
    session_id VARCHAR(10),
    event_value INT
);

INSERT INTO app_events38 VALUES
(1, 201, '2024-03-01 10:00:00', 'app_open',  'S001', NULL),
(2, 201, '2024-03-01 10:05:00', 'scroll',    'S001', 500),
(3, 201, '2024-03-01 10:10:00', 'scroll',    'S001', 750),
(4, 201, '2024-03-01 10:15:00', 'scroll',    'S001', 600),
(5, 201, '2024-03-01 10:20:00', 'scroll',    'S001', 800),
(6, 201, '2024-03-01 10:25:00', 'scroll',    'S001', 550),
(7, 201, '2024-03-01 10:30:00', 'scroll',    'S001', 900),
(8, 201, '2024-03-01 10:35:00', 'app_close', 'S001', NULL),

(9, 202, '2024-03-01 11:00:00', 'app_open',  'S002', NULL),
(10, 202, '2024-03-01 11:02:00', 'click',    'S002', NULL),
(11, 202, '2024-03-01 11:05:00', 'scroll',   'S002', 400),
(12, 202, '2024-03-01 11:08:00', 'click',    'S002', NULL),
(13, 202, '2024-03-01 11:10:00', 'scroll',   'S002', 350),
(14, 202, '2024-03-01 11:15:00', 'purchase', 'S002', 50),
(15, 202, '2024-03-01 11:20:00', 'app_close','S002', NULL),

(16, 203, '2024-03-01 12:00:00', 'app_open', 'S003', NULL),
(17, 203, '2024-03-01 12:10:00', 'scroll',   'S003', 1000),
(18, 203, '2024-03-01 12:20:00', 'scroll',   'S003', 1200),
(19, 203, '2024-03-01 12:25:00', 'click',    'S003', NULL),
(20, 203, '2024-03-01 12:30:00', 'scroll',   'S003', 800),
(21, 203, '2024-03-01 12:40:00', 'scroll',   'S003', 900),
(22, 203, '2024-03-01 12:50:00', 'scroll',   'S003', 1100),
(23, 203, '2024-03-01 13:00:00', 'app_close','S003', NULL),

(24, 204, '2024-03-01 14:00:00', 'app_open', 'S004', NULL),
(25, 204, '2024-03-01 14:05:00', 'scroll',   'S004', 600),
(26, 204, '2024-03-01 14:08:00', 'scroll',   'S004', 700),
(27, 204, '2024-03-01 14:10:00', 'click',    'S004', NULL),
(28, 204, '2024-03-01 14:12:00', 'app_close','S004', NULL);


/*Q39:Write a solution to transform the text in the content_text column by applying the following rules:

Convert the first letter of each word to uppercase and the remaining letters to lowercase
Special handling for words containing special characters:
For words connected with a hyphen -, both parts should be capitalized (e.g., top-rated → Top-Rated)
All other formatting and spacing should remain unchanged
*/

CREATE TABLE user_content39 (
    content_id INT PRIMARY KEY,
    content_text VARCHAR(255)
);

INSERT INTO user_content39 VALUES
(1, 'hello world of SQL'),
(2, 'the QUICK-brown fox'),
(3, 'modern-day DATA science'),
(4, 'web-based FRONT-end development');




/*Q40:Write a solution to Find Churn Risk Customers - users who show warning signs before churning. A user is considered churn risk customer if they meet ALL the following criteria:

Currently have an active subscription (their last event is not cancel).
Have performed at least one downgrade in their subscription history.
Their current plan revenue is less than 50% of their historical maximum plan revenue.
Have been a subscriber for at least 60 days.*/

CREATE TABLE subscription_events40 (
    event_id INT PRIMARY KEY,
    user_id INT,
    event_date DATE,
    event_type VARCHAR(20),
    plan_name VARCHAR(20),
    monthly_amount DECIMAL(6,2)
);

INSERT INTO subscription_events40 VALUES
(1, 501, '2024-01-01', 'start',     'premium', 29.99),
(2, 501, '2024-02-15', 'downgrade', 'standard', 19.99),
(3, 501, '2024-03-20', 'downgrade', 'basic',     9.99),

(4, 502, '2024-01-05', 'start',     'standard', 19.99),
(5, 502, '2024-02-10', 'upgrade',   'premium',  29.99),
(6, 502, '2024-03-15', 'downgrade', 'basic',     9.99),

(7, 503, '2024-01-10', 'start',     'basic',     9.99),
(8, 503, '2024-02-20', 'upgrade',   'standard', 19.99),
(9, 503, '2024-03-25', 'upgrade',   'premium',  29.99),

(10, 504, '2024-01-15', 'start',     'premium', 29.99),
(11, 504, '2024-03-01', 'downgrade', 'standard',19.99),
(12, 504, '2024-03-30', 'cancel',    NULL,        0.00),

(13, 505, '2024-02-01', 'start',     'basic',     9.99),
(14, 505, '2024-02-28', 'upgrade',   'standard', 19.99),

(15, 506, '2024-01-20', 'start',     'premium', 29.99),
(16, 506, '2024-03-10', 'downgrade', 'basic',     9.99); 

/* Q41:
Write a solution to analyze the organizational hierarchy and answer the following:
Hierarchy Levels: For each employee, determine their level in the organization 
(CEO is level 1, employees reporting directly to the CEO are level 2, and so on).
Team Size: For each employee who is a manager, count the total number of employees under them 
(direct and indirect reports).
Salary Budget: For each manager, calculate the total salary budget they control 
(sum of salaries of all employees under them, including indirect reports, plus their own salary).
*/

CREATE TABLE Employees41 (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    manager_id INT,
    salary INT,
    department VARCHAR(50)
);

INSERT INTO Employees41 VALUES
(1, 'Alice', NULL, 12000, 'Executive'),
(2, 'Bob', 1, 10000, 'Sales'),
(3, 'Charlie', 1, 10000, 'Engineering'),
(4, 'David', 2, 7500, 'Sales'),
(5, 'Eva', 2, 7500, 'Sales'),
(6, 'Frank', 3, 9000, 'Engineering'),
(7, 'Grace', 3, 8500, 'Engineering'),
(8, 'Hank', 4, 6000, 'Sales'),
(9, 'Ivy', 6, 7000, 'Engineering'),
(10, 'Judy', 6, 7000, 'Engineering');


#Q42: Find the total cost of each customer's orders. Output customer's id, first name, and the total order cost.
# Order records by customer's first name alphabetically.

CREATE TABLE customers42 (
    id BIGINT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    city VARCHAR(50),
    address VARCHAR(100),
    phone_number VARCHAR(20)
);

CREATE TABLE orders42 (
    id BIGINT PRIMARY KEY,
    cust_id BIGINT,
    order_date DATE,
    order_details VARCHAR(100),
    total_order_cost BIGINT,
    FOREIGN KEY (cust_id) REFERENCES customers(id)
);

INSERT INTO customers42 VALUES
(1, 'John', 'Smith', 'New York', '123 Main St', '555-1001'),
(2, 'Alice', 'Johnson', 'Los Angeles', '456 Oak Ave', '555-1002'),
(3, 'Bob', 'Williams', 'Chicago', '789 Pine Rd', '555-1003'),
(4, 'Emma', 'Brown', 'Houston', '321 Maple Dr', '555-1004'),
(5, 'Michael', 'Davis', 'Phoenix', '654 Cedar Ln', '555-1005');

INSERT INTO orders42 VALUES
(101, 1, '2024-01-05', 'Laptop', 1200),
(102, 1, '2024-01-12', 'Mouse', 50),
(103, 2, '2024-01-10', 'Mobile Phone', 800),
(104, 2, '2024-01-18', 'Headphones', 150),
(105, 3, '2024-01-15', 'Monitor', 300),
(106, 3, '2024-02-01', 'Keyboard', 100),
(107, 4, '2024-02-05', 'Tablet', 600),
(108, 4, '2024-02-10', 'Charger', 40),
(109, 5, '2024-02-12', 'Smart Watch', 250),
(110, 5, '2024-02-20', 'Power Bank', 80);


#Q43: Compare each employee's salary with the average salary of the corresponding department.
#Output the department, first name, and salary of employees along with the average salary of that department.

CREATE TABLE employee43 (
    id BIGINT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age BIGINT,
    sex VARCHAR(10),
    employee_title VARCHAR(100),
    department VARCHAR(50),
    salary BIGINT,
    bonus BIGINT,
    target BIGINT,
    manager_id BIGINT,
    email VARCHAR(100),
    city VARCHAR(50),
    address VARCHAR(200)
);

INSERT INTO employee43 VALUES
(1,'John','Smith',45,'M','CEO','Executive',250000,50000,1000,NULL,'john.smith@company.com','New York','123 Main St'),

(2,'Alice','Johnson',40,'F','Sales Director','Sales',180000,30000,800,1,'alice.johnson@company.com','New York','234 Park Ave'),

(3,'Bob','Williams',38,'M','Engineering Director','Engineering',190000,35000,700,1,'bob.williams@company.com','San Francisco','345 Market St'),

(4,'Carol','Brown',35,'F','HR Director','HR',160000,25000,500,1,'carol.brown@company.com','Chicago','456 Lake Shore Dr'),

(5,'David','Miller',32,'M','Sales Manager','Sales',120000,20000,600,2,'david.miller@company.com','New York','567 Broadway'),

(6,'Emma','Davis',30,'F','Sales Executive','Sales',90000,15000,400,5,'emma.davis@company.com','Boston','678 Beacon St'),

(7,'Frank','Wilson',29,'M','Sales Executive','Sales',85000,12000,350,5,'frank.wilson@company.com','Boston','789 Boylston St'),

(8,'Grace','Taylor',31,'F','Engineering Manager','Engineering',130000,22000,550,3,'grace.taylor@company.com','San Francisco','890 Mission St'),

(9,'Henry','Anderson',28,'M','Software Engineer','Engineering',105000,10000,300,8,'henry.anderson@company.com','San Francisco','901 Howard St'),

(10,'Ivy','Thomas',27,'F','Software Engineer','Engineering',100000,9000,280,8,'ivy.thomas@company.com','San Francisco','912 Folsom St'),

(11,'Jack','Moore',26,'M','QA Engineer','Engineering',85000,7000,250,8,'jack.moore@company.com','San Jose','923 First St'),

(12,'Karen','Martin',29,'F','HR Specialist','HR',80000,8000,200,4,'karen.martin@company.com','Chicago','934 Michigan Ave'),

(13,'Leo','Jackson',33,'M','Finance Manager','Finance',125000,18000,450,1,'leo.jackson@company.com','New York','945 Wall St'),

(14,'Mia','White',30,'F','Financial Analyst','Finance',90000,10000,300,13,'mia.white@company.com','New York','956 Madison Ave'),

(15,'Noah','Harris',25,'M','Data Analyst','Engineering',95000,8500,270,8,'noah.harris@company.com','San Francisco','967 Castro St');



#Q44:What is the total sales revenue of Samantha and Lisa?
CREATE TABLE sales_performance44 (
    id BIGINT PRIMARY KEY,
    salesperson VARCHAR(100),
    sales_revenue BIGINT,
    widget_sales BIGINT
);

INSERT INTO sales_performance44 VALUES
(1, 'Alice Johnson', 125000, 450),
(2, 'Bob Smith', 98000, 380),
(3, 'Carol Davis', 145000, 520),
(4, 'David Wilson', 87000, 340),
(5, 'Emma Brown', 112000, 410),
(6, 'Frank Miller', 156000, 580),
(7, 'Grace Taylor', 134000, 495),
(8, 'Henry Moore', 91000, 355),
(9, 'Ivy Anderson', 168000, 620),
(10, 'Jack Thomas', 103000, 390);



#Q45:We have a table with employees and their salaries; however, some of the records are old and contain 
#outdated salary information. Since there is no timestamp, assume salary is non-decreasing over time. 
#You can consider the current salary for an employee is the largest salary value among their records. If multiple records share the same maximum salary, return any one of them. Output their id, first name, last name, department ID, and current salary. Order your list by employee ID in ascending order.
CREATE TABLE ms_employee_salary45 (
    id BIGINT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department_id BIGINT,
    salary BIGINT
);

INSERT INTO ms_employee_salary45 VALUES
(1, 'John', 'Smith', 101, 50000),
(1, 'John', 'Smith', 101, 55000),
(1, 'John', 'Smith', 101, 60000),

(2, 'Alice', 'Johnson', 102, 45000),
(2, 'Alice', 'Johnson', 102, 50000),

(3, 'Bob', 'Williams', 103, 70000),
(3, 'Bob', 'Williams', 103, 70000),

(4, 'Emma', 'Brown', 101, 40000),
(4, 'Emma', 'Brown', 101, 45000),
(4, 'Emma', 'Brown', 101, 47000),

(5, 'Michael', 'Davis', 102, 55000),

(6, 'Sophia', 'Miller', 103, 65000),
(6, 'Sophia', 'Miller', 103, 68000),

(7, 'James', 'Wilson', 104, 80000),
(7, 'James', 'Wilson', 104, 85000),
(7, 'James', 'Wilson', 104, 90000),

(8, 'Olivia', 'Moore', 104, 75000),
(8, 'Olivia', 'Moore', 104, 78000);

#Q46:Find the hour with the highest gasoline cost. Assume there's only 1 hour with the highest 

CREATE TABLE lyft_rides46 (
    `index` BIGINT,
    hour BIGINT,
    travel_distance FLOAT,
    gasoline_cost FLOAT,
    weather VARCHAR(50)
);

INSERT INTO lyft_rides46 VALUES
(1, 0, 3.5, 4.20, 'Clear'),
(2, 1, 2.8, 3.75, 'Clear'),
(3, 2, 4.1, 5.10, 'Rain'),
(4, 3, 5.5, 6.25, 'Rain'),
(5, 4, 3.2, 4.80, 'Cloudy'),
(6, 5, 6.0, 7.10, 'Cloudy'),
(7, 6, 7.5, 8.25, 'Clear'),
(8, 7, 8.0, 9.50, 'Clear'),
(9, 8, 10.5, 12.75, 'Sunny'),
(10, 9, 9.0, 10.50, 'Sunny');


#Q47: Compare each employee's salary with the average salary of the corresponding department.
#Output the department, first name, and salary of employees along with the average salary of that department.
CREATE TABLE employee47 (
    id BIGINT PRIMARY KEY,
    first_name TEXT,
    last_name TEXT,
    age BIGINT,
    sex TEXT,
    email TEXT,
    city TEXT,
    address TEXT,
    department TEXT,
    employee_title TEXT,
    manager_id BIGINT,
    salary BIGINT,
    bonus BIGINT,
    target BIGINT
);
INSERT INTO employee47 VALUES
(1,'John','Smith',45,'M','john@company.com','New York','123 Main St',
 'Engineering','Director',NULL,150000,30000,100),

(2,'Alice','Johnson',38,'F','alice@company.com','Chicago','45 Oak Ave',
 'Engineering','Manager',1,120000,20000,90),

(3,'Bob','Williams',34,'M','bob@company.com','Chicago','67 Pine Rd',
 'Engineering','Senior Engineer',2,100000,15000,85),

(4,'Carol','Davis',29,'F','carol@company.com','Boston','89 Maple St',
 'Engineering','Engineer',2,90000,10000,80),

(5,'David','Brown',42,'M','david@company.com','Dallas','12 Cedar Ln',
 'Sales','Director',1,140000,25000,110),

(6,'Eva','Miller',35,'F','eva@company.com','Dallas','34 Elm St',
 'Sales','Manager',5,110000,18000,100),

(7,'Frank','Wilson',30,'M','frank@company.com','Houston','56 Birch Rd',
 'Sales','Sales Executive',6,80000,12000,95),

(8,'Grace','Moore',28,'F','grace@company.com','Houston','78 Walnut Dr',
 'Sales','Sales Executive',6,75000,10000,90),

(9,'Henry','Taylor',40,'M','henry@company.com','Seattle','90 Spruce Ave',
 'HR','HR Manager',1,95000,12000,85),

(10,'Ivy','Anderson',27,'F','ivy@company.com','Seattle','22 Aspen Rd',
 'HR','HR Specialist',9,65000,7000,75);
 
 #Q48:Write a query that will calculate the number of shipments per month. The unique key for one shipment 
#is a combination of shipment_id and sub_id. Output the year_month in format YYYY-MM and the number of shipments in that month.
 
 CREATE TABLE amazon_shipment48 (
    shipment_id BIGINT,
    sub_id BIGINT,
    shipment_date DATE,
    weight BIGINT
);

INSERT INTO amazon_shipment48 VALUES
(1001, 1, '2024-01-05', 15),
(1001, 2, '2024-01-05', 10),

(1002, 1, '2024-01-12', 20),

(1003, 1, '2024-01-20', 12),
(1003, 2, '2024-01-20', 8),

(1004, 1, '2024-02-03', 25),

(1005, 1, '2024-02-10', 18),
(1005, 2, '2024-02-10', 6),

(1006, 1, '2024-02-18', 30),

(1007, 1, '2024-03-05', 22),
(1007, 2, '2024-03-05', 5),
(1007, 3, '2024-03-05', 7),

(1008, 1, '2024-03-12', 16),

(1009, 1, '2024-03-20', 28);