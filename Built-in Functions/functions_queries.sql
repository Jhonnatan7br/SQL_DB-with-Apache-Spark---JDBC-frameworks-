#Lab

#Task 1
SELECT `title` FROM `books`
WHERE SUBSTRING(`title` FROM 1 FOR 3) = 'The'
ORDER BY `id`;

#Task 2
SELECT REPLACE (`title`, 'The', '***') FROM `books`
WHERE SUBSTRING(`title`, 1, 3) = 'The'
ORDER BY `id`;

#Task 3
SELECT ROUND(SUM(`cost`), 2) FROM `books`; 

#Task 4
SELECT CONCAT_WS(' ', `first_name`, `last_name`) AS 'Full Name',
TIMESTAMPDIFF(DAY, `born`, `died`) AS 'Days Lived'
FROM `authors`;

#Task 5
SELECT `title` FROM `books`
WHERE SUBSTRING(`title`, 1, 12) = "Harry Potter"
ORDER BY `id`;

#Exercise

#Task 1
SELECT `first_name`, `last_name` FROM `employees`
WHERE SUBSTRING(`first_name`, 1, 2) = 'Sa'
ORDER BY `employee_id`;

#Task 2
SELECT `first_name`, `last_name` FROM `employees`
WHERE `last_name` LIKE '%ei%'
ORDER BY `employee_id`;

#Task 3
SELECT `first_name` FROM `employees`
WHERE `department_id` IN (3, 10) AND YEAR (`hire_date`) BETWEEN 1995 AND 2005
ORDER BY `employee_id`;

#Task 4
SELECT `first_name`, `last_name` FROM `employees`
WHERE `job_title` NOT LIKE '%engineer%'
ORDER BY `employee_id`;

#Task 5
SELECT `name` FROM `towns`
WHERE CHAR_LENGTH(`name`) = 5 OR CHAR_LENGTH(`name`) = 6
ORDER BY `name`;

#Task 6
SELECT `town_id`, `name` FROM `towns`
WHERE SUBSTRING(`name`, 1, 1) = 'M'
OR SUBSTRING(`name`, 1, 1) = 'K'
OR SUBSTRING(`name`, 1, 1) = 'B'
OR SUBSTRING(`name`, 1, 1) = 'E'
ORDER BY `name`;

#Task 7
SELECT `town_id`, `name` FROM `towns`
WHERE `name` NOT LIKE 'R%' 
AND `name` NOT LIKE 'B%'
AND `name` NOT LIKE 'D%'  
ORDER BY `name`;

#Task 8
CREATE VIEW `v_employees_hired_after_2000` 
AS SELECT `first_name`, `last_name`
FROM `employees` 
WHERE YEAR(`hire_date`) > 2000;
SELECT * FROM `v_employees_hired_after_2000`;

#Task 9
SELECT `first_name`, `last_name` FROM `employees`
WHERE CHAR_LENGTH(`last_name`) = 5;

#Task 10
SELECT `country_name`, `iso_code` FROM `countries`
WHERE LOWER(`country_name`) LIKE '%a%a%a%'
ORDER BY `iso_code`;

#Task 11
SELECT `peak_name`, `river_name`, 
CONCAT(LOWER(`peak_name`), SUBSTRING(LOWER(`river_name`), 2)) AS `mix` 
FROM `peaks`, `rivers`
WHERE RIGHT(`peak_name`, 1) = LEFT(`river_name`, 1)
ORDER BY `mix`;

#Task 12
SELECT 
`name`, DATE_FORMAT(`start`, '%Y-%m-%d') AS `start` FROM `games`
WHERE YEAR(`start`) IN (2011, 2012)
ORDER BY `start`, `name`
LIMIT 50;

#Task 13
SELECT `user_name`, 
SUBSTRING(`email`, LOCATE('@', `email`) + 1) AS `email_provider`
FROM `users` 
ORDER BY `email_provider`, `user_name`;

#Task 14
SELECT `user_name`, `ip_address` FROM `users`
WHERE `ip_address` LIKE '___.1%.%.___'
ORDER BY `user_name`;

#Task 15
SELECT `name` AS `game`,
CASE WHEN HOUR(`start`) BETWEEN 0 AND 11 THEN 'Morning'
WHEN HOUR (`start`) BETWEEN 12 AND 17 THEN 'Afternoon'
ELSE 'Evening'
END AS 'Part of the Day',
CASE WHEN `duration` <=3 THEN 'Extra Short'
WHEN `duration` BETWEEN 4 AND 6 THEN 'Short'
WHEN `duration` BETWEEN 7 AND 10 THEN 'Long'
ELSE 'Extra Long'
END AS 'Duration'
FROM `games`;

#Task 16
SELECT `product_name`,
`order_date`,
DATE_ADD(`order_date`, INTERVAL 3 DAY) AS `pay_due`,
DATE_ADD(`order_date`, INTERVAL 1 MONTH) AS `deliver_due`
FROM `orders`;
