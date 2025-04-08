--Q52. leetcode hard question: Merge overlapping events in the same hall


select * from hall_events;

with cte1 as(
select * 
,lag(end_date) over(partition by hall_id order by start_date)prev_end_date
, case when start_date <= lag(end_date) over(partition by hall_id order by start_date) then 0 else 1 end as flag
from hall_events
)
,cte2 as(
select *
,sum(flag) over(partition by hall_id order by start_date) as grp_id
from cte1
)
select hall_id,min(start_date) start_date , max(end_date) as end_date
from cte2
group by hall_id, grp_id
order by hall_id








create table hall_events
(
hall_id integer,
start_date date,
end_date date
);
delete from hall_events
insert into hall_events values 
(1,'2023-01-13','2023-01-14')
,(1,'2023-01-14','2023-01-17')
,(1,'2023-01-15','2023-01-17')
,(1,'2023-01-18','2023-01-25')
,(2,'2022-12-09','2022-12-23')
,(2,'2022-12-13','2022-12-17')
,(3,'2022-12-01','2023-01-30');