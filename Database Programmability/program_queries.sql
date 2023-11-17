#Lab
DELIMITER $$
CREATE FUNCTION `ufn_count_employees_by_town`(`town_name` VARCHAR(50)) 
RETURNS INT 
DETERMINISTIC
BEGIN 
    DECLARE `id_for_town` INT;
    DECLARE `count_by_town` INT;
    
    SET `id_for_town` := (SELECT `town_id` FROM `towns` WHERE `name` = `town_name`);
    SET `count_by_town` := 
		     (SELECT COUNT(*) FROM `employees` AS e
                    WHERE e.`address_id` IN 
                         (SELECT `address_id` FROM `addresses`
                              WHERE `town_id` = `id_for_town`
						)
			);
	RETURN `count_by_town`;
END$$


#Task 2
DELIMITER $$
CREATE PROCEDURE usp_raise_salaries(department_name VARCHAR(50))
BEGIN
UPDATE employees
SET 
    salary = salary * 1.05 
WHERE
    department_id = (SELECT 
            department_id
        FROM
            departments
        WHERE
            name = department_name);
END$$


#Task 3
DELIMITER $$
CREATE PROCEDURE `usp_raise_salary_by_id`(`id` INT)
BEGIN
    DECLARE `count_by_id` INT;
    
    START TRANSACTION;
    SET `count_by_id` := (SELECT COUNT(*) FROM `employees` WHERE `employee_id` = `id`);

	UPDATE `employees` SET `salary` = `salary` * 1.05 WHERE `employee_id` = `id`;
    
    IF (`count_by_id` < 1) THEN
    ROLLBACK;
    ELSE 
    COMMIT;
    END IF;
    
END$$
CALL `usp_raise_salary_by_id`(17);


#Task 4
DELIMITER $$
CREATE TABLE `deleted_employees`(
`employee_id` INT NOT NULL AUTO_INCREMENT,
`first_name` VARCHAR(50) NOT NULL,
`last_name` VARCHAR(50) NOT NULL,
`middle_name` VARCHAR(50) NOT NULL,
`job_title` VARCHAR(50) NOT NULL,
`department_id` INT NOT NULL,
`salary` DECIMAL(19, 4) NOT NULL,
PRIMARY KEY (`employee_id`)
)$$

DELIMITER $$
CREATE TRIGGER `tr_deleted_employees`
AFTER DELETE
ON `employees`
FOR EACH ROW
BEGIN

INSERT INTO `deleted_employees`
(`first_name`, `last_name`, `middle_name`, `job_title`, `department_id`, `salary`)
VALUES(
	   OLD.`first_name`,
       OLD.`last_name`,
       OLD.`middle_name`,
       OLD.`job_title`,
       OLD.`department_id`,
       OLD.`salary`);
END$$

#Exercise
#softuni database

#Task 1
DELIMITER $$
CREATE PROCEDURE usp_get_employees_salary_above_35000()
BEGIN
	SELECT `first_name`, `last_name` 
    FROM `employees` 
    WHERE `salary` > 35000
    ORDER BY `first_name`, `last_name`, `employee_id`;
    END$$    
    

#Task 2
DELIMITER $$
CREATE PROCEDURE usp_get_employees_salary_above(`value` DECIMAL(19, 4))
BEGIN
	SELECT `first_name`, `last_name`
    FROM `employees` 
    WHERE `salary` >= `value`
    ORDER BY `first_name`, `last_name`, `employee_id`;
END$$


#Task 3
DELIMITER $$
CREATE PROCEDURE usp_get_towns_starting_with(starting_text VARCHAR(50))
BEGIN
	SELECT `name` FROM `towns`
    WHERE LOWER(`name`) LIKE LOWER(CONCAT(starting_text, '%'))
    ORDER BY `name`;
END$$


#Task 4
DELIMITER $$
CREATE PROCEDURE usp_get_employees_from_town(town_name VARCHAR(50))
BEGIN
	SELECT `first_name`, `last_name` 
    FROM `employees` AS e
    JOIN `addresses` AS a USING (`address_id`)
    JOIN `towns` AS t USING (`town_id`)
    WHERE t.`name` = town_name
    ORDER BY `first_name`, `last_name`, `employee_id`;
END$$


#Task 5
DELIMITER $$
CREATE FUNCTION ufn_get_salary_level (salary DECIMAL(19, 4))
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
	DECLARE salary_level VARCHAR(10);
    IF salary < 30000 THEN SET salary_level := 'Low';
    ELSEIF salary <= 50000 THEN SET salary_level := 'Average';
    ELSE SET salary_level := 'High';
    END IF;
	RETURN salary_level;
END$$


#Task 6
DELIMITER $$
CREATE PROCEDURE usp_get_employees_by_salary_level (salary_level VARCHAR(10))
BEGIN
	SELECT `first_name`, `last_name` FROM `employees`
    WHERE ufn_get_salary_level(`salary`) = salary_level
    ORDER BY `first_name` DESC, `last_name` DESC;
END$$


