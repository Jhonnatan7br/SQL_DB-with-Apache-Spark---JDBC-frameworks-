#Lab

#Task 1
CREATE TABLE `employees` (
id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL
);

CREATE TABLE `categories` ( 
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50) NOT NULL
);

CREATE TABLE `products` (
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50) NOT NULL,
category_id INT NOT NULL
);

#Task 2
INSERT INTO employees (`first_name`, `last_name`)
VALUES ('Luke', 'Giggsy'), ('Mara', 'Maraeva'), ('Lefty', 'Right');

#Task 3
ALTER TABLE employees ADD middle_name VARCHAR(50);

#Task 4
ALTER TABLE `products`
ADD CONSTRAINT `fk_products_categories`
FOREIGN KEY `products`(`category_id`) REFERENCES `categories`(`id`);

#Task 5
ALTER TABLE `employees`
MODIFY COLUMN `middle_name` VARCHAR(100);

#Exercise

#Task 1
CREATE DATABASE `minions`;

CREATE TABLE `minions` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    `age` VARCHAR(50)
);

CREATE TABLE `towns` (
    `town_id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL
);

#Task 2
ALTER TABLE `minions`
ADD COLUMN `town_id` INT NOT NULL,
ADD CONSTRAINT fk_minions_towns
FOREIGN KEY (`town_id`)
REFERENCES `towns` (`id`);

#Task 3
INSERT INTO `towns` (`id`, `name`)
VALUES (1, 'Sofia'), (2, 'Plovdiv'), (3, 'Varna');

INSERT INTO `minions` (`id`, `name`, `age`, `town_id`)
VALUES (1, 'Kevin', 22, 1),
		(2, 'Bob', 15, 3),
		(3, 'Steward', NULL, 2);
    
#Task 4
TRUNCATE TABLE `minions`;

#Task 5
DROP TABLE `minions`, `towns`;

#Task 6
CREATE TABLE `people` (
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(200) NOT NULL,
    `picture` BLOB,
    `height` DOUBLE,
    `weight` DOUBLE,
    `gender` CHAR(1) NOT NULL,
    `birthdate` DATE NOT NULL,
    `biography` TEXT
);

INSERT INTO `people` (`name`, `gender`, `birthdate`)
VALUES 
('Bark', 'm', DATE(NOW())),
('Lyubo', 'm', DATE(NOW())),
('Mariya', 'f', DATE(NOW())),
('Stoto', 'm', DATE(NOW())),
('Geri', 'f', DATE(NOW()));

#Task 7
CREATE TABLE `users` (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`username` VARCHAR(30) NOT NULL,
`password` VARCHAR(26) NOT NULL,
`profile_picture` BLOB,
`last_login_time` TIME,
`is deleted` BOOL
);

INSERT INTO `users` (`username`, `password`)
VALUES ('Lyubo1', '1234'),
('Lyubo2', '12345'),
('Lyubo3', '1233345'),
('Lyubo4', '123123123'),
('Lyubo5', '123123123123123123');

#Task 8
ALTER TABLE `users`
DROP PRIMARY KEY,
ADD PRIMARY KEY pk_users (`id`, `username`);

#Task 9
ALTER TABLE `users` 
MODIFY COLUMN `last_login_time` DATETIME DEFAULT NOW(); 

#Task 10
ALTER TABLE `users`
DROP PRIMARY KEY,
ADD CONSTRAINT pk_users
PRIMARY KEY `users` (`id`),
MODIFY COLUMN `username` VARCHAR (30) UNIQUE; 

#Task 11
CREATE TABLE `directors` (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`director_name` VARCHAR(50) NOT NULL,
`notes` TEXT 
);

INSERT INTO `directors` (`director_name`, `notes`)
VALUES ('Stephen Spielberg', 'Very Good'),
('Tom Hanks', 'Excellent'),
('David Yates', 'Very Good'),
('Quentin Tarantino', 'GODLIKE'),
('Woody Allen', 'Funny');

CREATE TABLE `genres` (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`genre_name` VARCHAR(50) NOT NULL,
`notes` TEXT
);

INSERT INTO `genres` (`genre_name`, `notes`)
VALUES ('comedy', 'very funny'),
('action', 'very dangerous'),
('romantic', 'very romantic'),
('drama', 'very dramatic'),
('sport', 'very sporty');

CREATE TABLE `categories` (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`category_name` VARCHAR(50) NOT NULL,
`notes` TEXT
);

INSERT INTO `categories` (`category_name`, `notes`)
VALUES ('good', 'good'),
('good', 'good'),
('good', 'good'),
('good', 'good'),
('good', 'good');

CREATE TABLE `movies` (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`title` VARCHAR(50) NOT NULL,
`director_id` INT,
`copyright_year` YEAR,
`lenght` FLOAT,
`genre_id` INT,
`category_id` INT,
`rating` INT,
`notes` TEXT
);

INSERT INTO `movies` 
VALUES (1, 'LOVE', 1, 2006, 1.36, 1, 1, 100, 'notes'),
(2, 'LOVE MORE', 1, 2006, 1.40, 1, 1, 100, 'notes'),
(3, 'GIGGSY', 1, 2007, 1.90, 1, 1, 100, 'notes'),
(4, 'VIDIC', 1, 2008, 2.23, 1, 1, 100, 'notes'),
(5, 'RIO', 1, 2010, 4.45, 1, 1, 100, 'notes');


#Task 12
CREATE TABLE `categories`(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`category` VARCHAR(50) NOT NULL,
`daily_rate` INT NOT NULL,
`weekly_rate` INT NOT NULL,
`monthly_rate` INT NOT NULL,
`weekend_rate` INT NOT NULL
);

INSERT INTO `categories` (`category`, `daily_rate`, `weekly_rate`, 
`monthly_rate`, `weekend_rate`)
VALUES ('car', 10, 10, 15, 25),
('bus', 10, 10, 15, 25),
('truck', 10, 10, 15, 25);

CREATE TABLE `cars`(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`plate_number` VARCHAR(10) NOT NULL,
`make` VARCHAR(15) NOT NULL,
`model`VARCHAR(15) NOT NULL,
`car_year` YEAR NOT NULL,
`category_id` INT NOT NULL,
`doors` INT NOT NULL,
`picture` BLOB,
`car_condition` VARCHAR(15) NOT NULL,
`available` BOOL
);

INSERT INTO `cars` (`plate_number`, `make`, `model`, `car_year`, `category_id`,
`doors`, `car_condition`, `available`)
VALUES ('A3047HH', 'Honda', 'Accord', 2004, 1, 4, 'Used', 1),
('A3047HH', 'Honda', 'Accord', 2004, 1, 4, 'Used', 1),
('A3047HH', 'Honda', 'Accord', 2004, 1, 4, 'Used', 1);

CREATE TABLE `employees` (
`id` INT PRIMARY KEY AUTO_INCREMENT,
`first_name` VARCHAR(20) NOT NULL,
`last_name` VARCHAR(20) NOT NULL,
`title` VARCHAR(10),
`notes` TEXT
);

INSERT INTO `employees` (`first_name`, `last_name`)
VALUES ('Lyubo', 'Dimitrov'),
('Mariya', 'Georgieva'),
('Bark', 'Cashew');

CREATE TABLE `customers`(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`driver_licence_number` INT NOT NULL,
`full_name` VARCHAR(100) NOT NULL,
`address` VARCHAR(255),
`city` VARCHAR(50) NOT NULL,
`zip_code` VARCHAR(10),
`notes` TEXT
);

INSERT INTO `customers` (`driver_licence_number`, `full_name`, `city`)
VALUES (1234, 'Lyubomir Dimitrov', 'Burgas'),
(1234, 'Lyubomir Dimitrov', 'Burgas'),
(1234, 'Lyubomir Dimitrov', 'Burgas');

CREATE TABLE `rental_orders`(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`employee_id` INT NOT NULL,
`customer_id` INT NOT NULL,
`car_id` INT NOT NULL,
`car_condition` VARCHAR(10) NOT NULL,
`tank_level` VARCHAR(10) NOT NULL,
`kilometrage_start` INT NOT NULL,
`kilometrage_end` INT NOT NULL,
`total_kilometrage` INT NOT NULL,
`start_date` DATE,
`end_date` DATE,
`total_days` INT NOT NULL,
`rate_applied` INT NOT NULL,
`tax_rate` INT NOT NULL,
`order_status` VARCHAR(10),
`notes` TEXT
);

INSERT INTO `rental_orders` (`employee_id`, `customer_id`, `car_id`, `car_condition`,
`tank_level`, `kilometrage_start`, `kilometrage_end`, `total_kilometrage`, `total_days`, 
`rate_applied`, `tax_rate`)

VALUES(1, 1, 123, 'New', 'Full', 12345, 12375, 30, 2, 12, 2),
(2, 4, 12, 'Used', 'Low', 12345, 12375, 30, 2, 12, 2),
(3, 5, 11, 'New', 'Medium', 12345, 12375, 30, 2, 12, 2);

#Task 13
INSERT INTO `towns`(`name`)
VALUES
('Sofia'),
('Plovdiv'),
('Varna'),
('Burgas');

INSERT INTO  `departments`(`name`)
VALUES
('Engineering'),
('Sales'),
('Marketing'),
('Software Development'),
('Quality Assurance');

INSERT INTO  `employees`
VALUES
(1, 'Ivan', 'Ivanov', 'Ivanov',	'.NET Developer',	4, '2013-02-01', 3500.00),
(2, 'Petar', 'Petrov', 'Petrov',	'Senior Engineer',	1,'2004-03-02', 4000.00),
(3, 'Maria', 'Petrova', 'Ivanova',	'Intern',	5,	'2016-08-28', 525.25),
(4, 'Georgi', 'Terziev', 'Ivanov', 'CEO',	2,'2007-12-09', 3000.00),
(5, 'Peter', 'Pan', 'Pan',	'Intern',	3,'2016-08-28',	599.88);

#Task 14
SELECT * FROM `towns`;

SELECT * FROM `departments`;

SELECT * FROM `employees`;

#Task 15
SELECT * FROM `towns`
ORDER BY `name`;

SELECT * FROM `departments`
ORDER BY `name`;

SELECT * FROM `employees`
ORDER BY `salary` DESC;

#Task 16
SELECT `name` FROM `towns`
ORDER BY `name`;

SELECT `name` FROM `departments`
ORDER BY `name`;

SELECT `first_name`, `last_name`, `job_title`, `salary` FROM `employees`
ORDER BY `salary` DESC;

#Task 17
UPDATE `employees`
SET `salary` = `salary` * 1.10;

SELECT `salary` FROM `employees`;
