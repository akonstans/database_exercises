USE employees;

SELECT DISTINCT title FROM titles;
-- There are 7 unique titles

SELECT last_name FROM employees
WHERE last_name LIKE 'e%e' 
GROUP BY last_name;

SELECT DISTINCT first_name, last_name FROM employees
WHERE last_name LIKE 'e%e';
-- Distinct name combinations

SELECT DISTINCT last_name FROM employees
WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%';
-- Chleq, Lindqvist, Qiwen

SELECT COUNT(last_name), last_name FROM employees
WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%'
GROUP BY last_name;
-- Used to find number of people with each last name

SELECT COUNT(*), gender FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
GROUP BY gender;
-- 441 Male, 268 Female


SELECT LOWER(
CONCAT(
SUBSTR(first_name, 1, 1), 
SUBSTR(last_name, 1, 4),
'_', 
SUBSTR(birth_date, 6, 2), 
SUBSTR(birth_date, 3, 2))) 
AS username, COUNT(*) AS n_same_username 
FROM employees 
GROUP BY username
HAVING n_same_username > 1;
-- 13251 Duplicates

DESCRIBE dept_emp;

SELECT COUNT(*) FROM dept_emp WHERE to_date >= NOW() GROUP BY dept_no;
-- There are the necessary amount of rows

DESCRIBE salaries;
SELECT emp_no, COUNT(salary) FROM salaries GROUP BY emp_no;
-- How many different salaries each employee has ever had

SELECT emp_no, MAX(salary) FROM salaries GROUP BY emp_no;
-- Most they have made

SELECT emp_no, MIN(salary) FROM salaries GROUP BY emp_no;
-- Least they have made

SELECT emp_no, STD(salary) FROM salaries GROUP BY emp_no;
-- Standard Dev for each employee's salary

SELECT emp_no, MAX(salary) FROM salaries GROUP BY emp_no HAVING MAX(salary) > 150000 ;
-- Max salaries over 150000

SELECT emp_no, AVG(salary) FROM salaries GROUP BY emp_no HAVING AVG(salary) BETWEEN 80000 AND 90000;
-- Finding AVG for any salaries that AVG within the 80000 to 90000 range

SELECT LOWER(
CONCAT(
SUBSTR(first_name, 1, 1), 
SUBSTR(last_name, 1, 4),
'_', 
SUBSTR(birth_date, 6, 2), 
SUBSTR(birth_date, 3, 2))) 
AS username, COUNT(*) AS n_same_username 
FROM employees 
GROUP BY username
HAVING n_same_username > 1;
-- Test Query, trying to find the actual sum of duplicates instead of just how many usernames have duplicates
-- 27,403 total duplicates 
