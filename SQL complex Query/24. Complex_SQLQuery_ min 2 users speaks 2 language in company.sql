--Q24. Google SQL interview Question
-- Find companies who have atleast 2 users who speaks english and german both the language.

--Method 1
select company_id 
from(
	select company_id, user_id
	from company_users
	where language in ('English', 'German')
	group by company_id, user_id
	having count(distinct language) =2
)a
group by company_id
having count(distinct user_id) >= 2;







create table company_users 
(
company_id int,
user_id int,
language varchar(20)
);

insert into company_users values (1,1,'English')
,(1,1,'German')
,(1,2,'English')
,(1,3,'German')
,(1,3,'English')
,(1,4,'English')
,(2,5,'English')
,(2,5,'German')
,(2,5,'Spanish')
,(2,6,'German')
,(2,6,'Spanish')
,(2,7,'English');