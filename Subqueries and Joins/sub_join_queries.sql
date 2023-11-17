#Lab
#Task 1
SELECT d.`manager_id` as `employee_id`,
CONCAT_WS(' ', e.`first_name`, e.`last_name`) as `full_name`,
d.`department_id`, d.`name` as `department_name`
FROM `departments` as d
JOIN `employees`as e 
ON d.`manager_id` = e.`employee_id`
ORDER BY e.`employee_id`
LIMIT 5;

#Task 2
SELECT t.`town_id`, 
t.`name` as `town_name`,
a.`address_text`  
FROM
`addresses` as a
JOIN `towns` as t
ON a.`town_id` = t.`town_id`
WHERE a.`town_id` IN (9, 15, 32) 
ORDER BY a.`town_id`, a.`address_id`;

#Task 3
SELECT 
`employee_id`,
`first_name`,
`last_name`,
`department_id`,
`salary`
FROM `employees`
WHERE `manager_id` IS NULL; 

#Task 4
SELECT 
COUNT(*) AS `count`
FROM
`employees` AS e
WHERE
e.`salary` > 
(SELECT AVG(e1.`salary`)
FROM `employees` AS e1);

#Exercise
#soft_uni database

#Task 1
SELECT e.`employee_id`, e.`job_title`, 
a.`address_id`, a.`address_text` 
FROM `employees` as e
JOIN `addresses` as a
ON e.`address_id` = a.`address_id`
ORDER BY a.`address_id`
LIMIT 5; 

#Task 2
SELECT e.`first_name`, e.`last_name`, 
t.`name`, a.`address_text` 
FROM `employees` as e
JOIN `addresses` as a
JOIN `towns` as t
ON e.`address_id` = a.`address_id` AND t.`town_id` = a.`town_id`
ORDER BY e.`first_name`, e.`last_name`
LIMIT 5; 

#Task 3
SELECT e.`employee_id`, e.`first_name`, e.`last_name`,
d.`name` AS `department_name`
FROM `employees` AS e
JOIN `departments` AS d
ON d.`department_id` = e.`department_id`
WHERE d.`name` = 'Sales'
ORDER BY e.`employee_id` DESC;

#Task 4
SELECT e.`employee_id`, e.`first_name`, e.`salary`,
d.`name` AS `department_name`
FROM `employees` AS e
JOIN `departments` AS d
ON d.`department_id` = e.`department_id`
WHERE e.`salary` > 15000
ORDER BY d.`department_id` DESC
LIMIT 5;

#Task 5
SELECT e.`employee_id`, e.`first_name`
FROM `employees` AS e
LEFT JOIN `employees_projects` AS ep
ON ep.`employee_id` = e.`employee_id`
WHERE ep.`project_id` IS NULL
ORDER BY e.`employee_id` DESC
LIMIT 3;

#Task 6
SELECT e.`first_name`, e.`last_name`, e.`hire_date`,
d.`name` AS `dept_name`
FROM `employees` AS e
JOIN `departments` AS d
ON e.`department_id` = d.`department_id`
WHERE e.`department_id` IN (3, 10) 
AND e.`hire_date` > 1999-01-01
ORDER BY e.`hire_date`;

#Task 7
SELECT e.`employee_id`, e.`first_name`, p.`name` AS 'project_name'
FROM `employees` AS e
JOIN `employees_projects` as ep
ON e.`employee_id` = ep.`employee_id`
JOIN `projects` AS p
ON ep.`project_id` = p.`project_id`
WHERE DATE(p.`start_date`) > '2002-08-13' AND p.`end_date` IS NULL
ORDER BY e.`first_name`, p.`name`
LIMIT 5;

#Task 8
SELECT e.`employee_id`, e.`first_name`, 
IF (YEAR(p.`start_date`) >= 2005, NULL, p.`name`) AS 'project_name'
FROM `employees` AS e
JOIN `employees_projects` as ep
ON e.`employee_id` = ep.`employee_id`
JOIN `projects` AS p
ON ep.`project_id` = p.`project_id`
WHERE e.`employee_id` = 24
ORDER BY p.`name`;

