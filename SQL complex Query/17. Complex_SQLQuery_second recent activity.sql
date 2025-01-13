
--17. Get the second most recent activity per user , if there is only one activity then return that one.

select * from userActivity;

--Using subquery
select a.username, a.recent_date, b.activity
from
(select 
	username, max(enddate) recent_date
from userActivity
Where enddate < (select max(enddate) from userActivity)
group by username) a
JOIN userActivity b on a. username = b.username and a.recent_date = b.enddate

-- Using window functions


WITH CTE as (
	select *
		,Count(1) over (partition by username) as activity_count
		,Rank() over (partition by username order by enddate desc) rnk
	from userActivity
)
select username , activity, startdate , enddate
from cte
where activity_count = 1 or rnk =2;



create table UserActivity
(
username      varchar(20) ,
activity      varchar(20),
startDate     Date   ,
endDate      Date
);

insert into UserActivity values 
('Alice','Travel','2020-02-12','2020-02-20')
,('Alice','Dancing','2020-02-21','2020-02-23')
,('Alice','Travel','2020-02-24','2020-02-28')
,('Bob','Travel','2020-02-11','2020-02-18');