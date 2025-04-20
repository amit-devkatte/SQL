--Q56. write a query to get the out put as below table, which shows the vacancy in employee name column 
--if total post are more than the existing employees.


--expected output
/*
--------------------------------------------------------------------------------
title				group		level		payscale		employee_name
--------------------------------------------------------------------------------
General manager		A			l-15		 10000			John Smith
Manager				B			l-14		 9000			Jane Doe
Manager				B			l-14		 9000			Michael Brown
Manager				B			l-14		 9000			Emily Johnson
Manager				B			l-14		 9000			Vacant
Manager				B			l-14		 9000			Vacant
Asst. Manager		C			l-13		 8000			William Lee
Asst. Manager		C			l-13		 8000			Jessica Clark
Asst. Manager		C			l-13		 8000			Christopher Harris
Asst. Manager		C			l-13		 8000			Olivia Wilson
Asst. Manager		C			l-13		 8000			Sophia Miller
Asst. Manager		C			l-13		 8000			Daniel Martinez
Asst. Manager		C			l-13		 8000			Vacant
Asst. Manager		C			l-13		 8000			Vacant
Asst. Manager		C			l-13		 8000			Vacant
Asst. Manager		C			l-13		 8000			Vacant
----------------------------------------------------------------------------------
*/

--solution 1

select * from job_positions;
select * from job_employees;

with cte as(
	select id, title, groups, levels, payscale, totalpost, 1 as rn from job_positions
	union all
	select id, title, groups, levels, payscale, totalpost, rn+1  from cte
	where rn+1 <= totalpost
)
,emp as (
select * , rank()over(partition by position_id order by id) rn
from job_employees
)
select cte.title,cte.groups, cte.levels,cte.payscale, coalesce(emp.name, 'Vacant') as employee_name 
from cte
left join emp 
on cte.id = emp.position_id and cte.rn= emp.rn
order by cte.groups,cte.rn

--solution 2

with emp as (
	select * ,row_number()over(partition by position_id order by id) as rn
	from job_employees
),
t1 as(
select row_id as rn from orders where row_id <= (select max(totalpost) from job_positions)
),
-- in above t1 the orders table is used just to generate the rowid column which is already exist in orders table.
-- we may use any other table in database which has row_number or row id columns with enough rows greater than the max requirement. 
-- in our case the max totalpost is 10 so we have to choose table which has rows more than 10 atleast.
cte as (
select * 
from job_positions jp
inner join t1 on t1.rn <= totalpost)
select cte.*, coalesce (emp.name, 'vacant') as name from cte
left join emp on cte.id = emp.position_id and cte.rn = emp.rn
order by cte.id, cte.rn










create table job_positions 
(id  int,
 title varchar(100),                           
 groups varchar(10),
 levels varchar(10),                                                 
 payscale int,                                             
 totalpost int );    
 
insert into job_positions values (1, 'General manager', 'A', 'l-15', 10000, 1); 
insert into job_positions values (2, 'Manager', 'B', 'l-14', 9000, 5); 
insert into job_positions values (3, 'Asst. Manager', 'C', 'l-13', 8000, 10);  

 create table job_employees 
 ( id  int, 
  name   varchar(100),     
  position_id  int 
 );  

insert into job_employees values (1, 'John Smith', 1); 
insert into job_employees values (2, 'Jane Doe', 2);
insert into job_employees values (3, 'Michael Brown', 2);
insert into job_employees values (4, 'Emily Johnson', 2); 
insert into job_employees values (5, 'William Lee', 3); 
insert into job_employees values (6, 'Jessica Clark', 3); 
insert into job_employees values (7, 'Christopher Harris', 3);
insert into job_employees values (8, 'Olivia Wilson', 3);
insert into job_employees values (9, 'Daniel Martinez', 3);
insert into job_employees values (10, 'Sophia Miller', 3)