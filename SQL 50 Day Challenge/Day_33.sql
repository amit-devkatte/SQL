--Day 33

/* Meta Data Analyst Question 
Output share of US users that are active. 
Write a query return total users and active users and active users share for US.
You have meta table with columns user_id, name, status, country

Active users are the ones with an "open" status in the table.
*/

-- Create table fb_active_users
CREATE TABLE fb_active_users (
    user_id INT,
    name VARCHAR(50),
    status VARCHAR(10),
    country VARCHAR(50)
);

-- Insert records into fb_active_users
INSERT INTO fb_active_users (user_id, name, status, country) VALUES
(33, 'Amanda Leon', 'open', 'Australia'),
(27, 'Jessica Farrell', 'open', 'Luxembourg'),
(18, 'Wanda Ramirez', 'open', 'USA'),
(50, 'Samuel Miller', 'closed', 'Brazil'),
(16, 'Jacob York', 'open', 'Australia'),
(25, 'Natasha Bradford', 'closed', 'USA'),
(34, 'Donald Ross', 'closed', 'China'),
(52, 'Michelle Jimenez', 'open', 'USA'),
(11, 'Theresa John', 'open', 'China'),
(37, 'Michael Turner', 'closed', 'Australia'),
(32, 'Catherine Hurst', 'closed', 'Mali'),
(61, 'Tina Turner', 'open', 'Luxembourg'),
(4, 'Ashley Sparks', 'open', 'China'),
(82, 'Jacob York', 'closed', 'USA'),
(87, 'David Taylor', 'closed', 'USA'),
(78, 'Zachary Anderson', 'open', 'China'),
(5, 'Tiger Leon', 'closed', 'China'),
(56, 'Theresa Weaver', 'closed', 'Brazil'),
(21, 'Tonya Johnson', 'closed', 'Mali'),
(89, 'Kyle Curry', 'closed', 'Mali'),
(7, 'Donald Jim', 'open', 'USA'),
(22, 'Michael Bone', 'open', 'Canada'),
(31, 'Sara Michaels', 'open', 'Denmark');


select * from fb_active_users;

select * 
	,ROUND((active_users_us *1.0 / active_users),2) us_active_user_share
FROM(
	select count(distinct user_id) total_users
		,SUM (case when status ='open' then 1 else 0 end) active_users
		,SUM (case when status ='open' and country = 'USA' then 1 else 0 end) active_users_us
	from fb_active_users
);

/* Find non_active users share for China*/

select * from fb_active_users;
select * 
	,ROUND((nonactive_users_china *1.0 / nonactive_users),2) china_nonactive_user_share
FROM(
	select count(distinct user_id) total_users
		,SUM (case when status ='closed' then 1 else 0 end) nonactive_users
		,SUM (case when status ='closed' and country = 'China' then 1 else 0 end) nonactive_users_china
	from fb_active_users
);



