####################
#Practice Questions#
####################

/*Q1:Calculates the difference between the highest salaries in the marketing and engineering departments. 
Output just the absolute difference in salaries.*/


#Total Cost Of Orders
/* Q2: Find the total cost of each customer's orders. Output customer's id, first name, and the total order cost. 
Order records by customer's first name alphabetically.*/



/*Q3:Management wants to analyze only employees with official job titles. Find the job titles of the employees with the 
highest salary. If multiple employees have the same highest salary, include all their job titles.*/




#Q4: Find all posts which were reacted to with a heart
#Find all posts which were reacted to with a heart. For such posts output all columns from facebook_posts table.



#Q5: Find all the users who were active for 3 consecutive days or more.


#Q6: Find all numbers that appear at least three times consecutively.




#Q7: Write a solution to find the employees who are high earners in each of the departments.


/* Q8 :The cancellation rate is computed by dividing the number of canceled (by client or driver) requests 
with unbanned usersby the total number of requests with unbanned users on that day.
Write a solution to find the cancellation rate of requests with unbanned users (both client and driver must not be banned)
 each day between "2013-10-01" and "2013-10-03" with at least one trip. Round Cancellation Rate to two decimal points.*/
 
 /*Q9:Write a solution to display the records with three or more rows with consecutive id's,and the number of people 
is greater than or equal to 100 for each.*/


#Q10:Write a solution to find the people who have the most friends and the most friends number



#Q11:Write a solution to report the name and balance of users with a balance higher than 10000. 
#The balance of an account is equal to the sum of the amounts of all transactions involving that account.


#Q12:Write a solution to calculate the total time in minutes spent by each employee on each day at the office.



#Q13:Write a solution to report the latest login for all users in the year 2020. Do not include the users who did not login in 2020.


/*Q:14
Write a solution to find all the valid email addresses. A valid email address meets the following criteria:
It contains exactly one @ symbol.
It ends with .com.
The part before the @ symbol contains only alphanumeric characters and underscores.
The part after the @ symbol and before .com contains a domain name that contains only letters.
*/



/*Q15: There is a queue of people waiting to board a bus. However, the bus has a weight limit of 1000 kilograms, 
so there may be some people who cannot board.
Write a solution to find the person_name of the last person that can fit on the bus without exceeding the weight limit. 
The test cases are generated such that the first person does not exceed the weight limit.*/


/*Q16:Write a solution to find all products whose description contains a valid serial number pattern. A valid serial number follows these rules:
It starts with the letters SN (case-sensitive).
Followed by exactly 4 digits.
It must have a hyphen (-) followed by exactly 4 digits.
The serial number must be within the description (it may not necessarily start at the beginning).*/


/*Q17:Write a solution to find the sum of amounts for odd and even transactions for each day. If there are no odd or even 
transactions for a specific date, display as 0.*/

/*Q18: Write a solution to find the students who have shown improvement. A student is considered to have shown 
improvement if they meet both of these conditions:
Have taken exams in the same subject on at least two different dates
Their latest score in that subject is higher than their first score
*/



#Q19:Write a solution to report the Capital gain/loss for each stock.




/*Q20:Write a solution to:
Find users who converted from free trial to paid subscription
Calculate each user's average daily activity duration during their free trial period (rounded to 2 decimal places)
Calculate each user's average daily activity duration during their paid subscription period (rounded to 2 decimal places)
Return the result table ordered by user_id in ascending order.
The result format is in the following example.
*/

/*Q21:Write a solution to find all books that are currently borrowed (not returned) and have zero copies available
 in the library.A book is considered currently borrowed if there exists a borrowing record with a NULL return_date*/
 
 
 
 
/*Q22: Write a solution to analyze AI prompt usage patterns based on the following requirements:
Only include users who have submitted at least 3 prompts.
Only include users who have submitted at least one prompt with tokens greater than their own average token usage.
*/


/*Q23:Identify distinct product pairs frequently purchased together by the same customers (where product1_id < product2_id)
For each product pair, determine how many customers purchased both products
A product pair is considered for recommendation if at least 3 different customers have purchased both products.*/



/*Q24: Write a solution to identify emotionally consistent users based on the following requirements:
For each user, count the total number of reactions they have given.
Only include users who have reacted to at least 5 different content items.
A user is considered emotionally consistent if at least 60% of their reactions are of the same type.
*/



/*Q25:Write a solution to find employees who have consistently improved their performance over their last three reviews.
An employee must have at least 3 review to be considered -----sorted
The employee's last 3 reviews must show strictly increasing ratings (each review better than the previous)
Use the most recent 3 reviews based on review_date for each employee
Calculate the improvement score as the difference between the latest rating and the earliest rating among the last 3 reviews
*/
 


/*Q26: find golden hour customers 
Made at least 3 orders.
At least 60% of their orders are during peak hours (11:00-14:00 or 18:00-21:00).
Their average rating for rated orders is at least 4.0, round it to 2 decimal places.
Have rated at least 50% of their orders.*/





#Q27:Write a solution to find loyal customers
#-Made at least 3 purchase transactions.
#-Have been active for at least 30 days.
#-Their refund rate is less than 20%


/*Q28:Write a solution to find the most popular product category for each season. The seasons are defined as:
Winter: December, January, February
Spring: March, April, May
Summer: June, July, August
Fall: September, October, November
The popularity of a category is determined by the total quantity sold in that season. If there is a tie, 
select the category with the highest total revenue (quantity × price). If there is still a tie, 
return the lexicographically smaller category.
*/




/*Q29:Write a solution to find patients who have recovered from COVID
-A patient is considered recovered if they have at least one Positive test followed by at least one Negative 
test on a later date
-Calculate the recovery time in days as the difference between the first positive test and the first negative test after that positive test
-Only include patients who have both positive and negative test results
*/





