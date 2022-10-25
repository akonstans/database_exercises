USE employees;

SELECT CONCAT(first_name, SPACE(1), last_name) AS 'full_name' FROM employees
WHERE last_name LIKE 'e%' AND last_name LIKE '%e';
-- created full_name from concat last and first name

SELECT UPPER(CONCAT(first_name, SPACE(1), last_name)) AS 'full_name' FROM employees
WHERE last_name LIKE 'e%' AND last_name LIKE '%e';
-- capitalized the names

SELECT * FROM employees
WHERE birth_date LIKE '%-12-25'
AND hire_date BETWEEN '1990-01-01' AND '1999-12-31'
ORDER BY DATEDIFF(hire_date, NOW());
-- Unsure if DATEDIFF needs dates in a certain order but assumed that the above was correct for what was asked


SELECT MIN(Salary), MAX(Salary) FROM salaries;

SELECT LOWER(
CONCAT(
SUBSTR(first_name, 1, 1), 
SUBSTR(last_name, 1, 4),
'_', 
SUBSTR(birth_date, 6, 2), 
SUBSTR(birth_date, 3, 2))) 
AS 'username', first_name, last_name, birth_date FROM employees 
