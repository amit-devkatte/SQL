--Day 12 
/* Write a query to show the unique id of each user, if a user does not have a
unique id then replace just show null 

Table: Employees

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| name          | varchar |
+---------------+---------+
id is the primary key (column with unique values) for this table.
Each row of this table contains the id and the name of an employee in a company.
 

Table: EmployeeUNI

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| unique_id     | int     |
+---------------+---------+
(id, unique_id) is the primary key (combination of columns with unique values) for this table.
Each row of this table contains the id and the corresponding unique id of an employee in the company.
*/

DROP TABLE IF EXISTS Employees;
-- Create Employees table
CREATE TABLE Employees (
    id INT PRIMARY KEY,
    name VARCHAR(255)
);

-- Insert sample data into Employees table
INSERT INTO Employees (id, name) VALUES
    (1, 'Alice'),
    (7, 'Bob'),
    (11, 'Meir'),
    (90, 'Winston'),
    (3, 'Jonathan');


DROP TABLE IF EXISTS EmployeeUNI;
-- Create EmployeeUNI table
CREATE TABLE EmployeeUNI (
    id INT PRIMARY KEY,
    unique_id INT
);

-- Insert sample data into EmployeeUNI table
INSERT INTO EmployeeUNI (id, unique_id) VALUES
    (3, 1),
    (11, 2),
    (90, 3);

-- Solution 

select * from employees;
select * from employeeuni;

select * from employees e
left join employeeuni eu 
on eu.id = e.id