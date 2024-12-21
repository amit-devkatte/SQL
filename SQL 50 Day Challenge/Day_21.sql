/*Calculate total percentage contribution of each product to total revenue*/
-- product table : product_id, product_name, price, qty

DROP TABLE IF EXISTS products;
-- Creating the products table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2),
    quantity_sold INT
);

-- Inserting sample data for products
INSERT INTO products (product_id, product_name, price, quantity_sold) VALUES
    (1, 'iPhone', 899.00, 600),
    (2, 'iMac', 1299.00, 150),
    (3, 'MacBook Pro', 1499.00, 500),
    (4, 'AirPods', 499.00, 800),
    (5, 'Accessories', 199.00, 300);

-- Solution
select product_id, 
	ROUND((product_revenue* 1.0 / total_revenue)*100,2) as pct_contribution
FROM (
	select product_id, sum(price * quantity_sold) as product_revenue
		,sum(price * quantity_sold)over() total_revenue
	from products
	group by product_id
);

--solution without window FUNCTION

select product_id ,
	ROUND((sum(price * quantity_sold) /
	(select sum(price * quantity_sold) from products)*100),2) as pct_contribution
from products
group by product_id;



-- Find what is the contribution of MacBook Pro and iPhone Round the result in two DECIMAL

select product_name ,
	ROUND((sum(price * quantity_sold) /
	(select sum(price * quantity_sold) from products)*100),2) as pct_contribution
from products
where product_name in ('iPhone','MacBook Pro')
group by product_name;

select * from products;







