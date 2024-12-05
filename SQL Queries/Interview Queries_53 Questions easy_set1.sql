------ 53 Questions and Answers-----------

--Q1. What is the SQL query used for creating database and table.

DROP DATABASE if EXISTS test_db;
CREATE DATABASE test_db;

-- USE test_db
CREATE TABLE amit_test
(
	id int NOT NULL,
	First_name varchar(10) NOT NULL,
	last_name varchar (15)
);

/*Q2. Write a query to create table with same structure with the same structure of another table.
*/
CREATE TABLE employees_copy
AS
(SELECT * FROM employees WHERE 1=2);

-- Q3. Write a SQL query to create table withe same structure and data of another table.
CREATE TABLE employees_copy_1
AS SELECT * FROM employees;

-- Write a query to rename the table name.
select * from employess;
ALTER TABLE employess RENAME TO employees;

-- Q4. Write a query to find 2nd/3rd/nth Highest salary?

--using Subquery
SELECT MAX(salary) FROM employees 
WHERE salary < (select max(salary) from employees 
WHERE salary < (select max(salary) from employees));

-- using LIMIT
SELECT salary from employees
order by salary DESC
LIMIT 1,1 ;  --second Highest salary
/*-- in mySQL LIMIT N-1,M this means N-1 is start position and M is how many records.
--LIMIT 1,1  -- for 2nd Highest salary
*/

--using LIMIT OFFSET
SELECT salary from employees
order by salary DESC
LIMIT 1 OFFSET 1 ; 
/*This gives 2nd highest salary. count start from 0 ie 1 at starting.
	In postgres 
    [ LIMIT { count | ALL } ]
    [ OFFSET start ] */

-- using DISTINCT to find 3rd highest salary
SELECT salary FROM employees e1
WHERE (2) = ( SELECT count(DISTINCT e2.salary) FROM employees e2
			WHERE e2.salary > e1.salary);

-- using WINDOW FUNCTIONS
SELECT salary 
FROM(
	SELECT salary,
		DENSE_RANK() OVER(order by salary desc) d_rank
	FROM employees
	)
WHERE d_rank =3;

--Q5. Write a query to find all employees who holds managerial position.
		--employees table : id, name, manager_id, salary
SELECT e.name
FROM employees e
JOIN employees m
WHERE m.id = e.manager_id;

--Q6. Find names of the employees that begins with 'A' or 'N'
SELECT emp_name FROM employees
WHERE emp_name LIKE 'A%' OR emp_name LIKE 'N%';

--Q7. write a query to find the current date
select current_date, 
	current_timestamp,
	date(now());
select current_date();
select curdate();
 -- note that different function give output in different data types like string, numerical,date
--Q8. (i) Write a query to fetch alternate records from a table.
	
SELECT * 
FROM(
	SELECT *,ROW_NUMBER() OVER(order by id) as rn FROM employees
	)
WHERE rn % 2 =0;  -- for EVEN rows
--WHERE rn % 2 =1; -- for odd rows

--Q8.(ii) Write a query to fetch the common records from two tables.

SELECT * FROM employees1 e1
INNER JOIN employees2 e2
ON e1.emp_id = e2.emp_id;

-- Q9 (i) Write a qery to find duplicate rows in table.
-- Solution1 using group by
SELECT c1, c2, c3, c4, count(*)
FROM employees
GROUP BY 1,2,3,4
HAVING count(*)>1
;
-- solution using window function

SELECT c1,c2,c3,c4
FROM(
	SELECT c1,c2,c3,c4,
		ROW_NUMBER() OVER(PARTITION BY C1,c2,c3,c4) as rn
	FROM employees
	)
WHERE rn > 1;

--Q9.(ii) Write a query used to remove the duplicate rows in table.

DELETE FROM employees
WHERE (
		SELECT c1, c2, c3, c4, count(*)
		FROM employees
		GROUP BY 1,2,3,4
		HAVING count(*)>1
		);

-- Q10. Write a query to find nth record from a table.

--using LIMIT
SELECT * from employees
LIMIT 4,1; 	--5th record (n-1)
-- LIMIT 1 OFFSET 4; --5th record. offset = (n-1)

SELECT * 
FROM( SELECT *, ROW_NUMBER()OVER (order by salary) as rnFROM Employees)
WHERE rn = 5; --5th  record

--Q11. Write a query to find the first & Last 5 records from a table.
--First 5
SELECT * FROM employees
ORDER by id
LIMIT 5;

--Last 5
SELECT * FROM 
(SELECT * FROM employees ORDER by id DESC LIMIT 5)
order by id;

select * from employees
WHERE id > (Select max(id)-5 from employees);

select * from employees
WHERE id > (select count(*) from employees)-5;

--Q12. Write a query to find first and last record from a table.

SELECT * from employees WHERE id = (select min(id) from employees)
UNION ALL
select * from employees where id = (select max(id) from employees); 

-- Q13. Write a query to find distict record without using DISTINCT keyword.

SELECT * FROM employees e1
UNION
SELECT * FROM employees e2;

SELECT id from employees group by id order by id;

SELECT id from employees a
WHERE a.id >= ALL(select b.id from employees b where a.id = b.id) 
order by id; 


-- Q14. Write a query to find maximum salary of each department.

SELECT department ,MAX(salary)
FROM employees 
GROUP BY department;

SELECT * 
FROM (
	SELECT * , RANK() OVER(partition by department order by salary desc) as rn
	FROM employees 
	)
WHERE rn =1;

--Q15. Write a query to find the department wise employee count sorted by department count
-- in ascending order.
SELECT department, count(id) as employee_count
FROM employees
GROUP BY department
ORDER BY employee_count;

--Q16. How will you chane a datatype of a column.

ALTER TABLE employees MODIFY manager_id varchar;

ALTER TABLE employees MODIFY manager_id::varchar;

-- we can use cast() function or :: to do datatype conversion.










