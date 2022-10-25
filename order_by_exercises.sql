USE `employees`
SELECT * FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya') ORDER BY first_name
-- There are 709 past or current employees with those names
-- First Irena R Last Vidya S
SELECT * FROM employees
WHERE first_name = 'Irena'
OR first_name = 'Vidya'
OR first_name = 'Maya'
ORDER BY first_name, last_name
-- There are still 709
-- First Irena A Last Vidya Z

SELECT * FROM employees
WHERE first_name = 'Irena'
OR first_name = 'Vidya'
OR first_name = 'Maya'
ORDER BY last_name, first_name
-- First Irena A Last Maya Z


SELECT COUNT(*) FROM employees
WHERE last_name LIKE 'e%' 
-- There are 7330 

SELECT * FROM employees
WHERE last_name LIKE 'e%'
AND last_name LIKE '%e'
ORDER BY hire_date DESC
-- 899 results, Teiji newest Sergei Oldest

SELECT * FROM employees
WHERE last_name LIKE 'e%'
AND last_name LIKE '%e'
ORDER BY emp_no
-- There are 899 of them
-- First is emp 10021 and last is emp 499648 Tad E

SELECT COUNT(*) FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
-- There are 135214 of them

SELECT * FROM employees
WHERE birth_date LIKE '%-12-25'
ORDER BY birth_date ASC, hire_date DESC
-- There are 842 born on Christmas
-- Woody oldest hire youngest, Khun newest hire oldest
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
