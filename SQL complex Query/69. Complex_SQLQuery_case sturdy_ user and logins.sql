--Q69. Complete study case (user & Logins)

select * from users;
select * from logins;

--Q1. Management wants to see all the users that did not login in the past 5 months.(today is 28-Jun-2024)


select *
from(
	select u.*,l.LOGIN_TIMESTAMP, l.SESSION_ID, l.SESSION_SCORE
		,datediff(month, l.login_timestamp, '2024-06-01 00:00:00.000') no_of_months
		,Row_number() over(partition by l.user_id order by l.login_timestamp desc) as rn
	from users u
	left join logins l
	on l.user_id = u.user_id
	)a
where rn =1 and no_of_months>=5

--Q2. for the business units quarterly analysis , calculate how many users and how many sessions were at each quarter
-- order by quarter from newest to oldest.
--return: first day of the quarter, user_cnt, session_cnt

select datepart(quarter, login_timestamp) qtr
	,cast(datetrunc(quarter,login_timestamp) as date) first_day_of_qtr
	, count(distinct user_id) user_cnt
	, count(session_id)session_cnt
from logins
group by datepart(quarter, login_timestamp),cast(datetrunc(quarter,login_timestamp) as date)


--Q3. Display user id's that log-in in january 2024 and did not log-in on november 2023.
--return user id.

select user_id 
from logins
group by user_id
having max(case when concat(year(login_timestamp) , month(LOGIN_TIMESTAMP)) =20241 then 1 else 0 end)=1
	 and max(case when concat(year(login_timestamp) , month(LOGIN_TIMESTAMP)) =202311 then 1 else 0 end) =0

--Q4. Add to the query from 2 the percentage chage in sessions from last quarter.
-- return: first day of quarter, session_cnt, session_cnt_prev, session_percentage_change

with cte as (
select datepart(quarter, login_timestamp) qtr
	,cast(datetrunc(quarter,login_timestamp) as date) first_day_of_qtr
	, count(session_id)session_cnt
from logins
group by datepart(quarter, login_timestamp),cast(datetrunc(quarter,login_timestamp) as date)
)
select *
	,lag(session_cnt) over(order by first_day_of_qtr) session_cnt_prev
	,round((cast(session_cnt as float) /lag(session_cnt) over(order by first_day_of_qtr) -1)*100 ,2) as session_percentage_change
from cte


--Q5. Display the user that had the highest session score for each day. return: date, username, score
with cte as(
select user_id , cast(login_timestamp as date) login_date
	, sum( session_score) as score
from logins
group by user_id , cast(login_timestamp as date)
)
select * from (
	select * 
		,row_number() over(partition by login_date order by score desc) as rn
	from cte ) a
where rn=1
;

--Q6. To indentify our best users - return the users that had a session on every single day since their first login
--(make assumption if needed) return :user_id

with cte as(
select *, count(session_id) over(partition by user_id) cnt, datediff(day, login_date, last_day)+1 diff
from (
	select user_id, 
		cast(login_timestamp as date) login_date, 
		session_id, max(cast(login_timestamp as date)) over() as last_day
	from logins) a
)
select user_id, cnt, max(diff) 
from cte
group by user_id, cnt
having  cnt= max(diff) 

--Q7. on what dates there were no log-in at all. return login_dates
--Solutuion

--we need to need all dates between min and max dates.

with cte as(
select cast(min(login_timestamp) as date) as first_date , cast(max(login_timestamp) as date) as last_date
from logins
) 
,rec_cte as(
	select first_date from cte
	union all
	select dateadd(day,1 , first_date) from rec_cte
	where first_date < (select last_date from cte)
)
select * from rec_cte
where first_date not in (select distinct cast(login_timestamp as date) from logins)
option(maxrecursion 500)












--Q5. 








DROP TABLE IF EXISTS users;
CREATE TABLE users (
    USER_ID INT PRIMARY KEY,
    USER_NAME VARCHAR(20) NOT NULL,
    USER_STATUS VARCHAR(20) NOT NULL
);

CREATE TABLE logins (
    USER_ID INT,
    LOGIN_TIMESTAMP DATETIME NOT NULL,
    SESSION_ID INT PRIMARY KEY,
    SESSION_SCORE INT,
    FOREIGN KEY (USER_ID) REFERENCES USERS(USER_ID)
);

-- Users Table
INSERT INTO USERS VALUES (1, 'Alice', 'Active');
INSERT INTO USERS VALUES (2, 'Bob', 'Inactive');
INSERT INTO USERS VALUES (3, 'Charlie', 'Active');
INSERT INTO USERS  VALUES (4, 'David', 'Active');
INSERT INTO USERS  VALUES (5, 'Eve', 'Inactive');
INSERT INTO USERS  VALUES (6, 'Frank', 'Active');
INSERT INTO USERS  VALUES (7, 'Grace', 'Inactive');
INSERT INTO USERS  VALUES (8, 'Heidi', 'Active');
INSERT INTO USERS VALUES (9, 'Ivan', 'Inactive');
INSERT INTO USERS VALUES (10, 'Judy', 'Active');

-- Logins Table 

INSERT INTO LOGINS  VALUES (1, '2023-07-15 09:30:00', 1001, 85);
INSERT INTO LOGINS VALUES (2, '2023-07-22 10:00:00', 1002, 90);
INSERT INTO LOGINS VALUES (3, '2023-08-10 11:15:00', 1003, 75);
INSERT INTO LOGINS VALUES (4, '2023-08-20 14:00:00', 1004, 88);
INSERT INTO LOGINS  VALUES (5, '2023-09-05 16:45:00', 1005, 82);

INSERT INTO LOGINS  VALUES (6, '2023-10-12 08:30:00', 1006, 77);
INSERT INTO LOGINS  VALUES (7, '2023-11-18 09:00:00', 1007, 81);
INSERT INTO LOGINS VALUES (8, '2023-12-01 10:30:00', 1008, 84);
INSERT INTO LOGINS  VALUES (9, '2023-12-15 13:15:00', 1009, 79);


-- 2024 Q1
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (1, '2024-01-10 07:45:00', 1011, 86);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (2, '2024-01-25 09:30:00', 1012, 89);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (3, '2024-02-05 11:00:00', 1013, 78);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (4, '2024-03-01 14:30:00', 1014, 91);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (5, '2024-03-15 16:00:00', 1015, 83);

INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (6, '2024-04-12 08:00:00', 1016, 80);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (7, '2024-05-18 09:15:00', 1017, 82);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (8, '2024-05-28 10:45:00', 1018, 87);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (9, '2024-06-15 13:30:00', 1019, 76);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (10, '2024-06-25 15:00:00', 1010, 92);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (10, '2024-06-26 15:45:00', 1020, 93);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (10, '2024-06-27 15:00:00', 1021, 92);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (10, '2024-06-28 15:45:00', 1022, 93);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (1, '2024-01-10 07:45:00', 1101, 86);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (3, '2024-01-25 09:30:00', 1102, 89);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (5, '2024-01-15 11:00:00', 1103, 78);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (2, '2023-11-10 07:45:00', 1201, 82);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (4, '2023-11-25 09:30:00', 1202, 84);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (6, '2023-11-15 11:00:00', 1203, 80);
