
-- Q1. Query all columns for all American cities in the CITY table with populations larger than 100000. The CountryCode for America is USA.
select * from city 
where countrycode = 'USA' and population > 100000;


--Q2. Query the NAME field for all American cities in the CITY table with populations larger than 120000.
#The CountryCode for America is USA.
select name from city 
where countrycode = 'USA' and population > 120000;


--Q3. Query all columns (attributes) for every row in the CITY table.
select * from city;


--Q4. Query all columns for a city in CITY with the ID 1661.
select * from city 
where id = 1661;


--Q5. Query all attributes of every Japanese city in the CITY table. The COUNTRYCODE for Japan is JPN.
select * from city 
where countrycode = 'JPN';


--Q6. Query the names of all the Japanese cities in the CITY table. The COUNTRYCODE for Japan is JPN.
select name from city 
where countrycode = 'JPN';


--Q7. Query a list of CITY and STATE from the STATION table.
select city, state from station;


--Q8. Query a list of CITY names from STATION for cities that have an even ID number. Print the results in any order, but exclude duplicates from the answer.
select distinct(city) from station where id % 2 = 0; 


--Q9. Find the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table.
SELECT COUNT(CITY) - COUNT(DISTINCT CITY) AS Difference FROM STATION;


-- Q10. Query the two cities in STATION with the shortest and longest CITY names, as well as their
-- respective lengths (i.e.: number of characters in the name). If there is more than one smallest or
-- largest city, choose the one that comes first when ordered alphabetically.
SELECT CITY, LENGTH(CITY)
FROM (
  SELECT CITY, LENGTH(CITY)
  FROM STATION
  ORDER BY LENGTH(CITY), CITY
  LIMIT 1
) AS shortest
UNION ALL
SELECT CITY, LENGTH(CITY)
FROM (
  SELECT CITY, LENGTH(CITY)
  FROM STATION
  ORDER BY LENGTH(CITY) DESC, CITY
  LIMIT 1
) AS longest;


--Q11. Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates.  
SELECT DISTINCT CITY
FROM STATION
WHERE CITY REGEXP '^[aeiouAEIOU]'
ORDER BY CITY;


--Q12. Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot contain duplicates.
SELECT DISTINCT CITY
FROM STATION
WHERE CITY REGEXP '[aeiouAEIOU]$'
ORDER BY CITY;


--Q13. Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates
SELECT DISTINCT CITY
FROM STATION
WHERE CITY REGEXP '^[^aeiouAEIOU]'
ORDER BY CITY;


--Q14. Query the list of CITY names from STATION that do not end with vowels. Your result cannot contain duplicates.
SELECT DISTINCT CITY
FROM STATION
WHERE CITY REGEXP '[^aeiouAEIOU]$'
ORDER BY CITY;


--Q15. Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels. Your result cannot contain duplicates. Input Format
SELECT DISTINCT CITY
FROM STATION
WHERE CITY REGEXP '^[^aeiouAEIOU].*[^aeiouAEIOU]$'
ORDER BY CITY;


--Q16. Query the list of CITY names from STATION that do not start with vowels and do not end with vowels. Your result cannot contain duplicates.
SELECT DISTINCT CITY
FROM STATION
WHERE CITY REGEXP '^[^aeiouAEIOU].*[^aeiouAEIOU]$'
ORDER BY CITY;

--Q17. Write an SQL query that reports the products that were only sold in the first quarter of 2019. That is, between 2019-01-01 and 2019-03-31 inclusive.
SELECT DISTINCT p.product_id, p.product_name
FROM product p
JOIN sales s ON p.product_id = s.product_id
WHERE s.sales_date BETWEEN '2019-01-01' AND '2019-03-31'
AND NOT EXISTS (
    SELECT 1
    FROM sales s2
    WHERE s2.product_id = p.product_id
    AND (s2.sales_date < '2019-01-01' OR s2.sales_date > '2019-03-31')
);


--Q18.Write an SQL query to find all the authors that viewed at least one of their own articles. Return the result table sorted by id in ascending order.
 select distinct author_id from views
 where author_id = viewer_id order by author_id asc;
 
 
--Q19.Write an SQL query to find the percentage of immediate orders in the table, rounded to 2 decimal places.
SELECT ROUND((COUNT(CASE WHEN order_date = customer_pref_delivery_date THEN 1 END) * 100.0 / COUNT(*)), 2) AS percentage_immediate
FROM delivery;


--Q20.Write an SQL query to find the ctr of each Ad. Round ctr to two decimal points. Return the result table ordered by ctr in descending order and by ad_id in ascending order in case of a tie.

SELECT ad_id,
       CASE
           WHEN views = 0 THEN 0
           ELSE ROUND((clicks * 100.0 / views), 2)
       END AS ctr
