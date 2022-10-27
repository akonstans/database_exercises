SELECT users.*, roles.* FROM users
LEFT JOIN roles
ON users.role_id = roles.id;
-- LEFT JOIN pulls all information

SELECT users.*, roles.* FROM users
RIGHT JOIN roles
ON users.role_id = roles.id;
-- RIGHT JOIN takes away some names but leaves role id

SELECT users.*, roles.* FROM users
JOIN roles
ON users.role_id = roles.id;
-- INNER JOIN

/*
USING EMPLOYEES DATABASE FROM HERE ON
*/

SELECT d.dept_name, CONCAT(e.first_name, " ", e.last_name) AS full_name FROM departments AS d
JOIN dept_manager AS dm
	ON dm.dept_no = d.dept_no
JOIN employees AS e
	ON e.emp_no = dm.emp_no
WHERE dm.to_date >= NOW()
ORDER BY d.dept_name;
-- All current managers

SELECT d.dept_name, CONCAT(e.first_name, " ", e.last_name) AS full_name FROM departments AS d
JOIN dept_manager AS dm
	ON dm.dept_no = d.dept_no
JOIN employees AS e
	ON e.emp_no = dm.emp_no
WHERE dm.to_date >= NOW() AND e.gender = 'F'
ORDER BY d.dept_name;
-- All current female managers

SELECT t.title, COUNT(DISTINCT de.emp_no) AS total FROM dept_emp AS de
JOIN titles AS t
	ON t.emp_no = de.emp_no
JOIN employees AS e
	ON e.emp_no = de.emp_no
JOIN departments AS d
	ON d.dept_no = de.dept_no
WHERE d.dept_name = 'Customer Service' AND t.to_date = '9999-01-01'
GROUP BY t.title
ORDER BY t.title ASC;
-- Current employees by current title in customer service

SELECT d.dept_name, CONCAT(e.first_name, " ", e.last_name) AS full_name, s.salary FROM departments AS d
JOIN dept_manager AS dm
	ON dm.dept_no = d.dept_no
JOIN employees AS e
	ON e.emp_no = dm.emp_no
JOIN salaries AS s
	ON s.emp_no = e.emp_no
WHERE dm.to_date >= NOW() AND s.to_date >= NOW()
ORDER BY d.dept_name;
-- Current manager salaries

SELECT d.dept_no, d.dept_name, COUNT(de.emp_no) AS current_emp FROM departments AS d
JOIN dept_emp AS de
	ON de.dept_no = d.dept_no
WHERE de.to_date >= NOW()
GROUP BY d.dept_no
ORDER BY d.dept_no;
-- Current number of employees per department

SELECT d.dept_name, AVG(s.salary) AS average FROM departments AS d
JOIN dept_emp AS de
	ON de.dept_no = d.dept_no
JOIN salaries AS s
	ON s.emp_no = de.emp_no
WHERE de.to_date >= NOW()
GROUP BY d.dept_name
ORDER BY average DESC LIMIT 1;
-- Highest average salary by department

SELECT e.first_name, e.last_name FROM employees AS e
JOIN dept_emp AS de
	ON de.emp_no = e.emp_no
JOIN departments AS d
	ON d.dept_no = de.dept_no
JOIN salaries AS s
	ON s.emp_no = e.emp_no
WHERE d.dept_name = 'Marketing' AND de.to_date >= NOW()
ORDER BY s.salary DESC LIMIT 1;
-- Highest paid person in marketing dept

SELECT d.dept_name, CONCAT(e.first_name, " ", e.last_name) AS full_name, s.salary FROM departments AS d
JOIN dept_manager AS dm
	ON dm.dept_no = d.dept_no
JOIN employees AS e
	ON e.emp_no = dm.emp_no
JOIN salaries AS s
	ON s.emp_no = e.emp_no
WHERE dm.to_date >= NOW() AND s.to_date >= NOW()
ORDER BY s.salary DESC LIMIT 1;
-- Highest paid dept manager

