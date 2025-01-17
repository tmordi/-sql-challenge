
/*
 SELECT * FROM department;
SELECT * FROM dept_emp;
SELECT * FROM titles;
SELECT * FROM salaries;
DROP TABLE salries
SELECT * FROM employees;
*/

-- All TABLES
CREATE TABLE department (
    dept_no VARCHAR(20) PRIMARY KEY NOT NULL,
    dept_name VARCHAR(20) NOT NULL
);
CREATE TABLE dept_emp (
    emp_no INTEGER NOT NULL,
	dept_no VARCHAR(20) NOT NULL,
	PRIMARY KEY (emp_no, dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
    FOREIGN KEY (dept_no) REFERENCES department(dept_no)
);

CREATE TABLE salaries (
    emp_no INTEGER NOT NULL,
	salary INTEGER NOT NULL,
	PRIMARY KEY (emp_no),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);


CREATE TABLE dept_manager (
    dept_no VARCHAR(10) NOT NULL,
    emp_no INTEGER NOT NULL,
    PRIMARY KEY (dept_no, emp_no),
    FOREIGN KEY (dept_no) REFERENCES department(dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

CREATE TABLE employees (
    emp_no INTEGER PRIMARY KEY NOT NULL,
	emp_title_id VARCHAR(20) NOT NULL,
	birth_date DATE,
	first_name  VARCHAR(20) NOT NULL,
	last_name VARCHAR(20) NOT NULL,
	sex VARCHAR(5) NOT NULL, 
	hire_date DATE NOT NULL,
	FOREIGN KEY (emp_title_id) REFERENCES titles(title_id)
);

CREATE TABLE titles (
    title_id VARCHAR(50) PRIMARY KEY NOT NULL,
	 title VARCHAR(20) NOT NULL
);





-- List the employee number, last name, first name, sex, and salary of each employee (2 points)
SELECT e.emp_no AS "Employee Number", e.last_name AS "Last Name", e.first_name AS "First Name", e.sex AS "Sex", s.salary AS "Salary"
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no;

--List the first name, last name, and hire date for the employees who were hired in 1986 (2 points)
SELECT first_name AS "First Name", last_name AS "Last Name",  hire_date AS "Hire Date"  
FROM employees
WHERE hire_date >= '1/1/1986' AND hire_date <='12/31/1986';

--List the manager of each department along with their department number, department name, employee number, last name, and first name (2 points)
SELECT dpm.dept_no AS "department No", d.dept_name AS "department name", dpm.emp_no AS "employee no", e.Last_name AS "Last Name", e.first_name AS "First Name"
FROM dept_manager dpm
JOIN department d ON dpm.dept_no = d.dept_no 
JOIN employees e ON dpm.emp_no = e.emp_no;
--List the department number for each employee along with that employee’s employee number, last name, first name, and department name (2 points)
SELECT dm.dept_no AS "Department No", dm.emp_no AS "Employee No", e.last_name AS "Last Name", e.first_name AS "First Name", d.dept_name AS "Department Name"
FROM dept_emp dm
JOIN employees e ON dm.emp_no = e.emp_no
JOIN department d ON dm.dept_no = d.dept_no; 
--List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B (2 points)
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

--List each employee in the Sales department, including their employee number, last name, and first name (2 points)
SELECT e.emp_no AS "Employee No", e.last_name AS "Last Name", e.first_name AS "First Name"
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN department d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales';
--List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name (4 points)
SELECT e.emp_no AS "Employee No", e.last_name AS "Last Name", e.first_name AS "First Name"
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN department d ON de.dept_no = d.dept_no
WHERE d.dept_name IN ('Sales', 'Development');
--List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name) (4 points)
SELECT last_name, COUNT(last_name) AS "Frequency Counts"
FROM employees
GROUP BY last_name
ORDER BY "Frequency Counts" DESC;