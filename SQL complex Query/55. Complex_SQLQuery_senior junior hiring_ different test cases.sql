--Q55. An organisation looking to hire candidates for junior and senior positions . They have a total limit of $50000
--budget in all. They have to first fill up the senior positions and then juniors.
--Their are 4 test cases .write a query to idntitfy the no_of_senior and junior positions can be filled.satisfy all the test cases.

--solution 
select * from candidates

with cte as(
	select *
		,sum(salary) over(partition by experience order by salary,emp_id) running_sum
	from candidates
)
,senior_cte as(
select count(*) as Seniors, coalesce (sum(salary),0) as s_salary
from cte
where experience ='senior' and running_sum <= 50000
)
,junior_cte as(
select count(*) as Juniors
	-- sum(case when experience ='Junior' then 1 end) as Junior
	--,sum(case when experience ='senior' then 1 end) as senior --count(*) junior, count(*)senior
from cte
where experience ='junior' and running_sum <= 50000 -(select s_salary from senior_cte)
)
select Juniors, Seniors
from senior_cte, junior_cte







DROP TABLE if exist;
Create table candidates(
emp_id int primary key,
experience varchar(10) not null,
salary int not null);


test case 1:

--expected o/p :
-----------------------------+
-- Junior	|	senior		 |
-----------------------------+
--	3		|		2		 |
-----------------------------=


delete from  candidates;
insert into candidates values(1,'junior',5000);
insert into candidates values(2,'junior',7000);
insert into candidates values(3,'junior',7000);
insert into candidates values(4,'senior',10000);
insert into candidates values(5,'senior',30000);
insert into candidates values(6,'senior',20000);

test case 2:

--expected o/p :
-----------------------------+
-- Junior	|	senior		 |
-----------------------------+
--	0		|		2		 |
-----------------------------+
delete from candidates;
insert into candidates values(20,'junior',10000);
insert into candidates values(30,'senior',15000);
insert into candidates values(40,'senior',30000);

test case 3:

--expected o/p :
-----------------------------+
-- Junior	|	senior		 |
-----------------------------+
--	3		|		0		 |
-----------------------------+
delete from candidates;
insert into candidates values(1,'junior',15000);
insert into candidates values(2,'junior',15000);
insert into candidates values(3,'junior',20000);
insert into candidates values(4,'senior',60000);

test case 4:

--expected o/p :
-----------------------------+
-- Junior	|	senior		 |
-----------------------------+
--	2		|		2		 |
-----------------------------+
delete from candidates;
insert into candidates values(10,'junior',10000);
insert into candidates values(40,'junior',10000);
insert into candidates values(20,'senior',15000);
insert into candidates values(30,'senior',30000);
insert into candidates values(50,'senior',15000);