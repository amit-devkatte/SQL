--Q53. Dynamic dept comapany average salary

--Write a query to find the average salary of department is less than company average salary 
--where company average salary is excluding the comparing department. 


select * from emp_info;

select a.department_id, a.avg_dept_sal,avg(b.salary) as avg_com_sal
from
	(select department_id, avg(salary) avg_dept_sal
	from emp_info
	group by department_id) a
left join emp_info b
on a.department_id != b.department_id
group by a.department_id, a.avg_dept_sal
having avg_dept_sal < avg(b.salary);






create table emp_info(
emp_id int,
emp_name varchar(20),
department_id int,
salary int,
manager_id int,
emp_age int);

insert into emp_info values(1, 'Ankit', 100,10000, 4, 39);
insert into emp_info values (2, 'Mohit', 100, 15000, 5, 48);
insert into emp_info values (3, 'Vikas', 100, 10000,4,37);
insert into emp_info values (4, 'Rohit', 100, 5000, 2, 16);
insert into emp_info values (5, 'Mudit', 200, 12000, 6,55);
insert into emp_info values (6, 'Agam', 200, 12000,2, 14);
insert into emp_info values (7, 'Sanjay', 200, 9000, 2,13);
insert into emp_info values (8, 'Ashish', 200,5000,2,12);
insert into emp_info values (9, 'Mukesh',300,6000,6,51);
insert into emp_info values (10, 'Rakesh',300,7000,6,50);