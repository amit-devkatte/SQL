--Q51. Travel company booking and user analysis


select * from booking_table;
select * from user_table;

--Q1. Write a query to give below columns in  output
/*
	segment |  total_user_count | user_who_booked_flight_in_apr_2022 
	S1				3						2
	s2				2						2
	s3				5						1
*/
select u.segment, 
		count(distinct u.user_id) total_user_count, 
		count(distinct b.user_id) user_who_booked_flight_in_apr_2022
from user_table u
left join booking_table b
on u.user_id = b.user_id and datepart(month,b.booking_date)=4 and line_of_business ='Flight'
group by u.segment

--Q2. Write a query to identify users whose first booking was a hotel booking.

select distinct user_id
from (
select * 
	,rank() over(partition by user_id order by booking_date) rn
from booking_table
)a
where rn=1 and line_of_business ='Hotel';


--Q3. Write a query to calculate the days between first and last day of booking of each user.
--Solution1
select user_id,max(days_between_first_last_booking) days_between_first_last_booking
from(
	select user_id 
		,datediff(day, first_value(booking_date) over(partition by user_id order by booking_date) 
		,last_value(booking_date) over(partition by user_id order by booking_date)) as days_between_first_last_booking
	from booking_table
)a
group by user_id;
--solution 2
select user_id, min(booking_date) first_date, max(booking_date)last_date
	,DATEDIFF(day, min(booking_date),max(booking_date)) days_between_first_last_booking
from booking_table
group by user_id;


--Q4.Write a query to count the number of flight and hotel bookings in each of the segments for the year 2022
select * from booking_table;
select * from user_table;

select segment
	, sum(case when line_of_business = 'Flight' then 1 end) as count_of_flight_booking
	, sum(case when line_of_business = 'Hotel' then 1 end)as count_of_hotel_booking
from user_table u
left join booking_table b
on u.user_id = b.user_id and Year(b.booking_date) =2022
group by segment











CREATE TABLE booking_table(
   Booking_id       VARCHAR(3) NOT NULL 
  ,Booking_date     date NOT NULL
  ,User_id          VARCHAR(2) NOT NULL
  ,Line_of_business VARCHAR(6) NOT NULL
);

INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b1','2022-03-23','u1','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b2','2022-03-27','u2','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b3','2022-03-28','u1','Hotel');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b4','2022-03-31','u4','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b5','2022-04-02','u1','Hotel');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b6','2022-04-02','u2','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b7','2022-04-06','u5','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b8','2022-04-06','u6','Hotel');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b9','2022-04-06','u2','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b10','2022-04-10','u1','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b11','2022-04-12','u4','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b12','2022-04-16','u1','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b13','2022-04-19','u2','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b14','2022-04-20','u5','Hotel');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b15','2022-04-22','u6','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b16','2022-04-26','u4','Hotel');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b17','2022-04-28','u2','Hotel');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b18','2022-04-30','u1','Hotel');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b19','2022-05-04','u4','Hotel');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b20','2022-05-06','u1','Flight');
;
CREATE TABLE user_table(
   User_id VARCHAR(3) NOT NULL
  ,Segment VARCHAR(2) NOT NULL
);
INSERT INTO user_table(User_id,Segment) VALUES ('u1','s1');
INSERT INTO user_table(User_id,Segment) VALUES ('u2','s1');
INSERT INTO user_table(User_id,Segment) VALUES ('u3','s1');
INSERT INTO user_table(User_id,Segment) VALUES ('u4','s2');
INSERT INTO user_table(User_id,Segment) VALUES ('u5','s2');
INSERT INTO user_table(User_id,Segment) VALUES ('u6','s3');
INSERT INTO user_table(User_id,Segment) VALUES ('u7','s3');
INSERT INTO user_table(User_id,Segment) VALUES ('u8','s3');
INSERT INTO user_table(User_id,Segment) VALUES ('u9','s3');
INSERT INTO user_table(User_id,Segment) VALUES ('u10','s3');