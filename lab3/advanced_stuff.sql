USE employees;
-- Full names of employees working in “Sales” department
SELECT
    e.emp_no AS emp_no_sales,
    CONCAT(e.first_name, ' ', e.last_name) AS full_name
FROM employees AS e
INNER JOIN dept_emp AS de ON e.emp_no = de.emp_no
INNER JOIN departments AS d ON de.dept_no = d.dept_no
WHERE d.dept_name = "Sales";

-- Full names of male employees working in “Finance” department
SELECT
    e.emp_no AS emp_no_sales,
    CONCAT(e.first_name, ' ', e.last_name) AS full_name
FROM employees AS e
INNER JOIN dept_emp AS de ON e.emp_no = de.emp_no
INNER JOIN departments AS d ON de.dept_no = d.dept_no
WHERE d.dept_name = "Finance";

-- Salaries of female employees working in “Marketing” department
SELECT
    e.emp_no,
    s.salary,
    CONCAT(e.first_name, ' ', e.last_name) AS full_name
FROM employees AS e
INNER JOIN dept_emp AS de ON e.emp_no = de.emp_no
INNER JOIN departments AS d ON de.dept_no = d.dept_no
INNER JOIN salaries AS s ON de.emp_no = s.emp_no
WHERE d.dept_name = 'Marketing' AND e.gender = 'F';

-- Full names of employees who have the same last name as their manager
SELECT CONCAT(e.first_name, ' ', e.last_name) AS full_name
FROM employees AS e
INNER JOIN dept_emp AS de ON e.emp_no = de.emp_no
INNER JOIN dept_manager AS dm ON de.dept_no = dm.dept_no
INNER JOIN employees AS m ON dm.emp_no = m.emp_no
WHERE e.last_name = m.last_name AND e.emp_no <> m.emp_no;

-- Full names of employees who was paid more than $100000
SELECT CONCAT(e.first_name, ' ', e.last_name) AS full_name
FROM employees AS e
INNER JOIN dept_emp AS de ON e.emp_no = de.emp_no
INNER JOIN salaries AS s ON e.emp_no = s.emp_no
WHERE s.salary > 100000;

-- Names of all departments that have employees paid more than $100000
SELECT d.dept_name
FROM dept_emp AS de
INNER JOIN departments AS d ON de.dept_no = d.dept_no
INNER JOIN salaries AS s ON de.emp_no = s.emp_no
WHERE s.salary > 100000
GROUP BY d.dept_name;
