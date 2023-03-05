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