SELECT e.emp_no, CONCAT(first_name, " ", last_name) AS full_name, de.dept_no, de.from_date, de.to_date,
CASE 
WHEN to_date < '9999-01-01' THEN 0
	ELSE 1
END AS is_current_employee
FROM employees AS e
JOIN dept_emp AS de
	USING(emp_no)
GROUP BY e.emp_no, full_name, de.dept_no, de.from_date;

-- Returns all emps with current employment status. Gives duplicates when employee has changed dept
-- Think I could come to a solution if attempted using two temp tables first to store employee information and second to pull duplicates

SELECT CONCAT(first_name, ' ', last_name) AS full_name,
CASE 
WHEN last_name RLIKE '^[a-h]' THEN 'A-H'
WHEN last_name RLIKE '^[i-q]' THEN 'I-Q'
ELSE 'R-Z'
END AS alpha_group
FROM employees;
SELECT last_name FROM employees WHERE REGEXP_LIKE(last_name, '^[abc]';
-- Organizes employees by alphabetical group
SELECT birth_date FROM employees ORDER BY birth_date;
-- Finding the earliest decade for next query
SELECT
COUNT(CASE WHEN birth_date BETWEEN '1950-01-01' AND '1959-12-31' THEN birth_date ELSE NULL END) AS '50s',
COUNT(CASE WHEN birth_date BETWEEN '1960-01-01' AND '1969-12-31' THEN birth_date ELSE NULL END) AS '60s'
FROM employees;
-- Counting employees by birth decade

SELECT AVG(s.salary) AS average,
   CASE
       WHEN dept_name IN ('research', 'development') THEN 'R&D'
       WHEN dept_name IN ('sales', 'marketing') THEN 'Sales & Marketing'
       WHEN dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
       WHEN dept_name IN ('Finance', 'Human Resources') THEN 'Finance & HR'
       ELSE dept_name
   END AS dept_group
FROM departments AS d
JOIN dept_emp AS de
	ON de.dept_no = d.dept_no
JOIN salaries AS s
	ON s.emp_no = de.emp_no
GROUP BY dept_group;
-- Average salary by dept group