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