--Q29. creation of group key

select * from event_status;

With cte as (
	select *
		, sum(case when status = 'on' and prev_status = 'off' then 1 else 0 end) over(order by event_time) group_key
	from(
		select * 
			, lag(status,1,status) over (order by event_time) as prev_status
		from event_status) a
)
select min(event_time) as login , max(event_time) logoff, count(1)-1 as count
from cte
group by group_key;







create table event_status
(
event_time varchar(10),
status varchar(10)
);
insert into event_status 
values
('10:01','on'),('10:02','on'),('10:03','on'),('10:04','off'),('10:07','on'),('10:08','on'),('10:09','off')
,('10:11','on'),('10:12','off');