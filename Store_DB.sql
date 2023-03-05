/* creating table schemas for the 6 tables
=============================================*/

-- titles table 
CREATE TABLE titles (
	title_id VARCHAR(5) NOT NULL PRIMARY KEY,
	title VARCHAR(20) NOT NULL
);
-- verifying titles table
SELECT * FROM titles; 

-- employees table
CREATE TABLE employees (
    emp_no INT NOT NULL PRIMARY KEY,
	emp_title_id VARCHAR(5), 
	FOREIGN KEY (emp_title_id) REFERENCES titles (title_id),
	birth_date DATE,
	first_name VARCHAR(20) NOT NULL, 
	last_name VARCHAR(20) NOT NULL,
	sex VARCHAR(1),
	hire_date DATE
);
-- verifying employees table
SELECT * FROM employees; 

-- salaries table
CREATE TABLE salaries (
	emp_no INT NOT NULL UNIQUE, 
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	salary INT NOT NULL
);
-- verifying salaries table
SELECT * FROM salaries; 

-- departments table
CREATE TABLE departments (
	dept_no VARCHAR(5) NOT NULL PRIMARY KEY,
	dept_name VARCHAR(20) NOT NULL
);
-- verifying departments table
SELECT * FROM departments; 

-- dept_emp table
CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	dept_no VARCHAR(5) NOT NULL, 
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no, dept_no)
);
-- verifying dept_emp table
SELECT * FROM dept_emp; 

-- dept_manager table
CREATE TABLE dept_manager (
	dept_no VARCHAR(5) NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	emp_no INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (dept_no, emp_no)
);
-- verifying dept_manager table
SELECT * FROM dept_manager;

/* Data Analysis
==================*/

--List the employee number, last name, first name, sex, and salary of each employee.
SELECT emp.emp_no AS "Employee Number", 
		emp.last_name AS "Last Name", 
		emp.first_name AS "First Name", 
		emp.sex AS "Gender", 
		sal.salary AS "Salary ($)"
FROM employees AS emp
INNER JOIN salaries AS sal
ON sal.emp_no=emp.emp_no;

-- List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT emp_no AS "Employee Number",
		last_name AS "Last Name", 
		first_name AS "First Name", 
		sex AS "Gender", 
		hire_date AS "Hire Date"
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = 1986;

-- List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT dt.dept_no AS "Department Number", 
		dt.dept_name AS "Department Name",
		dm.emp_no As "Employee Number", 
		emp.last_name AS "Last Name", 
		emp.first_name AS "First Name"
FROM departments AS dt
LEFT JOIN dept_manager AS dm
ON dm.dept_no=dt.dept_no
LEFT JOIN employees AS emp
ON emp.emp_no=dm.emp_no;

-- List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
SELECT de.dept_no AS "Department Number",
		de.emp_no AS "Employee Number", 
		emp.last_name AS "Last Name",
		emp.first_name AS "First Name", 
		dt.dept_name AS "Department Name"
FROM employees AS emp
LEFT JOIN dept_emp AS de
ON de.emp_no=emp.emp_no
LEFT JOIN departments AS dt
ON dt.dept_no=de.dept_no;

-- List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT first_name AS "First Name",
		last_name AS "Last Name",  
		sex AS "Gender"
FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';

-- List each employee in the Sales department, including their employee number, last name, and first name.
SELECT 	emp.emp_no AS "Employee Number", 
		emp.last_name AS "Last Name",
		emp.first_name AS "First Name"
FROM employees AS emp
LEFT JOIN dept_emp AS de
ON de.emp_no=emp.emp_no
LEFT JOIN departments AS dt
ON dt.dept_no=de.dept_no
WHERE dt.dept_name = 'Sales';

-- List each employee in the Sales and Development departments, including their employee number, 
-- last name, first name, and department name.
SELECT 	emp.emp_no AS "Employee Number", 
		emp.last_name AS "Last Name",
		emp.first_name AS "First Name",
		dt.dept_name AS "Department Name"
FROM employees AS emp
LEFT JOIN dept_emp AS de
ON de.emp_no=emp.emp_no
LEFT JOIN departments AS dt
ON dt.dept_no=de.dept_no
WHERE dt.dept_name = 'Sales'
OR dt.dept_name = 'Development';

-- List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT last_name, COUNT(last_name) as "Number of Employees" 
FROM employees
GROUP BY last_name
ORDER BY "Number of Employees" DESC;