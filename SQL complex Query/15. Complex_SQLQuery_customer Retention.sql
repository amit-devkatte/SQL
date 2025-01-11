-- 15. customer Retention and customer churn metrics

-------------------------Customer Retention -----------------
select * from transactions;
-- Jan  0
--feb 1 ,2 ,3 ->3

--Solution 1 (self Join)

select month(this_month.order_date) as month_date, count(distinct last_month.cust_id)
from transactions this_month
LEFT JOIN transactions last_month
ON this_month.cust_id = last_month.cust_id 
	and DATEDIFF(month, last_month.order_date, this_month.order_date) =1
group by month(this_month.order_date);

--Solution 2
SELECT count(Distinct cust_id) as returned_customer_count
from(
	select cust_id
	,LAG(order_date) over(partition by cust_id order by month(order_date))  as month_date
	,RANK() over(partition by cust_id order by month(order_date)) as r_ank
	from transactions
	) a
Where r_ank = 2;


-------------------------Customer Churn -----------------
select month(last_month.order_date)as month_num, count(distinct last_month.cust_id) no_customers
from transactions last_month
LEFT JOIN transactions this_month
on this_month.cust_id = last_month.cust_id and datediff(month, last_month.order_date, this_month.order_date)=1
where this_month.cust_id is null
group by month(last_month.order_date);

-------------




create table transactions(
order_id int,
cust_id int,
order_date date,
amount int
);
delete from transactions;
insert into transactions values 
(1,1,'2020-01-15',150)
,(2,1,'2020-02-10',150)
,(3,2,'2020-01-16',150)
,(4,2,'2020-02-25',150)
,(5,3,'2020-01-10',150)
,(6,3,'2020-02-20',150)
,(7,4,'2020-01-20',150)
,(8,5,'2020-02-20',150)
;