--Q11

/*user purchase platform
-- The table logs the spendings history of users that make purchases from an online shopping website which has a desktop 
and a mobile application.
-- Write an SQL query to find the total number of users and the total amount spent using mobile only, desktop only 
and both mobile and desktop together for each date.
*/

select * from spending;


With all_spend as (
	select spend_date, user_id, max(platform) as platform,sum(amount) as amount
	from spending
	group by spend_date, user_id
	having count(distinct platform) =1
	UNION ALL
	select spend_date, user_id, 'both' as platform,sum(amount) as amount
	from spending
	group by spend_date, user_id
	having count(distinct platform) =2
	UNION ALL
	select distinct spend_date, null, 'both' as platform,0 as amount
	from spending
)
select spend_date, platform, sum(amount) total_amount, count(distinct user_id) as total_users
from all_spend
group by spend_date, platform
order by spend_date, platform desc;






create table spending 
(
user_id int,
spend_date date,
platform varchar(10),
amount int
);

insert into spending values(1,'2019-07-01','mobile',100),(1,'2019-07-01','desktop',100),(2,'2019-07-01','mobile',100)
,(2,'2019-07-02','mobile',100),(3,'2019-07-01','desktop',100),(3,'2019-07-02','desktop',100);