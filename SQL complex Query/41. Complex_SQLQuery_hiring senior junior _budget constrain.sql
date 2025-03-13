--Q41 . A company wants to hire new employees. The budget of the company for the seniors is $70000 . 
-- The company criteria for hiring are: Keep hiring the senior with the smallest salary untill you can not hire any more seniors.
--use the remaining budget to hire junior.keep hiring junior with the smallest salary untill you can not hire any more juniors.
--Write a sql query to find the seniors and juniors hired under the mentioned criteria.


select * from candidates;

with cte as (
select *,
	sum(salary) over(partition by experience order by salary) running_sal
from candidates
)
, senior as (
select * 
from cte 
where experience = 'Senior' and running_sal <=70000
)
select *
from cte
where experience = 'Junior' and running_sal <= 70000 - (select  sum(salary) from senior)
union all
select * from senior
;







create table candidates (
emp_id int,
experience varchar(20),
salary int
);
delete from candidates;
insert into candidates values
(1,'Junior',10000),(2,'Junior',15000),(3,'Junior',40000),(4,'Senior',16000),(5,'Senior',20000),(6,'Senior',50000);