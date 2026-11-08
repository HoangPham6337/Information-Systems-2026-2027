USE employees;

-- create new departments
-- d005, d008 -> d010; d001, d007 -> d011
INSERT INTO departments (dept_no, dept_name) VALUES
('d010', 'Research and Development'), ('d011', 'Marketing and Sales');

SELECT * FROM departments
ORDER BY dept_no DESC;

-- set everyone currently working in old departments to end
UPDATE dept_emp
SET to_date = CURRENT_DATE
WHERE
    dept_no IN ('d001', 'd005', 'd005', 'd008')
    AND to_date > CURRENT_DATE;

-- assign employee from d005, d008 -> d010
INSERT INTO dept_emp (emp_no, dept_no, from_date, to_date)
SELECT
    emp_no,
    'd010',
    CURRENT_DATE,
    '9999-01-01'
FROM dept_emp
WHERE dept_no IN ('d005', 'd008') AND to_date = CURRENT_DATE;

-- assign employee from d001, d007 -> d011
INSERT INTO dept_emp (emp_no, dept_no, from_date, to_date)
SELECT
    emp_no,
    'd011',
    CURRENT_DATE,
    '9999-01-01'
FROM dept_emp
WHERE dept_no IN ('d001', 'd007') AND to_date = CURRENT_DATE;

-- same for manager
UPDATE dept_manager
SET to_date = CURRENT_DATE
WHERE
    dept_no IN ('d001', 'd005', 'd005', 'd008')
    AND to_date > CURRENT_DATE;

INSERT INTO dept_manager (emp_no, dept_no, from_date, to_date)
SELECT
    emp_no,
    'd010',
    CURRENT_DATE,
    '9999-01-01'
FROM dept_emp
WHERE dept_no IN ('d005', 'd008') AND to_date = CURRENT_DATE;

INSERT INTO dept_manager (emp_no, dept_no, from_date, to_date)
SELECT
    emp_no,
    'd011',
    CURRENT_DATE,
    '9999-01-01'
FROM dept_emp
WHERE dept_no IN ('d001', 'd007') AND to_date = CURRENT_DATE;
