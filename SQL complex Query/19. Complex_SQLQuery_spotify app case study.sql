--19. spotify app case study

-- The activity table shows the app installed and app purchase activity for spotify app along with country.

/*Q1 . find total active users each day*/

select event_date, count(distinct user_id) active_users
from activity
group by event_date;

/*Q2 . find total active users each week*/
select datepart (week,event_date) week_no, count(distinct user_id) active_users
from activity
group by datepart (week,event_date);

/*Q3 . Datewise total number of users who made the purchase same day they installed the app*/
--Solution 1
select a.event_date, count(distinct a.user_id) as no_users
from activity a join activity b
on a.user_id = b.user_id
where (a.event_name ='app-installed' and b.event_name= 'app-purchase')
and a.event_date = b.event_date
group by a.event_date;

--solution
select event_date, count(new_user) as no_of_users
from(
	select user_id, event_date, case when count(distinct event_name) =2 then user_id else null end as new_user
	from activity 
	group by user_id, event_date
)a
group by event_date;


/*Q4. percentage of paid users in India , usa and any other country should be tagged as others country percentage_users */

select 
	case when country in ('India', 'USA') then country else 'Other_Country' end as country_category
	,sum(case when event_name ='app-purchase' then 1 else 0 end) as purchase_count
	,cast(sum(case when event_name ='app-purchase' then 1 else 0 end) as float)/ 
		(select sum(case when event_name ='app-purchase' then 1 else 0 end) from activity) *100 as percentage_users
from activity
group by case when country in ('India', 'USA') then country else 'Other_Country' end;

/*Q5. Among all the users who installed the app on a given day, how many did in app purchase on very next day --day wise result*/
select * from activity;
-- Scenario 1
select a.event_date, sum(case when datediff(day, a.event_date,b.event_date) =1 then 1 else 0 end) as no_of_users_Purchase_next_day
from activity a left join activity b on a.user_id = b.user_id and (a.event_name ='app-installed' and b.event_name ='app-purchase')
group by a.event_date

--Scenario 2
select a.event_date, sum(case when datediff(day, a.event_date,b.event_date) = -1 then 1 else 0 end )as no_of_users_Purchase_next_day
from activity a left join activity b on a.user_id = b.user_id and (b.event_name ='app-installed')
group by a.event_date

--,CASE when event_name ='app-installed' then event_date end as app_install_date
--,CASE when event_name ='app-purchase' then event_date end as app_purchase_date






Select * from activity;










CREATE table activity
(
user_id varchar(20),
event_name varchar(20),
event_date date,
country varchar(20)
);
delete from activity;
insert into activity values (1,'app-installed','2022-01-01','India')
,(1,'app-purchase','2022-01-02','India')
,(2,'app-installed','2022-01-01','USA')
,(3,'app-installed','2022-01-01','USA')
,(3,'app-purchase','2022-01-03','USA')
,(4,'app-installed','2022-01-03','India')
,(4,'app-purchase','2022-01-03','India')
,(5,'app-installed','2022-01-03','SL')
,(5,'app-purchase','2022-01-03','SL')
,(6,'app-installed','2022-01-04','Pakistan')
,(6,'app-purchase','2022-01-04','Pakistan');