/*
Write a query to find the percentage of immediate orders in the first orders 
of all customers, 

If the customer's preferred delivery date is the same as the order date, 
then the order is called immediate; otherwise, it is called scheduled.
*/

DROP TABLE IF EXISTS delivery;
-- Create the Delivery table
CREATE TABLE Delivery (
    delivery_id SERIAL PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    customer_pref_delivery_date DATE
);

-- Insert data into the Delivery table
INSERT INTO Delivery (customer_id, order_date, customer_pref_delivery_date) VALUES
(1, '2019-08-01', '2019-08-02'),
(2, '2019-08-02', '2019-08-02'),
(1, '2019-08-11', '2019-08-12'),
(3, '2019-08-24', '2019-08-24'),
(3, '2019-08-21', '2019-08-22'),
(2, '2019-08-11', '2019-08-13'),
(4, '2019-08-09', '2019-08-09'),
(5, '2019-08-09', '2019-08-10'),
(4, '2019-08-10', '2019-08-12'),
(6, '2019-08-09', '2019-08-11'),
(7, '2019-08-12', '2019-08-13'),
(8, '2019-08-13', '2019-08-13'),
(9, '2019-08-11', '2019-08-12');

-- Solution

select
ROUND((select count(*)
from(
	select *,
		row_number()Over(partition by customer_id order by order_date) as order_rank
	from delivery
	)a
Where order_date = customer_pref_delivery_date
	and order_rank = 1)*1.0
/
(select count(*) 
from(
	SELECT Distinct On (customer_id) customer_id 
	from delivery 
	group by customer_id ))*100 , 2) as pct_immediate_orders
;
--Day 22
/*
Write an SQL query to determine the percentage of orders where customers 
select next day delivery. 
*/

select 
ROUND((
	(select count(*) from delivery
	where customer_pref_delivery_date = order_date +1)*1.0
/
	(select count(*) from delivery))*100,2) as pct_next_day_delivery;










