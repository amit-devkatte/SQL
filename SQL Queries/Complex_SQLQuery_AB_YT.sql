/*Day_01 05/12/2024*/;

/*Q1. Derive Points table from icc tournament*/
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