/*Q30:Write a solution to find stores that have inventory imbalance
For each store, identify the most expensive product (highest price) and its quantity
For each store, identify the cheapest product (lowest price) and its quantity
A store has inventory imbalance if the most expensive product's quantity is less than the cheapest product's quantity
Calculate the imbalance ratio as (cheapest_quantity / most_expensive_quantity)
Round the imbalance ratio to 2 decimal places
Only include stores that have at least 3 different products
*/
 
 
 /*Q31: Write a solution to find drivers whose fuel efficiency has improved by comparing their average fuel efficiency in the first half of the year with the second half of the year.

Calculate fuel efficiency as distance_km / fuel_consumed for each trip
First half: January to June, Second half: July to December
Only include drivers who have trips in both halves of the year
Calculate the efficiency improvement as (second_half_avg - first_half_avg)
Round all results to 2 decimal places
*/


/*Q32: Write a solution to find books that have polarized opinions - books that receive both very high ratings and very low ratings from different readers.

A book has polarized opinions if it has at least one rating ≥ 4 and at least one rating ≤ 2
Only consider books that have at least 5 reading sessions
Calculate the rating spread as (highest_rating - lowest_rating)
Calculate the polarization score as the number of extreme ratings (ratings ≤ 2 or ≥ 4) divided by total sessions
Only include books where polarization score ≥ 0.6 (at least 60% extreme ratings)
*/

/*Q33: Write a solution to find employees who are meeting-heavy - employees who spend more than 50% of their working time in meetings during any given week.

Assume a standard work week is 40 hours
Calculate total meeting hours per employee per week (Monday to Sunday)
An employee is meeting-heavy if their weekly meeting hours > 20 hours (50% of 40 hours)
Count how many weeks each employee was meeting-heavy
Only include employees who were meeting-heavy for at least 2 weeks
*/

/*Q34:Write a solution to identify skill mastery pathways by analyzing course completion sequences among 
top-performing students:
Consider only top-performing students (those who completed at least 5 courses with an average rating of 4 or 
higher).
For each top performer, identify the sequence of courses they completed in chronological order.
Find all consecutive course pairs (Course A → Course B) taken by these students.
Return the pair frequency, identifying which course transitions are most common among high achievers.
*/



/*Q35: Amazon wants to understand shopping patterns across product categories. Write a solution to:
Find all category pairs (where category1 < category2)
For each category pair, determine the number of unique customers who purchased products from both categories
A category pair is considered reportable if at least 3 different customers have purchased products from both 
categories.
*/



/*Q36:Write a solution to identify behaviorally stable users based on the following definition:
A user is considered behaviorally stable if there exists a sequence of at least 5 consecutive days such that:
The user performed exactly one action per day during that period.
The action is the same on all those consecutive days.
If a user has multiple qualifying sequences, only consider the sequence with the maximum length.
*/



/*Q37:Write a solution to find students who follow the Study Spiral Pattern - students who consistently study multiple subjects in a rotating cycle.

A Study Spiral Pattern means a student studies at least 3 different subjects in a repeating sequence
The pattern must repeat for at least 2 complete cycles (minimum 6 study sessions)
Sessions must be consecutive dates with no gaps longer than 2 days between sessions
Calculate the cycle length (number of different subjects in the pattern)
Calculate the total study hours across all sessions in the pattern
Only include students with cycle length of at least 3 subjects
*/




/*Q38:Write a solution to identify zombie sessions, sessions where users appear active but show abnormal behavior patterns.
A session is considered a zombie session if it meets ALL the following criteria:
The session duration is more than 30 minutes.
Has at least 5 scroll events.
The click-to-scroll ratio is less than 0.20 .
No purchases were made during the session.
*/


/*Q39:Write a solution to transform the text in the content_text column by applying the following rules:

Convert the first letter of each word to uppercase and the remaining letters to lowercase
Special handling for words containing special characters:
For words connected with a hyphen -, both parts should be capitalized (e.g., top-rated → Top-Rated)
All other formatting and spacing should remain unchanged
*/

/*Q40:Write a solution to Find Churn Risk Customers - users who show warning signs before churning. A user is considered churn risk customer if they meet ALL the following criteria:

Currently have an active subscription (their last event is not cancel).
Have performed at least one downgrade in their subscription history.
Their current plan revenue is less than 50% of their historical maximum plan revenue.
Have been a subscriber for at least 60 days.*/


/* Q41:
Write a solution to analyze the organizational hierarchy and answer the following:
Hierarchy Levels: For each employee, determine their level in the organization 
(CEO is level 1, employees reporting directly to the CEO are level 2, and so on).
Team Size: For each employee who is a manager, count the total number of employees under them 
(direct and indirect reports).
Salary Budget: For each manager, calculate the total salary budget they control 
(sum of salaries of all employees under them, including indirect reports, plus their own salary).
*/

#Q42: Find the total cost of each customer's orders. Output customer's id, first name, and the total order cost.
# Order records by customer's first name alphabetically.


#Q43: Compare each employee's salary with the average salary of the corresponding department.
#Output the department, first name, and salary of employees along with the average salary of that department.



#Q44:What is the total sales revenue of Samantha and Lisa?


#Q45:We have a table with employees and their salaries; however, some of the records are old and contain 
#outdated salary information. Since there is no timestamp, assume salary is non-decreasing over time. 
#You can consider the current salary for an employee is the largest salary value among their records. If multiple records share the same maximum salary, return any one of them. Output their id, first name, last name, department ID, and current salary. Order your list by employee ID in ascending order.

