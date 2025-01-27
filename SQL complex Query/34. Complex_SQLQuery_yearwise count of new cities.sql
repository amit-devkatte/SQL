--Q34. Write a sql query to find the yearwise count of new cities where udaan started their operation 
--business city table has data from the day uddan has started operation

--Solution 1 (using Window function)
select first_year_city as year, count(distinct city_id)
from(
select *,  year(business_date) yrs
	,first_value(year(business_date)) over(partition by city_id order by year(business_date)) first_year_city
from business_city
)a
group by first_year_city;

--solution 2 (using self join)
with cte as (
	select DATEPART(year, business_date) bus_year, city_id 
	from business_city
)
select a.bus_year, count(distinct a.city_id) as no_of_new_cities
from cte a
left join cte b
on a.bus_year > b.bus_year and a.city_id = b.city_id
where b.city_id is null
group by a.bus_year;







create table business_city (
business_date date,
city_id int
);
delete from business_city;
insert into business_city
values(cast('2020-01-02' as date),3),(cast('2020-07-01' as date),7),(cast('2021-01-01' as date),3),(cast('2021-02-03' as date),19)
,(cast('2022-12-01' as date),3),(cast('2022-12-15' as date),3),(cast('2022-02-28' as date),12);