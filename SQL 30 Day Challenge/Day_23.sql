/*
Q.31 Given the employee table as emp_id and salary,
write a SQL query to find the all salaries greater than the average salary
Return emp_id and salary
*/

SELECT emp_id, salary
FROM employee
WHERE salary > (select avg(salary) from employees) 
;