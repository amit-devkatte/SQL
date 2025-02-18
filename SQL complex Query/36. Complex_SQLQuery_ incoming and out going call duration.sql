--Q36. Write a sql query to determine phone numbers that satisfy below conditions:
--1. the number have both incoming and outgoing calls
--2. the sum of duration of outgoing calls should be greater than sum of incoming calls

select * from call_details;

--Solution 1
with cte as (
	select call_number, call_type,total_duration
	from(
		select call_number, call_type , sum(call_duration) total_duration, count(1) over(partition by call_number) cnt
		from call_details
		where call_type in ('OUT', 'INC')
		group by call_number, call_type
		)a
	where cnt=2
)
select c1.call_number,c1.total_duration as incoming_call_total, c2.total_duration as outgoing_call_total
from cte c1 
join cte c2
on c1.call_number = c2.call_number and c1.call_type !=c2.call_type
where c1.call_type = 'INC' and c2.total_duration > c1.total_duration

--Solution 2

select call_number
from(
	select call_number
		,sum(case when call_type = 'OUT' then call_duration else null end) as out_duration
		,sum(case when call_type = 'INC' then call_duration else null end) as inc_duration
	from call_details
	group by call_number
)a
where out_duration is not null and inc_duration is not null and out_duration> inc_duration;

--solution 3

with out_cte as 
(
	select call_number, sum(call_duration) out_duration
	from call_details
	where call_type ='OUT'
	group by call_number
)
,inc_cte as 
(
	select call_number, sum(call_duration) inc_duration
	from call_details
	where call_type ='INC'
	group by call_number
)
select oc.call_number,out_duration,inc_duration
from out_cte as oc
join INC_cte as ic
on oc.call_number = ic.call_number
where out_duration > inc_duration;









create table call_details  (
call_type varchar(10),
call_number varchar(12),
call_duration int
);

insert into call_details
values ('OUT','181868',13),('OUT','2159010',8)
,('OUT','2159010',178),('SMS','4153810',1),('OUT','2159010',152),('OUT','9140152',18),('SMS','4162672',1)
,('SMS','9168204',1),('OUT','9168204',576),('INC','2159010',5),('INC','2159010',4),('SMS','2159010',1)
,('SMS','4535614',1),('OUT','181868',20),('INC','181868',54),('INC','218748',20),('INC','2159010',9)
,('INC','197432',66),('SMS','2159010',1),('SMS','4535614',1);