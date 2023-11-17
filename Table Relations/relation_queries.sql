#Lab
#Task 1
CREATE TABLE `mountains` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL
);

CREATE TABLE `peaks` (
    `id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    `mountain_id` INT NOT NULL,
    CONSTRAINT `fk_peak_mountains` FOREIGN KEY (`mountain_id`)
        REFERENCES `mountains` (`id`)
);

#Task 2
SELECT 
    v.`driver_id`,
    v.`vehicle_type`,
    CONCAT_WS(' ', c.`first_name`, c.`last_name`) AS 'driver_name'
FROM
    `vehicles` AS v
        JOIN
    `campers` AS c ON v.`driver_id` = c.`id`;

#Task 3 
SELECT 
    starting_point AS 'route_starting_point',
    end_point AS 'route_ending_point',
    leader_id,
    CONCAT_WS(' ', c.first_name, c.last_name) AS 'leader_name'
FROM
    routes AS r
        JOIN
    campers AS c ON r.leader_id = c.id;

#Task 4
CREATE TABLE mountains (
    id INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(45));
    
    create table peaks (
    id INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(45),
    mountain_id INT,
    CONSTRAINT fk_peaks_mountains FOREIGN KEY (mountain_id)
        REFERENCES mountains (id)
        ON DELETE CASCADE
);

#Exercise
#Task 1
CREATE TABLE `passports` (
    `passport_id` INT PRIMARY KEY AUTO_INCREMENT,
    `passport_number` VARCHAR(50) UNIQUE NOT NULL
);

INSERT INTO `passports`(`passport_id`, `passport_number`)
VALUES
(101, 'N34FG21B'),
(102, 'K65LO4R7'),
(103, 'ZE657QP2');

CREATE TABLE `people` (
    `person_id` INT PRIMARY KEY AUTO_INCREMENT,
    `first_name` VARCHAR(50) NOT NULL,
    `salary` DECIMAL(9 , 2 ),
    `passport_id` INT UNIQUE,
    CONSTRAINT fk_people_passports FOREIGN KEY (`passport_id`)
        REFERENCES `passports` (`passport_id`)
);

INSERT INTO `people`(`first_name`, `salary`, `passport_id`)
VALUES
('Roberto', 43300.00, 102),
('Tom', 56100.00, 103),
('Yana', 60200.00, 101);

#Task 2
CREATE TABLE `manufacturers` (
    `manufacturer_id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL UNIQUE,
    `established_on` DATE
);

INSERT INTO `manufacturers` (`name`, `established_on`)
VALUES 
('BMW', '1916/03/01'),
('Tesla', '2003/01/01'),
('Lada', '1966/05/01');

CREATE TABLE `models` (
    `model_id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    `manufacturer_id` INT,
    CONSTRAINT fk_models_manufacturers FOREIGN KEY (`manufacturer_id`)
        REFERENCES `manufacturers` (`manufacturer_id`)
);

INSERT INTO `models`(`model_id`,`name`, `manufacturer_id`)
VALUES 
(101, 'X1', 1),
(102, 'i6', 1),
(103, 'Model S', 2),
(104, 'Model X', 2),
(105, 'Model 3', 2),
(106, 'Nova', 3);

#Task 3
CREATE TABLE `students` (
`student_id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(70) NOT NULL
);

INSERT INTO `students`(`name`)
VALUES 
('Mila'),
('Toni'),
('Ron');

CREATE TABLE `exams`(
`exam_id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(70) NOT NULL
);

ALTER TABLE `exams` AUTO_INCREMENT = 101;

INSERT INTO `exams`(`name`)
VALUES
('Spring MVC'),
('Neo4j'),
('Oracle 11g');

CREATE TABLE `students_exams`(
`student_id` INT NOT NULL,
`exam_id` INT NOT NULL,

CONSTRAINT pk
PRIMARY KEY (`student_id`, `exam_id`),

CONSTRAINT fk_students 
FOREIGN KEY (`student_id`)
REFERENCES `students`(`student_id`),

CONSTRAINT fk_exams
FOREIGN KEY (`exam_id`)
REFERENCES `exams`(`exam_id`)
);

INSERT INTO `students_exams`(`student_id`, `exam_id`)
VALUES 
('1', '101'),
('1', '102'),
('2', '101'),
('3', '103'),
('2', '102'),
('2', '103');

#Task 4
CREATE TABLE `teachers`(
`teacher_id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(50) NOT NULL,
`manager_id` INT
);

