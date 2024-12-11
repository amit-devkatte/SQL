/* Day 11 . 

Identify returning customers based on their order history. 
Categorize customers as "Returning" if they have placed more than one return, 
and as "New" otherwise. 

orders table : order_id, customer_id, order_date,product_id,quantity
returns table : return_id, order_id
*/


DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS returns;

-- Create the orders table
CREATE TABLE orders (
    order_id VARCHAR(10),
    customer_id VARCHAR(10),
    order_date DATE,
    product_id VARCHAR(10),
    quantity INT
);

-- Create the returns table
CREATE TABLE returns (
    return_id VARCHAR(10),
    order_id VARCHAR(10)
    );








-- Insert sample records into the orders table
INSERT INTO orders (order_id, customer_id, order_date, product_id, quantity)
VALUES
    ('1001', 'C001', '2023-01-15', 'P001', 4),
    ('1002', 'C001', '2023-02-20', 'P002', 3),
    ('1003', 'C002', '2023-03-10', 'P003', 8),
    ('1004', 'C003', '2023-04-05', 'P004', 2),
    ('1005', 'C004', '2023-05-20', 'P005', 3),
    ('1006', 'C002', '2023-06-15', 'P001', 6),
    ('1007', 'C003', '2023-07-20', 'P002', 1),
    ('1008', 'C004', '2023-08-10', 'P003', 2),
    ('1009', 'C005', '2023-09-05', 'P002', 3),
    ('1010', 'C001', '2023-10-20', 'P002', 1);

-- Insert sample records into the returns table
INSERT INTO returns (return_id, order_id)
VALUES
    ('R001', '1001'),
    ('R002', '1002'),
    ('R003', '1005'),
    ('R004', '1008'),
    ('R005', '1007');


SELECT * FROM orders;
SELECT * FROM returns;

-- Solution


select o.customer_id, count(return_id)
	,case when count(return_id) > 1 then 'Returning' else 'New' end as customer_category
from orders o
LEFT JOIN returns r ON o.order_id = r.order_id
group by o.customer_id
order by customer_id;


/* Categorize products based on their quantity sold into three categories:

"Low Demand": Quantity sold less than or equal to 5.
"Medium Demand": Quantity sold between 6 and 10 (inclusive).
"High Demand": Quantity sold greater than 10.*/


select product_id, sum(Quantity) Quantity_sold
	,case when sum(quantity) <= 5 then 'Low Demand'
		  when sum(quantity) >= 6 and sum(quantity) <= 10 then 'Medium Demand'
		  else 'High Demand' end demand_categories
from orders
group by product_id;




