--Day 17
/*
 Write a sql query to find the customers who have made purchases in all categories.
 tables:
 customers :customer_id, customer_name
 purchase : purchase_id, customer_id, product_category
*/

DROP TABLE IF EXISTS customers;
-- Creating the Customers table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50)
);


DROP TABLE IF EXISTS purchases;
-- Creating the Purchases table
CREATE TABLE Purchases (
    purchase_id INT PRIMARY KEY,
    customer_id INT,
    product_category VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Inserting sample data into Customers table
INSERT INTO Customers (customer_id, customer_name) VALUES
    (1, 'Alice'),
    (2, 'Bob'),
    (3, 'Charlie'),
    (4, 'David'),
    (5, 'Emma');

-- Inserting sample data into Purchases table
INSERT INTO Purchases (purchase_id, customer_id, product_category) VALUES
    (101, 1, 'Electronics'),
    (102, 1, 'Books'),
    (103, 1, 'Clothing'),
    (104, 1, 'Electronics'),
    (105, 2, 'Clothing'),
    (106, 1, 'Beauty'),
    (107, 3, 'Electronics'),
    (108, 3, 'Books'),
    (109, 4, 'Books'),
    (110, 4, 'Clothing'),
    (111, 4, 'Beauty'),
    (112, 5, 'Electronics'),
    (113, 5, 'Books');

select c.customer_id,c.customer_name, count(DISTINCT p.product_category)  no_of_product_cat
from customers c
join purchases p 
on c.customer_id = p.customer_id
group by c.customer_id,c.customer_name
having count(DISTINCT p.product_category) = 
		(select count(distinct product_category) from purchases);


/*
Task:
Write an SQL query to identify customers who have not made any purchases 
in Electronics categories.
*/
select customer_name
from( 
	select distinct customer_id from purchases
	where customer_id not in 
		(select DISTINCT customer_id 
			from purchases 
				where product_category = 'Electronics') 
) a
left Join customers b
on a.customer_id = b.customer_id
;

select * from purchases