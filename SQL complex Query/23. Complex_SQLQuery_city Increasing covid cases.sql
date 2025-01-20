--Q23. find the cities where the covid cases are increasing continuosly.

--Method 1 (Using Lead function) (cases Not descreasing)
With cte as
(
	select *
		, case when cases <= coalesce(lead(cases) over(partition by city order by days), cases) 
			   then 1 else 0 end as flag
	from covid
)
select city
from cte
group by city
having count(days) = sum(flag);

--Method 2 (Using Rank function) continuosly increasing
with cte as(
	select city
		,RANK() over(partition by city order by days) - RANK() over(partition by city order by cases) as diff
	from covid
)
select city
from cte
group by city
having count( distinct diff) = 1 and max(diff) =0; 









create table covid(city varchar(50),days date,cases int);
delete from covid;
insert into covid values('DELHI','2022-01-01',100);
insert into covid values('DELHI','2022-01-02',200);
insert into covid values('DELHI','2022-01-03',300);

insert into covid values('MUMBAI','2022-01-01',100);
insert into covid values('MUMBAI','2022-01-02',100);
insert into covid values('MUMBAI','2022-01-03',300);

insert into covid values('CHENNAI','2022-01-01',100);
insert into covid values('CHENNAI','2022-01-02',200);
insert into covid values('CHENNAI','2022-01-03',150);

insert into covid values('BANGALORE','2022-01-01',100);
insert into covid values('BANGALORE','2022-01-02',300);
insert into covid values('BANGALORE','2022-01-03',200);
insert into covid values('BANGALORE','2022-01-04',400);