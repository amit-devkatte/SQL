--Day 14
/* 
Write a query to find the top 2 customers who have spent the most money across all 
their orders. Return their names, email, total_amounts spent
order table : order_id, customer_id,order_date, order_amount
customer table : customer_id, customer_name, customer_email
*/

DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    customer_email VARCHAR(100)
);

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers (customer_id, customer_name, customer_email) VALUES
(1, 'John Doe', 'john@example.com'),
(2, 'Jane Smith', 'jane@example.com'),
(3, 'Alice Johnson', 'alice@example.com'),
(4, 'Bob Brown', 'bob@example.com');

INSERT INTO orders (order_id, customer_id, order_date, order_amount) VALUES
(1, 1, '2024-01-03', 50.00),
(2, 2, '2024-01-05', 75.00),
(3, 1, '2024-01-10', 25.00),
(4, 3, '2024-01-15', 60.00),
(5, 2, '2024-01-20', 50.00),
(6, 1, '2024-02-01', 100.00),
(7, 2, '2024-02-05', 25.00),
(8, 3, '2024-02-10', 90.00),
(9, 1, '2024-02-15', 50.00),
(10, 2, '2024-02-20', 75.00);

-- solution
SELECT customer_name, customer_email, total_spent
FROM(
select c.customer_name, c.customer_email, sum(o.order_amount) total_spent
	,ROW_NUMBER() OVER(order by sum(o.order_amount) desc ) as rnk
from orders o
join customers c on c.customer_id = o.customer_id
group by customer_name, c.customer_email
	)
WHERE rnk <=2	
;

select * from orders


/* Find out customers details who has placed highest orders and total count of orders 
and total order amount */

WITH cte as(
select c.customer_id ,
	c.customer_name,
	count(o.order_id) no_of_orders, 
	SUM(o.order_amount) max_order_value,
	RANK() over(order by SUM(o.order_amount) desc) rnk
from customers c 
join orders o 
on c.customer_id = o.customer_id
GROUP by c.customer_id,c.customer_name
order by max_order_value desc
)
select * from cte 
where rnk =1;