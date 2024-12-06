/*
Q30. TCS Data Analyst Interview Question

	Wirte a SQL query to retrieve the emp_id, emp_name, manager_name from given employee TABLE
	It's important to note that managers are also employees in the table.
	employees tabel : emp_id, emp_name, manager_id
*/
CREATE TABLE employees
(
	emp_id int PRIMARY KEY,
	emp_name varchar,
	salary int,
	manager_id int,
	FOREIGN key (manager_id) REFERENCES employees(emp_id)
);

-- Inserting records into the employees table
INSERT INTO employees (emp_id, emp_name, manager_id) VALUES
(1, 'John Doe', NULL),           -- John Doe is the manager
(2, 'Jane Smith', 1),            -- Jane Smith reports to John Doe
(3, 'Alice Johnson', 1),         -- Alice Johnson reports to John Doe
(4, 'Bob Williams', 2),          -- Bob Williams reports to Jane Smith
(5, 'Charlie Brown', 2),         -- Charlie Brown reports to Jane Smith
(6, 'David Lee', 3),             -- David Lee reports to Alice Johnson
(7, 'Emily Davis', 3),           -- Emily Davis reports to Alice Johnson
(8, 'Fiona Clark', 4),           -- Fiona Clark reports to Bob Williams
(9, 'George Turner', 4),         -- George Turner reports to Bob Williams
(10, 'Hannah Baker', 5),         -- Hannah Baker reports to Charlie Brown
(11, 'Isaac White', 5),          -- Isaac White reports to Charlie Brown
(12, 'Jessica Adams', 6),        -- Jessica Adams reports to David Lee
(13, 'Kevin Harris', 6);         -- Kevin Harris reports to David Lee

SELECT * from employees;

SELECT e.emp_id,
	e.emp_name,
	e.manager_id,
	m.emp_name as manager_name
FROM employees e
JOIN employees m	
ON e.manager_id = m.emp_id
;
