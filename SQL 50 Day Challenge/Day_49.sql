--Day 49
/* Write a query to Identify the busiest day for orders along 
with the total number of orders placed on that day.

You are given a orders table with
columns order_id, order_date
*/
with cte as (
select *, dense_rank() over(order by counts desc) as d_rank
from (
	select order_date, count(*) as counts
	from orders
	group by 1)
)
select * from cte
where d_rank =1;





DROP TABLE IF EXISTS orders;
-- Create table for orders
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    order_date DATE
);

-- Insert sample records for orders
INSERT INTO orders (order_date)
VALUES
    ('2024-05-01'),
    ('2024-05-01'),
    ('2024-05-01'),
    ('2024-05-02'),
    ('2024-05-02'),
    ('2024-05-02'),
    ('2024-05-03'),
    ('2024-05-03'),
    ('2024-05-03'),
    ('2024-05-03'),
    ('2024-05-03'),
    ('2024-05-04'),
    ('2024-05-04'),
    ('2024-05-04'),
    ('2024-05-04'),
    ('2024-05-04'),
    ('2024-05-05'),
    ('2024-05-05'),
    ('2024-05-05'),
    ('2024-05-05'),
    ('2024-05-06'),
    ('2024-05-06'),
    ('2024-05-06'),
    ('2024-05-06'),
    ('2024-05-06');