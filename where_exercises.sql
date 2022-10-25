USE `employees`
SELECT * FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
-- There are 709 past or current employees with those names
SELECT * FROM employees
WHERE first_name = 'Irena'
OR first_name = 'Vidya'
OR first_name = 'Maya'
-- There are still 709

SELECT COUNT(*) FROM employees
WHERE last_name LIKE 'e%'
-- There are 7330 

SELECT COUNT(*) FROM employees
WHERE last_name LIKE 'e%'
OR last_name LIKE '%e'
-- There are 30723, The Difference is 23,393

SELECT COUNT(*) FROM employees
WHERE last_name LIKE 'e%'
AND last_name LIKE '%e'
-- There are 899 of them

SELECT COUNT(*) FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
-- There are 135214 of them

SELECT COUNT(*) FROM employees
WHERE birth_date LIKE '%-12-25'
-- There are 842 born on Christmas

SELECT COUNT(*) FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
AND birth_date LIKE '%-12-25'
-- There are 362 hired in 90's and born on Christmas

SELECT COUNT(*) FROM employees
WHERE last_name LIKE '%q%'
-- There are 1873 with the letter Q


SELECT COUNT(*) FROM employees
WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%'
-- There are 547 with q but not qu





