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