FROM (
    SELECT ad_id,
           SUM(CASE WHEN action = 'Clicked' THEN 1 ELSE 0 END) AS clicks,
           SUM(CASE WHEN action IN ('Clicked', 'Viewed') THEN 1 ELSE 0 END) AS views
    FROM Ads
    GROUP BY ad_id
) t
ORDER BY ctr DESC, ad_id ASC;

-- Q21. Write an SQL query to find the team size of each of the employees. Return result table in any order.
SELECT employee_id,
       (SELECT COUNT(*) FROM Employee e2 WHERE e2.team_id = e1.team_id) AS team_size
FROM Employee e1
ORDER BY employee_id;


--Q22.Write an SQL query to find the type of weather in each country for November 2019. 
--The type of weather is: ● Cold if the average weather_state is less than or equal 15, 
--● Hot if the average weather_state is greater than or equal to 25, and 
--● Warm otherwise. Return result table in any order.

SELECT c.country_name,
       CASE
           WHEN AVG(w.weather_state) <= 15 THEN 'Cold'
           WHEN AVG(w.weather_state) >= 25 THEN 'Hot'
           ELSE 'Warm'
       END AS weather_type
FROM Countries c
JOIN Weather w ON c.country_id = w.country_id
WHERE w.day >= '2019-11-01' AND w.day <= '2019-11-30'
GROUP BY c.country_name;


--Q23.Write an SQL query to find the average selling price for each product. average_price should be rounded to 2 decimal places.
select p.product_id,Round(sum(p.price * u.units) / sum(u.units),2) as average_price
from prices p
join unitssold u on p.product_id = u.product_id  AND u.purchase_date BETWEEN p.start_date AND p.end_date
group by p.product_id;


--Q24.Write an SQL query to report the first login date for each player. Return the result table in any order.
select
    player_id,
    min(event_date) as first_login_device
from
    Activity
group by player_id;


--Q25.Write an SQL query to report the device that is first logged in for each player.
select player_id, min(device_id) from activity group by player_id;


--Q26 Write an SQL query to get the names of products that have at least 100 units ordered in February 2020 and their amount.
select distinct p.product_name,
sum(o.unit) as unit from  products p
join orders o on p.product_id = o.product_id
where o.order_date between '2020-02-01' and '2020-02-29' 
group by p.product_name
having sum(o.unit) >= 100;


 --Q27 Write an SQL query to find the users who have valid emails. A valid e-mail has a prefix name and a domain where: 
--● The prefix name is a string that may contain letters (upper or lower case), digits, underscore '_', period '.', and/or dash '-'. 
 --The prefix name must start with a letter. ● The domain is '@leetcode.com'.
SELECT user_id, mail AS users
FROM users
WHERE mail REGEXP '^[A-Za-z][A-Za-z0-9_.-]*@leetcode\.com$';


-- Q28. WRITE an SQL QUERY TO report the customer_id AND customer_name OF customers who have spent AT LEAST $100 IN EACH MONTH OF June AND July 2020.
SELECT c.customer_id, c.`name` AS customer_name 
FROM customers c,  orders_table o, products_table p
WHERE o.customer_id = c.customer_id AND o.product_id = p.product_id AND o.order_date BETWEEN '2020-06-01' AND '2020-07-31'
GROUP BY c.customer_id, c.`name`
HAVING SUM(p.price) >=100;

SELECT
    c.customer_id,
    c.`name` AS customer_name
FROM
    customers c
JOIN
    orders_table o ON c.customer_id = o.customer_id
JOIN
    products_table p ON o.product_id = p.product_id
WHERE
    (o.order_date BETWEEN '2020-06-01' AND '2020-06-30'
    OR o.order_date BETWEEN '2020-07-01' AND '2020-07-31')
GROUP BY
    c.customer_id,
    c.`name`
HAVING
    SUM(CASE WHEN o.order_date BETWEEN '2020-06-01' AND '2020-06-30' THEN p.price ELSE 0 END) >= 100
    AND SUM(CASE WHEN o.order_date BETWEEN '2020-07-01' AND '2020-07-31' THEN p.price ELSE 0 END) >= 100;
    
	
-- Q29. Write an SQL query to report the distinct titles of the kid-friendly movies streamed in June 2020.
SELECT DISTINCT c.title
FROM content c
JOIN tvprogram t ON c.content_id = t.content_id
WHERE t.program_date BETWEEN '2020-06-01' AND '2020-06-30' AND c.Kids_content = 'Y'; 


-- Q30.Write an SQL query to find the npv of each query of the Queries table.
SELECT q.id, q.year,
    CASE
        WHEN q.id = n.id AND q.year = n.year THEN n.npv
        ELSE 0
    END AS npv
