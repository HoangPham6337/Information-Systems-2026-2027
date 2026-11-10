USE employees;
-- Who have the same name as the managers of the "Finance" department
SELECT *
FROM employees AS x
WHERE (
    x.first_name,
    x.last_name
) IN (
    SELECT
        e.first_name,
        e.last_name
    FROM employees AS e
    INNER JOIN dept_manager AS dm ON e.emp_no = dm.emp_no
    INNER JOIN departments AS d ON dm.dept_no = d.dept_no
    WHERE d.dept_name = 'Finance'
) AND x.emp_no NOT IN (
    SELECT dm.emp_no
    FROM dept_manager AS dm
    INNER JOIN departments AS d ON dm.dept_no = d.dept_no
    WHERE d.dept_name = 'Finance'
);

-- Who in the "Production" department were hired after the promotion of the last manager in that department
SELECT
    e.emp_no,
    e.first_name,
    e.last_name
FROM employees AS e
INNER JOIN dept_emp AS de ON e.emp_no = de.emp_no
INNER JOIN departments AS d ON de.dept_no = d.dept_no
WHERE
    d.dept_name = 'Production'
    AND e.hire_date > (
        SELECT MAX(s_dm.from_date)
        FROM dept_manager AS s_dm
        INNER JOIN departments AS s_d ON s_dm.dept_no = s_d.dept_no
        WHERE s_d.dept_name = 'Production'
    );

-- Find the average salary of each department, from highest to lowest
SELECT
    d.dept_name,
    AVG(x.salary) AS avg_salary
FROM (
    SELECT
        de.dept_no,
        s.salary
    FROM dept_emp AS de
    INNER JOIN
        salaries AS s
        ON
            de.emp_no = s.emp_no
            AND de.from_date <= s.from_date
            AND de.to_date >= s.to_date
) AS x
INNER JOIN departments AS d ON x.dept_no = d.dept_no
GROUP BY d.dept_name
ORDER BY avg_salary DESC;

-- Find the average salary for each type of Engineer, from highest to lowest
SELECT
    x.title,
    AVG(x.salary) AS avg_salary
FROM
    (
        SELECT
            t.title,
            s.salary
        FROM titles AS t
        INNER JOIN
            salaries AS s
            ON
                t.emp_no = s.emp_no
                AND t.from_date <= s.from_date
                AND t.to_date >= s.to_date
        WHERE t.title LIKE '%Engineer'
    ) AS x
GROUP BY x.title
ORDER BY avg_salary DESC;
