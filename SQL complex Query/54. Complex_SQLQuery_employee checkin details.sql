--Q54. Write a query to find the output table as below
--employeeid, employee_default_phone_number, totalentry, totallogin, totallogout, latestlogin, latestlogout

select * from employee_checkin_details;
select * from employee_details;

with cte as(
select employeeid,  totalentry
	,sum(totallogin) totallogin
	,sum(totallogout)totallogout 
	,max(latestlogin)latestlogin
	,max(latestlogout)latestlogout
from(
	select * 
		,count(entry_details) over(partition by employeeid ) totalentry
		,case when entry_details ='login' then 1 else 0 end totallogin
		,case when entry_details ='logout' then 1 else 0 end totallogout
		,case when entry_details ='login' then max(timestamp_details) over (partition by employeeid,entry_details) end latestlogin
		,case when entry_details ='logout' then max(timestamp_details) over (partition by employeeid,entry_details) end latestlogout
	from employee_checkin_details
) a
group by employeeid,  totalentry
)
select *
from cte a
left join employee_details b
on a.employeeid = b.employeeid and b.isdefault !='false'






CREATE TABLE employee_checkin_details (
    employeeid	INT,
    entry_details	VARCHAR(512),
    timestamp_details	datetime
);

INSERT INTO employee_checkin_details (employeeid, entry_details, timestamp_details) VALUES
	('1000', 'login', '2023-06-16 01:00:15.34'),
	('1000', 'login', '2023-06-16 02:00:15.34'),
	('1000', 'login', '2023-06-16 03:00:15.34'),
	('1000', 'logout', '2023-06-16 12:00:15.34'),
	('1001', 'login', '2023-06-16 01:00:15.34'),
	('1001', 'login', '2023-06-16 02:00:15.34'),
	('1001', 'login', '2023-06-16 03:00:15.34'),
	('1001', 'logout', '2023-06-16 12:00:15.34');


CREATE TABLE employee_details (
    employeeid	INT,
    phone_number	INT,
    isdefault	VARCHAR(512)
);

INSERT INTO employee_details (employeeid, phone_number, isdefault) VALUES
	('1001', '9999', 'false'),
	('1001', '1111', 'false'),
	('1001', '2222', 'true'),
	('1003', '3333', 'false');