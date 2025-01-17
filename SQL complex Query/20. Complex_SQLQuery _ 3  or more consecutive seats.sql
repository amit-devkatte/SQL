--20. find 3 or more consecutive empty seats

--method 1- lead lag
Select seat_no from (
	select *
		,lag(is_empty,1) over(order by seat_no) as prev_seat1
		,lag(is_empty,2) over(order by seat_no) as prev_seat2
		,lead(is_empty,1) over(order by seat_no) as next_seat1
		,lead(is_empty,2) over(order by seat_no) as next_seat2
	from bms
)a
where (is_empty ='Y' and prev_seat1='Y' and prev_seat2='Y') 
	or (is_empty ='Y' and prev_seat1='Y' and next_seat1='Y') 
	or (is_empty ='Y' and next_seat1='Y' and next_seat2='Y') 

--method 2 - advance aggregation
select seat_no
from(
	select *
		,sum(case when is_empty='Y' then 1 else 0 end) over(order by seat_no rows between 2 preceding and current row) as prev_2
		,sum(case when is_empty='Y' then 1 else 0 end) over(order by seat_no rows between 1 preceding and 1 following) as prev_next
		,sum(case when is_empty='Y' then 1 else 0 end) over(order by seat_no rows between current row and 2 following) as next_2
	from bms
) a
Where prev_2 = 3 or prev_next=3 or next_2=3;

--method 3 - analytical row number fuction 
select seat_no
from(	
	select * , count(diff) over(partition by diff) count_diff
	from(
		select * , (seat_no-row_number() over(order by seat_no)) diff
		from bms
		where is_empty ='Y'
	)a
) aa
Where count_diff >=3;




create table bms (seat_no int ,is_empty varchar(10));
insert into bms values
(1,'N')
,(2,'Y')
,(3,'N')
,(4,'Y')
,(5,'Y')
,(6,'Y')
,(7,'N')
,(8,'Y')
,(9,'Y')
,(10,'Y')
,(11,'Y')
,(12,'N')
,(13,'Y')
,(14,'Y');