#Task 9
SELECT e1.`employee_id`, 
e1.`first_name`, 
e1.`manager_id`, 
m.`first_name` AS 'manager_name'
FROM `employees` e1, `employees` m
WHERE e1.`manager_id` = m.`employee_id` 
AND e1.`manager_id` IN (3, 7)
ORDER BY e1.`first_name`;

#Task 10
SELECT e.`employee_id`, 
CONCAT_WS(' ', e.`first_name`, e.`last_name`) AS 'employee_name',
CONCAT_WS(' ', m.`first_name`, m.`last_name`) AS 'manager_name',
d.`name` AS 'department_name'
FROM `employees` AS e
INNER JOIN `employees` AS m 
ON e.`manager_id` = m.`employee_id`
INNER JOIN `departments` AS d 
ON e.`department_id` = d.`department_id`
WHERE e.`manager_id` IS NOT NULL
ORDER BY e.`employee_id`
LIMIT 5;

#Task 11
SELECT AVG(`salary`) AS 'min_average_salary' 
FROM `employees`
GROUP BY `department_id`
ORDER BY `min_average_salary`
LIMIT 1;

#geography database
#Task 12
SELECT c.`country_code`, 
m.`mountain_range`, 
p.`peak_name`, p.`elevation`
FROM `countries` AS c
JOIN `mountains_countries` AS mc 
ON c.`country_code` = mc.`country_code`
JOIN `mountains` AS m
ON mc.`mountain_id` = m.`id`
JOIN `peaks` AS p
ON m.`id` = p.`mountain_id`
WHERE p.`elevation` > 2835 AND c.`country_code` = 'BG'
ORDER BY p.`elevation` DESC;

#Task 13
SELECT c.`country_code`,
COUNT(m.`mountain_range`) AS 'mountain_range'
FROM `countries` AS c
JOIN `mountains_countries` AS mr ON c.`country_code` = mr.`country_code`
JOIN `mountains` as m ON mr.`mountain_id` = m.`id`
WHERE c.`country_code` IN ('BG', 'RU', 'US')
GROUP BY c.`country_code`
ORDER BY `mountain_range` DESC;

#Task 14
SELECT c.`country_name`,
r.`river_name`
FROM `countries` AS c
LEFT JOIN `countries_rivers` AS cr 
ON c.`country_code` = cr.`country_code`
LEFT JOIN `rivers` AS r
ON cr.`river_id` = r.`id`
WHERE c.`continent_code` = 'AF'
ORDER BY c.`country_name`
LIMIT 5;

#Task 15
SELECT c.`continent_code`,
c.`currency_code`,
COUNT(c.`currency_code`) AS 'currency_usage' 
FROM `countries` AS c
GROUP BY c.`currency_code`, c.`continent_code`
HAVING COUNT(c.`country_code`) > 1
AND `currency_usage` = (SELECT COUNT(*) AS cnt
FROM `countries` AS c2
WHERE c2.`continent_code` = c.`continent_code`
GROUP BY c2.`currency_code`
ORDER BY cnt DESC LIMIT 1)
ORDER BY c.`continent_code`, c.`currency_code`;

#Task 16
SELECT COUNT(m.`country_code`) AS 'country_count'
FROM (SELECT `country_code` FROM `countries` AS c
LEFT JOIN `mountains_countries` AS mc 
USING (`country_code`)
WHERE mc.`mountain_id` IS NULL) AS m; 

#Task 17
SELECT c.`country_name`,
MAX(p.`elevation`) AS 'highest_peak_elevation',
MAX(r.`length`) AS 'longest_river_length'
FROM `countries` AS c
LEFT JOIN `mountains_countries` AS mc 
USING (`country_code`)
LEFT JOIN `peaks` AS p 
USING (`mountain_id`)
LEFT JOIN `countries_rivers` AS cr 
USING (`country_code`)
LEFT JOIN `rivers` AS r 
ON r.`id` = cr.`river_id`
GROUP BY c.`country_name`
ORDER BY `highest_peak_elevation` DESC , 
`longest_river_length` DESC , 
c.`country_name`
LIMIT 5;
