--Q33. Write a query to display the records which have 3 or more consecutive rows 
--with the amount of people more than 100 (inclusive ) each day.

--Method 1
select visit_date, no_of_people
from(
	select *
		,count(1) over(partition by cnt) cnt1
	FROM(
		select *, sum(flag) over(order by visit_date) cnt
		FROM (
			select * 
				--,lag(no_of_people,1,no_of_people) over(order by visit_date) prev
				,lag(no_of_people,1,no_of_people) over(order by visit_date) prev
				,case when no_of_people > 100 and (lag(no_of_people,1,no_of_people) over(order by visit_date))>100 then 0 else 1 end as flag
			from stadium
		)a
	)aa
)aaa
where cnt1>=3;

--Method 2
with grp as(
	select *
		,ROW_number() over(order by visit_date) rn
		,id - ROW_number() over(order by visit_date) grp_no
	from stadium
	where no_of_people >=100
)
select id, visit_date , no_of_people
from grp 
where grp_no >=(select grp_no 
				from grp 
				group by grp_no 
				having count(1)>=3);















create table stadium (
id int,
visit_date date,
no_of_people int
);

insert into stadium
values (1,'2017-07-01',10)
,(2,'2017-07-02',109)
,(3,'2017-07-03',150)
,(4,'2017-07-04',99)
,(5,'2017-07-05',145)
,(6,'2017-07-06',1455)
,(7,'2017-07-07',199)
,(8,'2017-07-08',188);

