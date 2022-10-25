USE `employees`;
SELECT * FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name;
-- Irena R and Vidya S
SELECT * FROM employees
WHERE first_name = 'Irena'
OR first_name = 'Vidya'
OR first_name = 'Maya'
ORDER BY first_name, last_name;
-- Irena A and Vidya Z

SELECT * FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY last_name, first_name;
-- Irena A and Maya Z

SELECT * FROM employees
WHERE last_name LIKE 'e%e'
ORDER BY emp_no;
-- 899 employees 10021 Ramzi E and 499648 Tadahiro E

SELECT * FROM employees
WHERE last_name LIKE 'e%e'
ORDER BY hire_date DESC;
-- Teiji E Newest, Sergi E oldest

SELECT * FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
AND birth_date LIKE '%-12-25'
ORDER BY birth_date, hire_date DESC;
-- Khun is oldest newest, and Douadi is newest Oldest