SELECT d.dept_name, AVG(s.salary) AS average FROM departments AS d
JOIN dept_emp AS de
	ON de.dept_no = d.dept_no
JOIN salaries AS s
	ON s.emp_no = de.emp_no
GROUP BY d.dept_name
ORDER BY average DESC;
-- AVG salary by dep using both current and historical data

/*SELECT CONCAT(e.first_name, " ", e.last_name) AS full_name, d.dept_name, CONCAT(m.first_name, " ", m.last_name) AS manager FROM departments AS d
JOIN dept_manager AS dm
	ON dm.dept_no = d.dept_no
JOIN dept_emp AS de
	ON de.dept_no = d.dept_no
JOIN employees AS e
	ON e.emp_no = de.emp_no
JOIN employees AS m
	ON m.emp_no = dm.emp_no
WHERE de.to_date >= NOW() AND dm.to_date >= NOW() 
GROUP BY full_name, manager, d.dept_name
ORDER BY d.dept_name;
-- List of current employees in their current departments matched with their current managers

SELECT CONCAT(e.first_name, " ", e.last_name) AS full_name, d.dept_name, MAX(s.salary) AS salary 
FROM departments AS d
JOIN dept_emp AS de
	ON de.dept_no = d.dept_no
JOIN salaries AS s
	ON s.emp_no = de.emp_no
JOIN employees AS e
	ON e.emp_no = s.emp_no
WHERE de.to_date >= NOW() AND s.to_date >= NOW() 
GROUP BY d.dept_name,full_name, salary
HAVING MAX(salary);




SELECT CONCAT(e.first_name, " ", e.last_name) AS full_name(
(SELECT d.dept_name, MAX(s.salary) AS highest_salary
FROM departments AS d
JOIN dept_emp AS de
    ON d.dept_no = de.dept_no
JOIN employees AS e
    ON de.emp_no = e.emp_no
JOIN salaries AS s
    ON e.emp_no = s.emp_no
WHERE s.to_date >= NOW()
GROUP BY d.dept_name) AS sal)
JOIN employees AS e
	ON e.emp_no = sal.emp_no
GROUP BY full_name;*/

/*
SELECT e.first_name
FROM (
SELECT MAX(salary), de.emp_no 
FROM salaries 
JOIN dept_emp as de USING(emp_no) 
JOIN departments as d USING(dept_no) 
WHERE de.to_date >= CURDATE() 
GROUP BY d.dept_name,de.emp_no) as g


JOIN employees as e
	ON g.emp_no = e.emp_no
GROUP BY e.first_name ;

SELECT d.dept_name, MAX(s.salary) AS highest_salary
FROM departments AS d
JOIN dept_emp AS de
    ON d.dept_no = de.dept_no
JOIN employees AS e
    ON de.emp_no = e.emp_no
JOIN salaries AS s
    ON e.emp_no = s.emp_no
WHERE s.to_date >= NOW()
GROUP BY d.dept_name;
*/

SELECT s. department, s.highest_salary, CONCAT(e.first_name, ' ', e.last_name) AS full_name
FROM (
SELECT s.department, s.highest_salary, y.emp_no
FROM (
SELECT d.dept_name AS department, MAX(s.salary) AS highest_salary
FROM departments AS d 
JOIN dept_emp AS de
	ON d.dept_no = de.dept_no
JOIN employees AS e
	ON de.emp_no = e.emp_no
JOIN salaries AS s
	ON s.emp_no = e.emp_no
WHERE s.to_date >= CURDATE()
GROUP BY d.dept_name
ORDER BY d.dept_name) AS s
JOIN departments AS d
	ON s.department = d.dept_name
JOIN dept_emp AS de
	ON d.dept_no = de.dept_no
JOIN employees AS e
	ON de.emp_no = e.emp_no
LEFT JOIN salaries AS y
	ON s.highest_salary = y.salary
GROUP BY s.department, s.highest_salary, y.emp_no
ORDER BY s.department) AS s
JOIN employees AS e
	ON s.emp_no = e.emp_no;
describe salaries;


