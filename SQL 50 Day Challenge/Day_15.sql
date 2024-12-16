--Day 15
/*
Write an SQL query to retrieve the product details for items whose revenue 
decreased compared to the previous month. 
Display the product ID, quantity sold,revenue for both the current and previous months.
*/

-- Creating the orders table
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    order_date DATE,
    product_id INT,
    quantity INT,
    price DECIMAL(10, 2)
);

-- Inserting records for the current month
INSERT INTO orders (order_date, product_id, quantity, price) VALUES
    ('2024-04-01', 1, 10, 50.00),
    ('2024-04-02', 2, 8, 40.00),
    ('2024-04-03', 3, 15, 30.00),
    ('2024-04-04', 4, 12, 25.00),
    ('2024-04-05', 5, 5, 60.00),
    ('2024-04-06', 6, 20, 20.00),
    ('2024-04-07', 7, 18, 35.00),
    ('2024-04-08', 8, 14, 45.00),
    ('2024-04-09', 1, 10, 50.00),
    ('2024-04-10', 2, 8, 40.00);

-- Inserting records for the last month
INSERT INTO orders (order_date, product_id, quantity, price) VALUES
    ('2024-03-01', 1, 12, 50.00),
    ('2024-03-02', 2, 10, 40.00),
    ('2024-03-03', 3, 18, 30.00),
    ('2024-03-04', 4, 14, 25.00),
    ('2024-03-05', 5, 7, 60.00),
    ('2024-03-06', 6, 22, 20.00),
    ('2024-03-07', 7, 20, 35.00),
    ('2024-03-08', 8, 16, 45.00),
    ('2024-03-09', 1, 12, 50.00),
    ('2024-03-10', 2, 10, 40.00);

-- Inserting records for the previous month
INSERT INTO orders (order_date, product_id, quantity, price) VALUES
    ('2024-02-01', 1, 15, 50.00),
    ('2024-02-02', 2, 12, 40.00),
    ('2024-02-03', 3, 20, 30.00),
    ('2024-02-04', 4, 16, 25.00),
    ('2024-02-05', 5, 9, 60.00),
    ('2024-02-06', 6, 25, 20.00),
    ('2024-02-07', 7, 22, 35.00),
    ('2024-02-08', 8, 18, 45.00),
    ('2024-02-09', 1, 15, 50.00),
    ('2024-02-10', 2, 12, 40.00);

WITH revenue as(
select * 
	,lag(current_month_revenue) over (order by month_date) previous_month_revenue
from(
	select date_trunc('month', order_date)::date as month_date
		,sum(quantity * price) current_month_revenue
	from orders
	GROUP by month_date
	)a
)
select *
	from revenue
WHERE current_month_revenue < previous_month_revenue;

-- Task: Write a SQL query to find the products whose total revenue has decreased by 
--more than 10% from the previous month to the current month.

WITH revenue as(
select * 
	,lag(current_month_revenue) over (order by month_date) previous_month_revenue
from(
	select date_trunc('month', order_date)::date as month_date
		,sum(quantity * price) current_month_revenue
	from orders
	GROUP by month_date
	)a
)
select * ,
	ROUND(1-(current_month_revenue*1.0)/ previous_month_revenue,2) as pct_reduction
from revenue
where (1-(current_month_revenue*1.0)/ previous_month_revenue) > 0.10
;








