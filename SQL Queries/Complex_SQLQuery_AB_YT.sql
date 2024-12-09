--/*Day_01 05/12/2024*/;
--
/*Q1. Derive Points table from icc tournament*/
--
create table icc_world_cup
(
Team_1 varchar(20),
Team_2 varchar(20),
Winner varchar(20)
);

INSERT INTO icc_world_cup values('India','SL','India');
INSERT INTO icc_world_cup values('SL','Aus','Aus');
INSERT INTO icc_world_cup values('SA','Eng','Eng');
INSERT INTO icc_world_cup values('Eng','NZ','NZ');
INSERT INTO icc_world_cup values('Aus','India','India');

select * from icc_world_cup;

/* Expected OUT put
Team Name | matches_played | no_of_wins | no_of_loasses
India, 
SL, 
Aus 
Eng, 
NZ, 
SA
*/


SELECT TEAM_Name , COUNT(*) Matched_played, 
	SUM(CASE WHEN TEAM_NAME= Winner THEN 1 ELSE 0 END) No_of_Wins,
	SUM(CASE WHEN TEAM_NAME != Winner THEN 1 ELSE 0 END) No_of_Losses
FROM
(select distinct (team_1) as Team_Name from icc_world_cup 
UNION
select distinct (team_2) from icc_world_cup) a
JOIN icc_world_cup b ON a.Team_Name = b.Team_1 OR a.Team_Name = b.Team_2
GROUP BY Team_Name;


--Q2. Find new and repeate customer everyday
-- output - order_date, no_of_new_customers, no_of_repeat_customers

create table customer_orders (
order_id integer,
customer_id integer,
order_date date,
order_amount integer
);

insert into customer_orders values(1,100,cast('2022-01-01' as date),2000),(2,200,cast('2022-01-01' as date),2500),(3,300,cast('2022-01-01' as date),2100)
,(4,100,cast('2022-01-02' as date),2000),(5,400,cast('2022-01-02' as date),2200),(6,500,cast('2022-01-02' as date),2700)
,(7,100,cast('2022-01-03' as date),3000),(8,400,cast('2022-01-03' as date),1000),(9,600,cast('2022-01-03' as date),3000)
;

select * from customer_orders	
SELECT order_date,
	COALESCE(SUM(CASE WHEN days = 0 THEN 1 END),0) no_of_new_customers,
	COALESCE(SUM(CASE WHEN days != 0 THEN 1 END),0) no_of_repeat_customers,
	COALESCE(SUM(CASE WHEN days = 0 THEN order_amount END),0) Revenue_new_customers,
	COALESCE(SUM(CASE WHEN days != 0 THEN order_amount END),0) Revenue_repeat_customers
FROM(
	select b.order_date,b.order_amount, DATEDIFF(day,a.first_order_date,b.order_date) days
	FROM(
	select customer_id , min(order_date) first_order_date from customer_orders group by customer_id) a
	JOIN customer_orders b ON b.customer_id =a.customer_id
	)aa
GROUP BY order_date
;

-- Q3.Scenario based Interviews Question for Product companies
--
create table entries ( 
name varchar(20),
address varchar(20),
email varchar(20),
floor int,
resources varchar(10));

insert into entries 
values ('A','Bangalore','A@gmail.com',1,'CPU'),
('A','Bangalore','A1@gmail.com',1,'CPU'),
('A','Bangalore','A2@gmail.com',2,'DESKTOP')
,('B','Bangalore','B@gmail.com',2,'DESKTOP'),
('B','Bangalore','B1@gmail.com',2,'DESKTOP'),
('B','Bangalore','B2@gmail.com',1,'MONITOR');

Select * from entries;

WITH CTE AS(
	SELECT * , RANK() OVER(partition by floor order by no_visit_floor desc) rn
	FROM
	(
	select *
		,count(*) over(partition by name) total_visit
		,count(*) over(partition by name,floor) no_visit_floor
	from entries
	)a
),
distinct_res as
 (select distinct name, resources from entries)

SELECT a.name, total_visit, floor as most_visited_floor 
	,string_agg(resources,',')
FROM
	(
	SELECT name, floor, total_visit
	FROM CTE
	WHERE rn=1
	GROUP BY name, floor, total_visit
	) a
INNER JOIN distinct_res b ON a.name = b.name
group by a.name, total_visit, floor
;


/*-- Day 2 9/12/2024 */

-- Q4.Write a query to provide the date for nth occurance of sunday in the future from given data
-- datepart
/* sunday -1
	monday -2
	friday -6
	saturday -7 
*/
declare @today_date as date = GETDATE();
declare @n int =3;
--set @today_date = GETDATE(); --today's date
--set @n = 3;
select dateadd(week, @n-1,dateadd(day,8 -datepart(weekday,@today_date),@today_date));

--Q5. The pareto principle states that for many outcomes roughly 80% of consequences comes from 20% of cause.ex.
--1 . 80 % of the productivity come from 20% of the employee
--2. 80% of sales comes from 20% of customers
--3. 80% of decisions in a meeting are made in 20% of the time.
--4. 80% of sales comes from 20% of products and services.