#Task 7
DELIMITER $$
CREATE FUNCTION ufn_is_word_comprised(set_of_letters VARCHAR(50), word VARCHAR(50))  
RETURNS INT 
DETERMINISTIC
BEGIN
	RETURN word REGEXP (CONCAT('^[', set_of_letters, ']+$'));
END$$

#bank database
#Task 8
DELIMITER $$
CREATE PROCEDURE usp_get_holders_full_name()
BEGIN
	SELECT CONCAT_WS(' ', `first_name`, `last_name`) AS `full_name`
    FROM `account_holders`
    ORDER BY `full_name`, `id`;
END$$


#Task 9
DELIMITER $$
CREATE PROCEDURE usp_get_holders_with_balance_higher_than(searched_value DECIMAL (19, 4))
BEGIN
	SELECT ah.`first_name`, ah.`last_name` 
    FROM `account_holders` AS ah
    LEFT JOIN `accounts` AS a
    ON ah.`id` = a.`account_holder_id`
    GROUP BY ah.`first_name`, ah.`last_name`
    HAVING SUM(a.`balance`) > searched_value
    ORDER BY ah.`id`;
END$$


#Task 10
DELIMITER $$
CREATE FUNCTION ufn_calculate_future_value (`sum` DECIMAL (19, 4), yearly_rate DOUBLE, years INT)
RETURNS DECIMAL (19, 4)
DETERMINISTIC
BEGIN
	DECLARE future_sum DECIMAL (19, 4);
    SET future_sum := `sum` * POW(1 + yearly_rate, years);
    RETURN future_sum;
END$$


#Task 11
DELIMITER $$
CREATE PROCEDURE usp_calculate_future_value_for_account (id INT, rate DECIMAL(19, 4))
BEGIN
	SELECT a.`id` AS 'account_id', 
    ah.`first_name`, 
    ah.`last_name`, 
    a.`balance` AS 'current_balance',
	ufn_calculate_future_value(a.`balance`, rate, 5)AS 'balance_in_5_years'
    FROM `account_holders` AS ah
    JOIN `accounts` AS a ON ah.`id` = a.`account_holder_id`
    WHERE a.`id` = id;
END$$


#Task 12
DELIMITER $$
CREATE PROCEDURE usp_deposit_money(account_id INT, money_amount DECIMAL(19, 4))
BEGIN
	START TRANSACTION;
    IF (money_amount <= 0) THEN ROLLBACK;
    ELSE UPDATE `accounts` SET `balance` = `balance` + money_amount
    WHERE `id` = account_id;
    END IF;
END$$


#Task 13
DELIMITER $$
CREATE PROCEDURE usp_withdraw_money(account_id INT, money_amount DECIMAL(19, 4))
BEGIN
	START TRANSACTION;
    IF (money_amount <= 0 OR (SELECT `balance` FROM `accounts` 
												WHERE `id` = account_id) < money_amount) 
    THEN ROLLBACK;
    ELSE UPDATE `accounts` SET `balance` = `balance` - money_amount
    WHERE `id` = account_id;
    END IF;
END$$


#Task 14
DELIMITER $$
CREATE PROCEDURE usp_transfer_money(from_id INT, to_id INT, amount DECIMAL(19, 4))
BEGIN
		START TRANSACTION;
        IF from_id = to_id OR
			amount <= 0 OR
            (SELECT `balance` FROM `accounts` WHERE `id` = from_id) < amount OR
            (SELECT COUNT(`id`) FROM `accounts` WHERE `id` = from_id) <> 1 OR
            (SELECT COUNT(`id`) FROM `accounts` WHERE `id` = to_id) <> 1
            THEN ROLLBACK;

	ELSE 
	UPDATE `accounts` SET `balance` = `balance` - amount
		WHERE `id` = from_id;
    UPDATE `accounts` SET `balance` = `balance` + amount
		WHERE `id` = to_id;
    COMMIT;
    END IF;
END$$


#Task 15
CREATE TABLE `logs` (
	`log_id` INT PRIMARY KEY AUTO_INCREMENT,
    `account_id` INT NOT NULL,
    `old_sum` DECIMAL (19, 4) NOT NULL,
    `new_sum` DECIMAL (19, 4) NOT NULL
);

DELIMITER $$
CREATE TRIGGER tr_change_account_balance
AFTER UPDATE ON `accounts`
FOR EACH ROW 
BEGIN
	INSERT INTO `logs` (`account_id`, `old_sum`, `new_sum`)
    VALUES (OLD.`id`, OLD.`balance`, NEW.`balance`);
END$$


#Task 16
CREATE TABLE `notification_emails`(
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `recipient` INT NOT NULL,
    `subject` TEXT,
    `body` TEXT
);


DELIMITER $$
CREATE TRIGGER tr_email_on_insert
AFTER INSERT ON `logs`
FOR EACH ROW
BEGIN
	INSERT INTO `notification_emails`(`recipient`, `subject`, `body`)
    VALUES (NEW.`account_id`, 
			CONCAT('Balance change for account: ', NEW.`account_id`),
            CONCAT('On ', NOW(), ' your balance was changed from ', NEW.`old_sum`, ' to ', NEW.`new_sum`, '.')
	);
END$$
