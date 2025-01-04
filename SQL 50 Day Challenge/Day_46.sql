--Day 46

/*Write a query to Calculate the running total of orders for each customer. */

select *,
	sum(total_amount) over(partition by customer_id order by order_date) running_total
from orders;



/* Write a query to find each customer_id and revenue collected from them in each month*/

select customer_id
	,extract(month from order_date) 
	,sum(total_amount)
from orders
group by 1,2
order by 1,2;








DROP TABLE IF EXISTS orders;
-- Create table
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount FLOAT
);

-- Insert records
INSERT INTO orders (customer_id, order_date, total_amount)
VALUES
    (1001, '2024-01-01', 120.25),
    (1002, '2024-01-03', 80.99),
    (1003, '2024-01-05', 160.00),
    (1004, '2024-01-07', 95.50),
    (1001, '2024-02-09', 70.75),
    (1002, '2024-02-11', 220.00),
    (1003, '2024-02-13', 130.50),
    (1004, '2024-02-15', 70.25),
    (1001, '2024-02-17', 60.75),
    (1002, '2024-03-19', 180.99),
    (1003, '2024-03-21', 140.00),
    (1004, '2024-03-23', 110.50),
    (1001, '2024-03-25', 90.25),
    (1002, '2024-03-27', 200.00),
    (1003, '2024-03-29', 160.50),
    (1004, '2024-03-31', 120.75),
    (1001, '2024-03-02', 130.25),
    (1002, '2024-03-04', 90.99),
    (1003, '2024-03-06', 170.00),
    (1004, '2024-04-08', 105.50),
    (1001, '2024-04-10', 80.75),
    (1002, '2024-04-12', 240.00),
    (1003, '2024-04-14', 150.50),
    (1004, '2024-04-16', 80.25),
    (1001, '2024-04-18', 70.75);