ALTER TABLE `teachers` AUTO_INCREMENT = 101;

INSERT INTO `teachers` (`name`, `manager_id`)
VALUES
('John', NULL),
('Maya', 106),
('Silvia', 106),
('Ted', 105),
('Mark', 101),
('Greta', 101);

ALTER TABLE `teachers`
ADD CONSTRAINT fk_manager_teacher
FOREIGN KEY (`manager_id`)
REFERENCES `teachers`(`teacher_id`);

#Task 5
CREATE TABLE `cities`(
`city_id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(50) NOT NULL
);

CREATE TABLE `customers`(
`customer_id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(50) NOT NULL,
`birthday` DATE NOT NULL,
`city_id` INT,
CONSTRAINT fk_customers_cities
FOREIGN KEY (`city_id`)
REFERENCES `cities`(`city_id`));

CREATE TABLE `orders`(
`order_id` INT PRIMARY KEY AUTO_INCREMENT,
`customer_id` INT,
CONSTRAINT fk_orders_customers
FOREIGN KEY (`customer_id`)
REFERENCES `customers`(`customer_id`)
);

CREATE TABLE `item_types`(
`item_type_id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(50) NOT NULL
);

CREATE TABLE `items`(
`item_id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(50) NOT NULL,
`item_type_id` INT NOT NULL,
CONSTRAINT fk_items_item_types
FOREIGN KEY (`item_type_id`)
REFERENCES `item_types`(`item_type_id`) 
);

CREATE TABLE `order_items`(
`order_id` INT NOT NULL,
`item_id` INT NOT NULL,

CONSTRAINT pk
PRIMARY KEY (`order_id`, `item_id`),

CONSTRAINT fk_order
FOREIGN KEY (`order_id`)
REFERENCES `orders`(`order_id`),

CONSTRAINT fk_item
FOREIGN KEY (`item_id`)
REFERENCES `items`(`item_id`)
);

#Task 6
CREATE TABLE `majors`(
`major_id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(50) NOT NULL
);

CREATE TABLE `students`(
`student_id` INT PRIMARY KEY AUTO_INCREMENT,
`student_number` VARCHAR(12) NOT NULL,
`student_name` VARCHAR(50) NOT NULL,
`major_id` INT,
CONSTRAINT fk_students_majors
FOREIGN KEY (`major_id`)
REFERENCES `majors`(`major_id`)
);

CREATE TABLE `payments`(
`payment_id` INT PRIMARY KEY AUTO_INCREMENT,
`payment_date` DATE NOT NULL,
`payment_amount` DECIMAL(8, 2) NOT NULL,
`student_id` INT,
CONSTRAINT fk_payments_students
FOREIGN KEY(`student_id`)
REFERENCES `students`(`student_id`)
);

CREATE TABLE `subjects`(
`subject_id` INT PRIMARY KEY AUTO_INCREMENT,
`subject_name` VARCHAR(50)
);

CREATE TABLE `agenda`(
`student_id` INT NOT NULL,
`subject_id` INT NOT NULL,

CONSTRAINT pk 
PRIMARY KEY (`student_id`, `subject_id`),

CONSTRAINT fk_students 
FOREIGN KEY (`student_id`)
REFERENCES `students`(`student_id`),

CONSTRAINT fk_subjects
FOREIGN KEY (`subject_id`)
REFERENCES `subjects`(`subject_id`)
);

#Task 7
SELECT 
m.`mountain_range`, p.`peak_name`, p.`elevation` AS `peak_elevation`
FROM
`mountains` AS m
JOIN
`peaks` AS p ON p.`mountain_id` = m.`id`
WHERE
m.`mountain_range` = 'Rila'
ORDER BY p.`elevation` DESC;
