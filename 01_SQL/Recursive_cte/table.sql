use de_practice;

create table employees_RC(
    emp_id int,
    emp_name varchar(50),
    manager_id int
);

insert into employees_RC values
(1,'CEO',NULL),
(2,'Amit',1),
(3,'Rahul',1),
(4,'Neha',2),
(5,'Priya',2),
(6,'Karan',4);

