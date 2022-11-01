-- NOETHER DB

CREATE TEMPORARY TABLE employees_with_departments(
first_name VARCHAR(20) NOT NULL,
last_name VARCHAR(20) NOT NULL,
dept_name VARCHAR(25) NOT NULL);
SELECT * FROM employees_with_departments;
-- Calling first temp table

ALTER TABLE employees_with_departments ADD full_name VARCHAR(40);
-- Added a full_name variable
SELECT * FROM employees_with_departments;

ALTER TABLE employees_with_departments DROP COLUMN first_name;
ALTER TABLE employees_with_departments DROP COLUMN last_name;
-- Removed first_name and last_name
SELECT * FROM employees_with_departments;
-- Another way to end up with this table is to just use full_name and not actually start with first and last name as seperate columns

-- SAKILA DB

SELECT * FROM payment;
DESCRIBE payment;
CREATE TEMPORARY TABLE noether_2027.new_payment AS SELECT amount, amount * 100 AS pennies FROM payment;

ALTER TABLE new_payment ADD n_pennies INT(5) UNSIGNED;

UPDATE new_payment SET n_pennies = pennies;

SELECT * FROM new_payment;

DROP TABLE new_payment;
-- NOETHER DB

CREATE TEMPORARY TABLE new_payment(
payment_id SMALLINT UNSIGNED,
customer_id SMALLINT UNSIGNED,
staff_id TINYINT UNSIGNED,
rental_id INT,
amount INT,
payment_date DATETIME,
last_update TIMESTAMP);

SELECT * FROM new_payment;

-- EMPLOYEES DB

/*
SELECT salary,
    (salary - (SELECT AVG(salary) FROM salaries))
    /
    (SELECT stddev(salary) FROM salaries WHERE to_date >= CURDATE()) AS zscore, d.dept_name
FROM salaries
JOIN dept_emp AS de
	ON de.emp_no = salaries.emp_no
JOIN departments AS d
	ON d.dept_no = de.dept_no
GROUP BY d.dept_name, salaries.salary;
*/;

CREATE TEMPORARY TABLE noether_2027.salary AS SELECT
de.emp_no, s.salary AS sal, d.dept_no, d.dept_name, zscore FROM departments AS d
JOIN dept_emp AS de
	USING(dept_no)
JOIN salaries AS s
	ON s.emp_no = de.emp_no AND s.to_date >= CURDATE()
JOIN(SELECT salary,
    (salary - (SELECT AVG(salary) FROM salaries WHERE to_date >= CURDATE()))
    /
    (SELECT stddev(salary) FROM salaries WHERE to_date >= CURDATE()) AS zscore
FROM salaries) AS z
	USING(salary)
	GROUP BY de.emp_no, s.salary, d.dept_no, d.dept_name;
SELECT * FROM salary;

SELECT dept_name, AVG(sal) AS dept_avg, AVG(zscore) AS avg_zscore FROM salary GROUP BY dept_name;
-- Sales is the best department to work for and Quality Management is the worst


DROP TABLE IF EXISTS noether_2027.salary;





















