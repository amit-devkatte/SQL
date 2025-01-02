--Day 42
/*
	UBER data analyst interview question
Write a query to find % of ride cancelled by the driver.

uber_ride table : ride_id, ride_time_stamp, ride_status
*/

select * from uber_ride;

select 
	ROUND(count(*)*1.0 / (select count(*) from uber_ride 
		where ride_status in ('cancelled_by_driver', 'cancelled_by_user'))*100,2) as pct_cancellation_by_driver
from uber_ride
where ride_status ='cancelled_by_driver';


/* Write a query to find out how many ride were cancelled by user in the evening hour.
hour >17 is considered as evening hours*/

select count(*) no_ride_canelled_by_user_evening from uber_ride
where ride_status = 'cancelled_by_user'
	and extract(hour from ride_timestamp) >17;






















DROP TABLE IF EXISTS uber_ride;

-- Create the Uber ride table
CREATE TABLE uber_ride (
    ride_id SERIAL PRIMARY KEY,
    ride_timestamp TIMESTAMP,
    ride_status VARCHAR(20)  -- "ride_completed", "cancelled_by_driver" or "cancelled_by_user"
);

-- Insert sample records
INSERT INTO uber_ride (ride_timestamp, ride_status)
VALUES
    ('2024-05-09 08:30:00', 'cancelled_by_driver'),
    ('2024-05-09 09:00:00', 'cancelled_by_user'),
    ('2024-05-09 10:00:00', 'ride_completed'),
    ('2024-05-09 11:00:00', 'cancelled_by_user'),
    ('2024-05-09 12:00:00', 'cancelled_by_driver'),
    ('2024-05-09 13:00:00', 'cancelled_by_user'),
    ('2024-05-09 14:00:00', 'cancelled_by_user'),
    ('2024-05-09 15:00:00', 'cancelled_by_user'),
    ('2024-05-09 16:00:00', 'ride_completed'),
    ('2024-05-09 17:00:00', 'cancelled_by_user'),
    ('2024-05-09 18:00:00', 'ride_completed'),
    ('2024-05-09 19:00:00', 'cancelled_by_user'),
    ('2024-05-09 20:00:00', 'cancelled_by_user'),
    ('2024-05-09 21:00:00', 'cancelled_by_user'),
    ('2024-05-09 22:00:00', 'cancelled_by_driver'),
    ('2024-05-09 13:00:00', 'cancelled_by_user'),
    ('2024-05-09 14:00:00', 'cancelled_by_user'),
    ('2024-05-09 15:00:00', 'cancelled_by_user'),
    ('2024-05-09 16:00:00', 'ride_completed'),
    ('2024-05-09 17:00:00', 'cancelled_by_user'),
    ('2024-05-09 18:00:00', 'cancelled_by_driver'),
    ('2024-05-09 19:00:00', 'cancelled_by_user'),
    ('2024-05-09 20:00:00', 'cancelled_by_user'),
    ('2024-05-09 21:00:00', 'cancelled_by_user'),
    ('2024-05-09 22:00:00', 'cancelled_by_driver');
