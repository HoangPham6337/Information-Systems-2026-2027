USE employees;
-- Who have the same name as the managers of the "Finance" deparment?
CREATE OR REPLACE VIEW finance_manager_fullname AS
SELECT
    e.emp_no,
    e.first_name,
    e.last_name
FROM employees AS e
INNER JOIN dept_manager AS dm ON e.emp_no = dm.emp_no
WHERE
    dm.dept_no = (
        SELECT d.dept_no FROM departments AS d
        WHERE d.dept_name = "Finance"
    );

SELECT *
FROM employees AS e
INNER JOIN
    finance_manager_fullname AS fmf
    ON e.first_name = fmf.first_name AND e.last_name = fmf.last_name
WHERE e.emp_no <> fmf.emp_no;

-- Who in the "Production" department were hired after the promotion of the last manager in that department?
CREATE OR REPLACE VIEW production_manager_promotion AS
SELECT MAX(dm.from_date) AS last_promotion_date
FROM dept_manager AS dm
INNER JOIN departments AS d ON dm.dept_no = d.dept_no
WHERE d.dept_name = 'Production';

SELECT
    e.emp_no,
    e.first_name,
    e.last_name
FROM employees AS e
INNER JOIN dept_emp AS de ON e.emp_no = de.emp_no
INNER JOIN departments AS d ON de.dept_no = d.dept_no
WHERE
    d.dept_name = 'Production'
    AND e.hire_date
    > (SELECT pmp.last_promotion_date FROM production_manager_promotion AS pmp);

-- Find the average salary of each department, from highest to lowest
CREATE OR REPLACE VIEW avg_salary_dept AS
SELECT
    de.dept_no,
    AVG(s.salary) AS avg_salary
FROM salaries AS s
INNER JOIN
    dept_emp AS de
    ON
        s.emp_no = de.emp_no
        AND s.from_date >= de.from_date
        AND s.to_date <= de.to_date
GROUP BY de.dept_no;

SELECT
    d.dept_name,
    asd.avg_salary
FROM avg_salary_dept AS asd
INNER JOIN departments AS d ON asd.dept_no = d.dept_no
ORDER BY asd.avg_salary DESC;

-- Find the average salary for each type of Engineer, from highest to lowest
CREATE OR REPLACE VIEW avg_engineer_salary AS
SELECT
    t.title,
    AVG(s.salary) AS avg_salary
FROM titles AS t
INNER JOIN
    salaries AS s
    ON
        t.emp_no = s.emp_no
        AND t.from_date <= s.from_date
        AND t.to_date >= s.to_date
WHERE t.title LIKE '%Engineer'
GROUP BY t.title;

SELECT
    title,
    avg_salary
FROM avg_engineer_salary
ORDER BY avg_salary DESC;