FROM Queries q
LEFT JOIN npv n ON q.id = n.id AND q.year = n.year
GROUP BY q.id, q.year;


--Q31. Write an SQL query to find the npv of each query of the Queries table.

SELECT q.id, q.year,
    CASE
        WHEN q.id = n.id AND q.year = n.year THEN n.npv
        ELSE 0
    END AS npv
FROM Queries q
LEFT JOIN npv n ON q.id = n.id AND q.year = n.year
GROUP BY q.id, q.year;


--Q32. Write an SQL query to show the unique ID of each user, If a user does not have a unique ID replace just show null.	
SELECT e.name,
	CASE 
		WHEN en.id = e.id THEN en.unique_id
		ELSE NULL
	END AS Unique_id
FROM employees e
LEFT JOIN employeeuni en ON en.id = e.id;

(OR)

SELECT e.name,
       CASE
           WHEN en.id IS NOT NULL THEN en.unique_id
           ELSE NULL
       END AS Unique_id
FROM employees e
LEFT JOIN employeeuni en ON en.id = e.id;


--Q33. #Write an SQL query to report the distance travelled by each user. 
--Return the result table ordered by travelled_distance in descending order, if two or more 
--users travelled the same distance, order them by their name in ascending order.
SELECT u.name,
       SUM(CASE 
		WHEN u.id = r.user_id THEN r.distance 
		ELSE 0 
	    END) AS travelled_distance
FROM `user` u
LEFT JOIN rides r ON u.id = r.user_id
GROUP BY u.id, u.name
ORDER BY travelled_distance DESC, u.name ASC;


-- Q34.Write an SQL query to get the names of products that have at least 100 units ordered in February 2020 and their amount.
select distinct p.product_name,
sum(o.unit) as unit from  products p
join orders o on p.product_id = o.product_id
where o.order_date between '2020-02-01' and '2020-02-29' 
group by p.product_name
having sum(o.unit) >= 100;


-- Q35.WRITE an SQL QUERY TO: 
--● Find the NAME OF the USER who has rated the GREATEST NUMBER OF movies. 
--IN CASE OF a tie, RETURN the lexicographically smaller USER name. 
--● Find the movie NAME WITH the highest average rating IN February 2020. 
--IN CASE OF a tie, RETURN the lexicographically smaller movie name. The QUERY result FORMAT IS IN the FOLLOWING EXAMPLE
(SELECT NAME results
FROM users_tbl
LEFT JOIN movierating
USING (user_id)
GROUP BY user_id
ORDER BY COUNT(rating) DESC, NAME
LIMIT 1)

UNION

(SELECT title
FROM movies
LEFT JOIN movierating
USING(movie_id)
WHERE LEFT(created_at,7) = '2020-02'
GROUP BY movie_id
ORDER BY AVG(rating) DESC, title
LIMIT 1)


--Q36. Write an SQL query to report the distance travelled by each user. 
--Return the result table ordered by travelled_distance in descending order, 
--if two or more users travelled the same distance, order them by their name in ascending order.

SELECT u.name,
       SUM(CASE 
		WHEN u.id = r.user_id THEN r.distance 
		ELSE 0 
	    END) AS travelled_distance
FROM `user` u
LEFT JOIN rides r ON u.id = r.user_id
GROUP BY u.id, u.name
ORDER BY travelled_distance DESC, u.name ASC;


--Q37. Write an SQL query to show the unique ID of each user, If a user does not have a unique ID replace just show null. Return the result table in any order.
SELECT e.name,
	CASE 
		WHEN en.id = e.id THEN en.unique_id
		ELSE NULL
	END AS Unique_id
FROM employees e
LEFT JOIN employeeuni en ON en.id = e.id;

(OR)

SELECT e.name,
       CASE
           WHEN en.id IS NOT NULL THEN en.unique_id
           ELSE NULL
       END AS Unique_id
FROM employees e
LEFT JOIN employeeuni en ON en.id = e.id;


--Q38.Write an SQL query to find the id and the name of all students who are enrolled in departments that no longer exist.
SELECT s.id, s.name
FROM students s
LEFT JOIN departments d ON s.department_id = d.id
WHERE d.id IS NULL;


--Q39. Write an SQL query to report the number of calls and the total call duration between each pair of distinct persons (person1, person2) where person1 < person2.
SELECT 
    LEAST(from_id, to_id) AS person1,
    GREATEST(from_id, to_id) AS person2,
    COUNT(*) AS call_count,
    SUM(duration) AS total_duration
FROM Calls
GROUP BY person1, person2
ORDER BY person1, person2;


