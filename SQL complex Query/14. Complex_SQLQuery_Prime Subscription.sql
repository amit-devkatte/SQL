--14. Prime subscription rate by product action
/*
Given the following two tables, return the fraction of users, rounded to two decimal places , who accessed amazon music
and upgrade to prime membership within 30 days of signing up.
*/

select * from users;
select * from events;

--Solution 1
WITH CTE as(
select e.user_id,u.join_date, e.access_date,e.type, count(type) over(partition by e.user_id) cnt
from events e join users u on e.user_id = u.user_id
where e.type in ('Music', 'p')
)
select ROUND(cast(count(1) as float) / (select count(1) from events where type ='Music'),2) fraction_of_users
from cte
WHERE cnt=2	and (type ='P' and DATEDIFF(day,join_date, access_date)<=30);





DROP TABLE IF EXISTS users;
create table users
(
user_id integer,
name varchar(20),
join_date date
);
insert into users
values (1, 'Jon', CAST('2-14-20' AS date)), 
(2, 'Jane', CAST('2-14-20' AS date)), 
(3, 'Jill', CAST('2-15-20' AS date)), 
(4, 'Josh', CAST('2-15-20' AS date)), 
(5, 'Jean', CAST('2-16-20' AS date)), 
(6, 'Justin', CAST('2-17-20' AS date)),
(7, 'Jeremy', CAST('2-18-20' AS date));

create table events
(
user_id integer,
type varchar(10),
access_date date
);

insert into events values
(1, 'Pay', CAST('3-1-20' AS date)), 
(2, 'Music', CAST('3-2-20' AS date)), 
(2, 'P', CAST('3-12-20' AS date)),
(3, 'Music', CAST('3-15-20' AS date)), 
(4, 'Music', CAST('3-15-20' AS date)), 
(1, 'P', CAST('3-16-20' AS date)), 
(3, 'P', CAST('3-22-20' AS date));