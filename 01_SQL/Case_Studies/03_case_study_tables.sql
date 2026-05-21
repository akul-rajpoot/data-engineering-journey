use de_practice;

CREATE TABLE users03 (
    user_id INT,
    user_name VARCHAR(50),
    city VARCHAR(50)
);

INSERT INTO users03 VALUES
(1, 'Amit', 'Delhi'),
(2, 'Rahul', 'Mumbai'),
(3, 'Neha', 'Delhi'),
(4, 'Priya', 'Bangalore');

CREATE TABLE rides03 (
    ride_id INT,
    user_id INT,
    ride_date DATE,
    fare INT
);

INSERT INTO rides03 VALUES
(101, 1, '2023-01-01', 200),
(102, 1, '2023-01-03', 300),
(103, 1, '2023-01-05', 150),
(104, 2, '2023-01-01', 400),
(105, 2, '2023-01-02', 500),
(106, 3, '2023-01-02', 250),
(107, 3, '2023-01-04', 350),
(108, 4, '2023-01-01', 100);


CREATE TABLE payments03 (
    payment_id INT,
    ride_id INT,
    payment_method VARCHAR(20)
);

INSERT INTO payments03 VALUES
(1, 101, 'Card'),
(2, 102, 'Cash'),
(3, 103, 'UPI'),
(4, 104, 'Card'),
(5, 105, 'UPI'),
(6, 106, 'Cash'),
(7, 107, 'Card'),
(8, 108, 'UPI');


 ####################
 #🚀 🧠 CASE STUDY 2: Subscription & Revenue Analytics
 ###############
 
 CREATE TABLE user_details03 (
    user_id INT,
    user_name VARCHAR(50),
    signup_date DATE
);

INSERT INTO user_details03 VALUES
(1, 'Amit', '2023-01-01'),
(2, 'Rahul', '2023-01-02'),
(3, 'Neha', '2023-01-03'),
(4, 'Priya', '2023-01-04');

CREATE TABLE subscriptions03 (
    sub_id INT,
    user_id INT,
    start_date DATE,
    end_date DATE,
    plan VARCHAR(20)
);

INSERT INTO subscriptions03 VALUES
(101, 1, '2023-01-01', '2023-01-10', 'Basic'),
(102, 1, '2023-01-11', '2023-01-20', 'Premium'),
(103, 2, '2023-01-02', '2023-01-15', 'Basic'),
(104, 3, '2023-01-03', '2023-01-08', 'Basic'),
(105, 3, '2023-01-10', '2023-01-20', 'Premium'),
(106, 4, '2023-01-04', '2023-01-25', 'Premium');

CREATE TABLE payments_details03 (
    payment_id INT,
    user_id INT,
    payment_date DATE,
    amount INT
);

INSERT INTO payments_details03 VALUES
(1, 1, '2023-01-01', 100),
(2, 1, '2023-01-11', 200),
(3, 2, '2023-01-02', 100),
(4, 3, '2023-01-03', 100),
(5, 3, '2023-01-10', 200),
(6, 4, '2023-01-04', 200);