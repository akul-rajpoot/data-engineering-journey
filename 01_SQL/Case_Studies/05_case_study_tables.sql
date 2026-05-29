#################################################################
#🚀 🧠 CASE STUDY 9: Ride Sharing + User Behavior Analytics
#################################################################

use de_practice;
CREATE TABLE users09 (
    user_id INT,
    user_name VARCHAR(50),
    signup_date DATE
);

INSERT INTO users09 VALUES
(1, 'Amit', '2023-01-01'),
(2, 'Rahul', '2023-01-02'),
(3, 'Neha', '2023-01-03'),
(4, 'Priya', '2023-01-04');

CREATE TABLE rides09 (
    ride_id INT,
    user_id INT,
    ride_date DATE,
    distance INT,
    fare INT
);

INSERT INTO rides09 VALUES
(101, 1, '2023-01-01', 5, 100),
(102, 1, '2023-01-02', 6, 120),
(103, 1, '2023-01-04', 4, 80),
(104, 2, '2023-01-01', 3, 60),
(105, 2, '2023-01-03', 7, 140),
(106, 3, '2023-01-01', 10, 200),
(107, 3, '2023-01-02', 8, 160),
(108, 3, '2023-01-03', 6, 120),
(109, 4, '2023-01-02', 2, 40);

CREATE TABLE payments08 (
    payment_id INT,
    ride_id INT,
    payment_method VARCHAR(20)
);

INSERT INTO payments08 VALUES
(1, 101, 'Card'),
(2, 102, 'UPI'),
(3, 103, 'Card'),
(4, 104, 'Cash'),
(5, 105, 'UPI'),
(6, 106, 'Card'),
(7, 107, 'Card'),
(8, 108, 'UPI'),
(9, 109, 'Cash');


#############################################
#🚀 🧠 CASE STUDY 10: E-Commerce Funnel & Conversion Analytics
############################################

CREATE TABLE users10 (
    user_id INT,
    user_name VARCHAR(50),
    signup_date DATE
);

INSERT INTO users10 VALUES
(1, 'Amit', '2023-01-01'),
(2, 'Rahul', '2023-01-02'),
(3, 'Neha', '2023-01-03'),
(4, 'Priya', '2023-01-04');

CREATE TABLE events10 (
    event_id INT,
    user_id INT,
    event_type VARCHAR(20),  -- 'view', 'add_to_cart', 'purchase'
    event_date DATE
);

INSERT INTO events10 VALUES
(1, 1, 'view', '2023-01-01'),
(2, 1, 'add_to_cart', '2023-01-01'),
(3, 1, 'purchase', '2023-01-02'),

(4, 2, 'view', '2023-01-01'),
(5, 2, 'add_to_cart', '2023-01-03'),

(6, 3, 'view', '2023-01-01'),
(7, 3, 'view', '2023-01-02'),
(8, 3, 'purchase', '2023-01-03'),

(9, 4, 'view', '2023-01-02');

