--Q46. Write a query to print total rides and profit rides for each driver. 
-- profit ride is when the end location of current ride is same as start location on next ride.

select * from drivers;

--solution using window function
select id, count(profit_ride_flag) total_ride, sum(profit_ride_flag) profit_ride
from(
	select id
		,case when end_loc = lead(start_loc) over(partition by id order by end_time) then 1 else 0 end profit_ride_flag
	from drivers
)a
group by id;

--solution using self join

with rides as(
select *
	,row_number()over(partition by id order by start_time) as row_id
from drivers
)
select a.id, count(1) total_rides ,count(b.id) profit_rides 
from rides a
left join rides b
on a.id = b.id and a.end_loc = b.start_loc and a.row_id+1 = b.row_id
group by a.id
;













create table drivers(id varchar(10), start_time time, end_time time, start_loc varchar(10), end_loc varchar(10));
insert into drivers values('dri_1', '09:00', '09:30', 'a','b'),('dri_1', '09:30', '10:30', 'b','c'),('dri_1','11:00','11:30', 'd','e');
insert into drivers values('dri_1', '12:00', '12:30', 'f','g'),('dri_1', '13:30', '14:30', 'c','h');
insert into drivers values('dri_2', '12:15', '12:30', 'f','g'),('dri_2', '13:30', '14:30', 'c','h');