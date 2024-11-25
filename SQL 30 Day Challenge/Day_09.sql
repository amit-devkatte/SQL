/*Q14. Leetcode -185 Department top 3 salaries
employee table: id, name, salary, departmentID
departmet table: id, name
id is the primary key (column with unique values) for this table.
departmentId is a foreign key (reference column) of the ID from the Department table.

A company's executive are interested in seeing who earns the most money in each of the 
company's department. A high earner in a department is a employee who has a salary in the
top three unique salaries for that department.

Output table : department, employee, salary
*/

SELECT 
	department, 
	employee, 
	salary
FROM
(
	SELECT 
		d.name as department,
		e.name as employee,
		e.salary as salary,
		DENSE_RANK() OVER (partition by d.name order by e.salary desc) as rnk	
	FROM 
		employee e
	JOIN 
		department d
	ON 
		e.departmentID = d.id
) as x
WHERE 
	rnk <=3
ORDER BY 
	department, salary DESC
;




