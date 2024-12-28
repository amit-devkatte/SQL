--Day 36
/*
Write a sql script to display the immediate manager of an employee.
employee table : emp_no, emp_name, manager_id

The script should take an input parameter emp_no and return employees name along with their manager name.
if employee has no manager then display "No Boss" for that employee.
*/

select e.emp_no
	,e.emp_name
	,e.manager_id
	,coalesce (m.emp_name , 'No Boss') manager_name
from employees e
LEFT join employees m
on e.manager_id = m.emp_no





--creating tables
DROP TABLE IF EXISTS Employees;
CREATE TABLE Employees (
  Emp_No DECIMAL(4,0) NOT NULL,
  Emp_Name VARCHAR(10),
  Job_Name VARCHAR(9),
  Manager_Id DECIMAL(4,0),
  HireDate DATE,
  Salary DECIMAL(7,2),
  Commission DECIMAL(7,2),  
  DeptNo DECIMAL(2,0) NOT NULL
);

INSERT INTO Employees (Emp_No, Emp_Name, Job_Name, Manager_Id, HireDate, Salary, Commission, DeptNo) VALUES
(7839, 'KING', 'PRESIDENT', NULL, '1981-11-17', 5000, NULL, 10),
(7698, 'BLAKE', 'MANAGER', 7839, '1981-05-01', 2850, NULL, 30),
(7782, 'CLARK', 'MANAGER', 7839, '1981-06-09', 2450, NULL, 10),
(7566, 'JONES', 'MANAGER', NULL, '1981-04-02', 2975, NULL, 20),
(7788, 'SCOTT', 'ANALYST', 7566, '1987-07-29', 3000, NULL, 20),
(7902, 'FORD', 'ANALYST', 7566, '1981-12-03', 3000, NULL, 20),
(7369, 'SMITH', 'CLERK', 7902, '1980-12-17', 800, NULL, 20),
(7499, 'ALLEN', 'SALESMAN', NULL, '1981-02-20', 1600, 300, 30),
(7521, 'WARD', 'SALESMAN', 7698, '1981-02-22', 1250, 500, 30),
(7654, 'MARTIN', 'SALESMAN', 7698, '1981-09-28', 1250, 1400, 30),
(7844, 'TURNER', 'SALESMAN', 7698, '1981-09-08', 1500, 0, 30),
(7876, 'ADAMS', 'CLERK', NULL, '1987-06-02', 1100, NULL, 20),
(7900, 'JAMES', 'CLERK', 7698, '1981-12-03', 950, NULL, 30),
(7934, 'MILLER', 'CLERK', 7782, '1982-01-23', 1300, NULL, 10);