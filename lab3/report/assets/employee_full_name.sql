USE employees;
SELECT
    emp_no,
    CONCAT(first_name, ' ', last_name) AS full_name
FROM employees
ORDER BY emp_no;
