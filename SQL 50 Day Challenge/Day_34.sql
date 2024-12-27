--Day 34
/*
Write a query to find the second highest salary
*/

-- Create the employees table
CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(50),
    salary DECIMAL(10, 2)
);

-- Insert records for three departments
INSERT INTO employees (name, department, salary) VALUES 
('John Doe', 'Engineering', 63000),
('Jane Smith', 'Engineering', 55000),
('Michael Johnson', 'Engineering', 64000),
('Emily Davis', 'Marketing', 58000),
('Chris Brown', 'Marketing', 56000),
('Emma Wilson', 'Marketing', 59000),
('Alex Lee', 'Sales', 58000),
('Sarah Adams', 'Sales', 58000),
('Ryan Clark', 'Sales', 61000);

--Solution 
select * from employees
order by salary DESC
limit 1 offset 1;

--Solution using window FUNCTION
select * from (
	select *, dense_rank() over(order by salary desc) as sal_rank
from employees
) as subquery
where sal_rank =2;


--find employees with second highest salary from each department

select department, employee_id, employee_name,salary
from(
	select department, employee_id, employee_name,salary,
		dense_rank() over (partition by department order by salary desc) sal_rank
	FROM employees
)
where sal_rank =2;