WITH product_80_pct_sales as (
SELECT product_id, product_sale
	,SUM(product_sale) over() total_sale
	,0.8*SUM(product_sale) over() total_sale_80_pct
	,SUM(product_sale) over(order by product_sale desc
		ROWS between unbounded preceding and current row) running_sum
	, ROUND((SUM(product_sale) over(order by product_sale desc
		ROWS between unbounded preceding and current row)) / (SUM(product_sale) over())*100,0)
		as sales_running_sum_pct
	,(ROW_number() over(order by product_sale desc)*1.0/count(*) over())*100 product_count_pct
FROM(
	select product_id, ROUND(sum(sales),2) product_sale
		from orders
	group by product_id
	)a
)
SELECT product_id, 
	product_sale, 
	running_sum as sales_running_sum,
	sales_running_sum_pct,
	product_count_pct
FROM product_80_pct_sales
WHERE sales_running_sum_pct <= 80;

/* Q6. Write a query to find personid, name, number of friends, sum of marks of person who
 have friends with total score greater than 100*/

 drop table friend 
Create table friend (pid int, fid int)
insert into friend (pid , fid ) values ('1','2');
insert into friend (pid , fid ) values ('1','3');
insert into friend (pid , fid ) values ('2','1');
insert into friend (pid , fid ) values ('2','3');
insert into friend (pid , fid ) values ('3','5');
insert into friend (pid , fid ) values ('4','2');
insert into friend (pid , fid ) values ('4','3');
insert into friend (pid , fid ) values ('4','5');
drop table person
create table person (PersonID int,	Name varchar(50),	Score int)
insert into person(PersonID,Name ,Score) values('1','Alice','88')
insert into person(PersonID,Name ,Score) values('2','Bob','11')
insert into person(PersonID,Name ,Score) values('3','Devis','27')
insert into person(PersonID,Name ,Score) values('4','Tara','45')
insert into person(PersonID,Name ,Score) values('5','John','63')

select * from person
select * from friend

select a.personid,a.name, count(a.fid) no_of_friends, sum(b.score) sum_friends_score
FROM
(
select p.personid,p.name, f.fid
FROM person p
JOIN friend f
ON p.personid = f.pid
) a
JOIN person b
ON a.fid = b.personid
GROUP by a.personid, a.name
HAVING sum(b.score) > 100
;

/*Q7.trip and users
	Write a query to find the cancellation rate of requests with unbanned users (both client
	and driver must not be banned) each day between "2013-10-01" and "2013-10-03".
	Round cancellation rate to two decimal points.

	The cancellation rate is computed by dividing the number of canceled (by client or driver)
	requests with unbanned users by the total number of requests with unbanned users on that day.
*/

Create table  Trips (id int, client_id int, driver_id int, city_id int, status varchar(50), request_at varchar(50));
Create table Users (users_id int, banned varchar(50), role varchar(50));

insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('1', '1', '10', '1', 'completed', '2013-10-01');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('2', '2', '11', '1', 'cancelled_by_driver', '2013-10-01');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('3', '3', '12', '6', 'completed', '2013-10-01');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('4', '4', '13', '6', 'cancelled_by_client', '2013-10-01');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('5', '1', '10', '1', 'completed', '2013-10-02');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('6', '2', '11', '6', 'completed', '2013-10-02');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('7', '3', '12', '6', 'completed', '2013-10-02');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('8', '2', '12', '12', 'completed', '2013-10-03');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('9', '3', '10', '12', 'completed', '2013-10-03');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('10', '4', '13', '12', 'cancelled_by_driver', '2013-10-03');

insert into Users (users_id, banned, role) values ('1', 'No', 'client');
insert into Users (users_id, banned, role) values ('2', 'Yes', 'client');
insert into Users (users_id, banned, role) values ('3', 'No', 'client');
insert into Users (users_id, banned, role) values ('4', 'No', 'client');
insert into Users (users_id, banned, role) values ('10', 'No', 'driver');
insert into Users (users_id, banned, role) values ('11', 'No', 'driver');
insert into Users (users_id, banned, role) values ('12', 'No', 'driver');
insert into Users (users_id, banned, role) values ('13', 'No', 'driver');

select request_at, count(*) total_trips
from trips
group by request_at;

select request_at , 
	count(CASE WHEN status in ('cancelled_by_driver','cancelled_by_client')
				THEN 1 ELSE null END) cancelled_trips
from trips
group by request_at;

WITH CTE as(
select request_at, id,
	count(DISTINCT t.id) trip_id,
	count(CASE WHEN status in ('cancelled_by_driver','cancelled_by_client')
				THEN 1 ELSE null END) cancelled_trips
from trips t
JOIN
users u
ON (t.client_id = u.users_id or t.driver_id = u.users_id )
	and u.banned = 'No'
GROUP BY request_at, id)

select request_at, sum(trip_id) total_trips, SUM(cancelled_trips) no_of_cancelled_trips
FROM cte
group by request_at;

select * from users;
select * from trips;

select request_at,
	count(*) total_trips,
	count(CASE WHEN status in ('cancelled_by_driver','cancelled_by_client')
				THEN 1 ELSE null END)cancelled_trips,
	1.0*count(CASE WHEN status in ('cancelled_by_driver','cancelled_by_client')
				THEN 1 ELSE null END) / count(*) *100 cancelled_rate_pct
from trips t
INNER JOIN users c ON c.users_id =t.client_id 
INNER JOIN users d ON d.users_id =t.driver_id
WHERE c.banned = 'No' and d.banned = 'No'
group by request_at;