--Q40. Write an SQL query to find the average selling price for each product. average_price should be rounded to 2 decimal places.
select p.product_id,Round(sum(p.price * u.units) / sum(u.units),2) as average_price
from prices p
join unitssold u on p.product_id = u.product_id  AND u.purchase_date BETWEEN p.start_date AND p.end_date
group by p.product_id;


--Q41. Write an SQL query to report the number of cubic feet of volume the inventory occupies in each warehouse.
SELECT
    w.name AS warehouse_name,
    SUM(p.Width * p.Length * p.Height * w.units) AS volume
FROM warehouse w
JOIN product_detail p ON w.product_id = p.product_id
GROUP BY w.name;


--Q42. Write an SQL query to report the difference between the number of apples and oranges sold each day. Return the result table ordered by sale_date.
SELECT
    sale_date,
    SUM(CASE WHEN fruit = 'apples' THEN sold_num ELSE -sold_num END) AS diff
FROM Sales
GROUP BY sale_date
ORDER BY sale_date;


--Q43. Write an SQL query to report the fraction of players that logged in again on the day after the day they first logged in, 
--rounded to 2 decimal places. In other words, you need to count the number of players that logged in for at least two consecutive days starting from their 
--first login date, then divide that number by the total number of players.
SELECT 
    ROUND(
        SUM(CASE WHEN min_date = DATE_ADD(next_date, INTERVAL -1 DAY) THEN 1 ELSE 0 END) 
        / COUNT(DISTINCT player_id),
        2
    ) AS fraction
FROM (
    SELECT 
        player_id, 
        MIN(event_date) AS min_date,
        MAX(event_date) AS next_date
    FROM Activity
    GROUP BY player_id
) AS FirstLogin;


--Q44. Write an SQL query to report the managers with at least five direct reports.
SELECT E1.name
FROM employee_tbl E1
WHERE (
    SELECT COUNT(*)
    FROM employee_tbl  E2
    WHERE E2.managerId = E1.id
) >= 5;


--Q45.Write an SQL query to report the respective department name and number of students majoring in each department for all departments in the Department table (even ones with no current students). Return the result table ordered by student_number in descending order. In case of a tie, order them by dept_name alphabetically.
SELECT d.dept_name, IFNULL(COUNT(s.student_id), 0) AS student_number
FROM department_detail d
LEFT JOIN student s ON d.dept_id = s.dept_id
GROUP BY d.dept_name
ORDER BY student_number DESC, d.dept_name;


--Q46. Write an SQL query to report the customer ids from the Customer table that bought all the products in the Product table.
SELECT customer_id
FROM customer
GROUP BY customer_id
HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(*) FROM product_details);


--Q47. Write an SQL query that reports the most experienced employees in each project. In case of a tie, report all employees with the maximum number of experience years.
SELECT project_id, employee_id
FROM project
JOIN employees_tbl
USING (employee_id)
WHERE (project_id, experience_years) IN (
    SELECT project_id, MAX(experience_years)
    FROM project
    JOIN employees_tbl
    USING (employee_id)
    GROUP BY project_id)
	
	
--Q48.Write an SQL query that reports the books that have sold less than 10 copies in the last year, excluding books that have been available for less than one month from today. Assume today is 2019-06-23. 
SELECT book_id, NAME 
FROM books
WHERE book_id NOT IN (
    SELECT book_id 
    FROM orders 
    WHERE (dispatch_date BETWEEN DATE_SUB('2019-06-23',INTERVAL 1 YEAR) AND '2019-06-23') 
    GROUP BY (book_id) 
    HAVING SUM(quantity) >= 10)
AND 
    available_from < DATE_SUB('2019-06-23', INTERVAL 1 MONTH)


--Q49. Write a SQL query to find the highest grade with its corresponding course for each student. In case of a tie, you should find the course with the smallest course_id. Return the result table ordered by student_id in ascending order.
select student_id, min(course_id) as course_id, grade
from Enrollments
where (student_id, grade) in 
    (select student_id, max(grade)
    from Enrollments
    group by student_id)
group by student_id, grade
order by student_id asc


--Q50.Write an SQL query to find the winner in each group.
SELECT group_id, 
       player_id 
FROM   (SELECT p.group_id, 
               ps.player_id, 
               Sum(ps.score) AS score 
        FROM   players p INNER JOIN
               (SELECT first_player AS player_id, 
                       first_score  AS score 
                FROM   matches 
                UNION ALL 
                SELECT second_player AS player_id,
                       second_score  AS score
                FROM   matches) ps 
        ON  p.player_id = ps.player_id 
        GROUP  BY ps.player_id 
        ORDER  BY group_id, 
                  score DESC, 
                  player_id) top_scores 
GROUP  BY group_id
	
	
