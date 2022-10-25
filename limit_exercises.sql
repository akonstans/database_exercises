SELECT DISTINCT title FROM titles ORDER BY title DESC
-- Technique Leader, Staff, Senior Staff, Senior Engineer, Manager, Engineer, Assistant Engineer

SELECT * FROM employees
WHERE birth_date LIKE '%-12-25'
AND hire_date BETWEEN '1990-01-01' AND '1999-12-31'
ORDER BY hire_date
LIMIT 5
-- Alselm Cappello, Utz Mandell, Bouchung Schreiter, Baocai Kushner, Petter Stroustrup

SELECT * FROM employees
WHERE birth_date LIKE '%-12-25'
AND hire_date BETWEEN '1990-01-01' AND '1999-12-31'
ORDER BY hire_date
LIMIT 5 OFFSET 45

-- LIMIT will ensure each 'page' is 5 names long while OFFSET can set the 'page' number by skipping through a number of names until the desired 'page' is reached


