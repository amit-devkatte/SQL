--Q57. write a query to find cities where not even a single order was returned.

select * from namaste_orders;
select * from namaste_returns;

--using only join, aggregation , filters
select o.city, count(r.order_id) count_of_returns
from namaste_orders o
left join namaste_returns r
on o.order_id = r.order_id
group by o.city
having count(r.order_id) =0

--solution 2 using subquery

select distinct city from namaste_orders
where city not in (
	select distinct o.city
	from namaste_orders o
	join namaste_returns r
	on o.order_id = r.order_id
)




create table namaste_orders
(
order_id int,
city varchar(10),
sales int
)

create table namaste_returns
(
order_id int,
return_reason varchar(20),
)

insert into namaste_orders
values(1, 'Mysore' , 100),(2, 'Mysore' , 200),(3, 'Bangalore' , 250),(4, 'Bangalore' , 150)
,(5, 'Mumbai' , 300),(6, 'Mumbai' , 500),(7, 'Mumbai' , 800)
;
insert into namaste_returns values
(3,'wrong item'),(6,'bad quality'),(7,'wrong item');