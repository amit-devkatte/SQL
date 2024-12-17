-- Day 16
/*
 Write a sql query to find the names of the managers who have at least  five direct 
 reports. ensure that no employee is their own manager.
*/

DROP TABLE IF EXISTS employees;
CREATE TABLE Employees (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    department VARCHAR(255),
    managerId INT
);

INSERT INTO Employees (id, name, department, managerId) VALUES
(101, 'John', 'A', NULL),
(102, 'Dan', 'A', 101),
(103, 'James', 'A', 101),
(104, 'Amy', 'A', 101),
(105, 'Anne', 'A', 101),
(106, 'Ron', 'B', 101),
(107, 'Michael', 'C', NULL),
(108, 'Sarah', 'C', 107),
(109, 'Emily', 'C', 107),
(110, 'Brian', 'C', 107);

select * from employees;
select  m.name manager_name, count(e.name) no_of_reportees
from employees e 
join employees m 
on e.managerid = m.id
group by manager_name
having count(e.name)>=5;


-- Your Task is to find out the total employees who doesn't have any managers!
select count(*) no_of_employees_without_manager from employees e
WHERE managerid is null;

