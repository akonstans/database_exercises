SELECT first_name, last_name, emp_no FROM employees 
WHERE hire_date = (
SELECT hire_date FROM employees 
WHERE emp_no = 101010);
-- Employees with same hire date as employee 101010

SELECT title, first_name FROM (SELECT first_name, employees.emp_no FROM employees
JOIN dept_emp as de
	ON de.emp_no = employees.emp_no
WHERE first_name = 'Aamod' AND de.to_date >= NOW()) AS e
JOIN titles AS t
	ON t.emp_no = e.emp_no;
-- All current employees named Aamod and all their positions past and present

SELECT COUNT(f.emp_no), f.first_name, f.last_name FROM (SELECT first_name, last_name, emp_no FROM employees) AS f
JOIN dept_emp AS de
	ON de.emp_no = f.emp_no
JOIN salaries AS s
	ON s.emp_no = f.emp_no
JOIN titles AS t
	ON t.emp_no = f.emp_no
WHERE de.to_date < CURDATE() AND t.to_date < CURDATE() AND s.to_date < CURDATE()
GROUP BY f.first_name, f.last_name;
-- There are 72074 employees no longer at the company

SELECT l.full_name, l.dept_name, l.gender FROM (
SELECT d.dept_name, CONCAT(e.first_name, " ", e.last_name) AS full_name, gender FROM departments AS d
JOIN dept_manager AS dm
	ON dm.dept_no = d.dept_no
JOIN employees AS e
	ON e.emp_no = dm.emp_no
WHERE dm.to_date >= NOW() AND e.gender = 'F'
) AS l;
-- All female department heads Isamu, Karsten, Leon, Hilary

SELECT first_name, last_name, s.salary FROM employees AS e
JOIN salaries as s
	ON s.emp_no = e.emp_no
WHERE s.salary > (SELECT AVG(salary) FROM salaries) AND s.to_date >= NOW();
-- All current salaries greater than company average

SELECT COUNT(emp_no) FROM salaries 
WHERE to_date >= NOW() AND salary >= (SELECT MAX(salary) - STD(salary) FROM salaries
WHERE to_date > NOW());
-- All current salaries within 1 standard deviation of max

SELECT e.first_name, e.last_name, e.gender, d.dept_name
FROM(
    SELECT emp_no, dept_no
    FROM dept_manager
    WHERE to_date >= NOW()) AS dm
JOIN employees AS e
    ON dm.emp_no = e.emp_no
JOIN departments AS d
    ON dm.dept_no = d.dept_no
WHERE e.gender = 'F';
-- Female Department leaders using subqueries

SELECT e.first_name, e.last_name, s.salary FROM employees AS e
JOIN salaries AS s
	ON s.emp_no = e.emp_no
WHERE s.salary =
(SELECT MAX(salary) FROM salaries);
-- Highest salary in company with name using subqueries

SELECT e.first_name, e.last_name, s.salary, d.dept_name FROM employees AS e
JOIN salaries AS s
	ON s.emp_no = e.emp_no
JOIN dept_emp AS de
	ON de.emp_no = s.emp_no
JOIN departments AS d
	ON d.dept_no = de.dept_no
WHERE s.salary =
(SELECT MAX(salary) FROM salaries);
-- Added the department as well
