USE employees;

-- What is the average salary of each employee
SELECT
    emp_no,
    AVG(salary) AS avg_salary
FROM salaries
GROUP BY emp_no
LIMIT 100;

-- How much was each employee paid in total
SELECT
    emp_no,
    SUM(salary) AS total_salary
FROM salaries
GROUP BY emp_no
LIMIT 100;

-- Minimum, maximum and total salaries of each department
SELECT
    de.dept_no,
    MIN(s.salary) AS min_salary,
    MAX(s.salary) AS max_salary,
    SUM(s.salary) AS total_salary
FROM salaries AS s
INNER JOIN dept_emp AS de ON s.emp_no = de.emp_no
GROUP BY de.dept_no;

-- Which departments have paid more than 20 billion dollars for their employees
SELECT
    d.dept_name,
    SUM(s.salary) AS total_salary
FROM salaries AS s
INNER JOIN dept_emp AS de ON s.emp_no = de.emp_no
INNER JOIN departments AS d ON de.dept_no = d.dept_no
GROUP BY de.dept_no
HAVING total_salary > 20000000000;

-- Total salaries of male employees in each department
SELECT
    d.dept_name,
    SUM(s.salary) AS total_male_salary
FROM salaries AS s
INNER JOIN dept_emp AS de ON s.emp_no = de.emp_no
INNER JOIN departments AS d ON de.dept_no = d.dept_no
INNER JOIN employees AS e ON s.emp_no = e.emp_no
WHERE e.gender = "M"
GROUP BY de.dept_no;

-- Total salaries of department managers for each department, from highest to lowest
SELECT
    d.dept_name,
    SUM(s.salary) AS total_salary
FROM salaries AS s
INNER JOIN dept_manager AS dm ON s.emp_no = dm.emp_no
INNER JOIN departments AS d ON dm.dept_no = d.dept_no
GROUP BY dm.dept_no
ORDER BY total_salary DESC;
