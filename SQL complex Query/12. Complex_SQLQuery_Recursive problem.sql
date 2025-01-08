
-- Day 12 Complex problems 
--recursive cte

with cte_numbers as (
	select 1 as num  -- anchor query
	union all
	select num + 1    -- recursive query
	from cte_numbers
	where num < 6     -- filter / condition to stop recursion
)
select * from cte_numbers;

----------------------------


with cte as (
	select min(period_start) as dates, max(period_end) as max_date from sales  -- anchor query
	UNION ALL
	select dateadd(day,1, dates), max_date from cte
	where dates < max_date
) 
select product_id , year(dates) as report_year , sum(average_daily_sales) as total_amount
from cte
inner join sales 
on dates between period_start and period_end
group by product_id , year(dates)
order by product_id, report_year
option (maxrecursion 1000);












create table sales (
product_id int,
period_start date,
period_end date,
average_daily_sales int
);

insert into sales values
(1,'2019-01-25','2019-02-28',100),
(2,'2018-12-01','2020-01-01',10),
(3,'2019-12-01','2020-01-31',1);