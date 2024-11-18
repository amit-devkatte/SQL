/* Q1. You have two tables: Product and Supplier
product table columns: product_id, product_name, supplier_id, Price
Supplier table columns: supplier_id, supplier_name, Country

write an SQL query to find the name of the product with the highest
price in each country. return product_name,price,country
	
*/

-- Steps to solve
-- 1. join the tables on supplier_id COLUMN
-- 2. group by country
-- 3. Maximum price for each group
CREATE TABLE supplier
(
	supplier_id int PRIMARY KEY,
	supplier_name VARCHAR(25),
	country VARCHAR (25)
);


CREATE TABLE Product
(
	product_id int PRIMARY KEY,
	product_name VARCHAR(25),
	supplier_id int,
	price float,
	FOREIGN key (supplier_id) REFERENCES supplier(supplier_id)
);

INSERT INTO supplier
VALUES(501, 'alan', 'India'),
		(502, 'rex', 'US'),
		(503, 'dodo', 'India'),
		(504, 'rahul', 'US'),
		(505, 'zara', 'Canda'),
		(506, 'max', 'Canada')
;

INSERT INTO product
VALUES	(201, 'iPhone 14', '501', 1299),
		(202, 'iPhone 8', '502', 999),
		(204, 'iPhone 13', '502', 1199),
		(203, 'iPhone 11', '503', 1199),
		(205, 'iPhone 12', '502', 1199),
		(206, 'iPhone 14', '501', 1399),
		(214, 'iPhone 15', '503', 1499),
		(207, 'iPhone 15', '505', 1499),
		(208, 'iPhone 15', '504', 1499),
		(209, 'iPhone 12', '502', 1299),
		(210, 'iPhone 13', '502', 1199),
		(211, 'iPhone 11', '501', 1099),
		(212, 'iPhone 14', '503', 1399),
		(213, 'iPhone 8', '502', 1099)
;

-- adding more products 

INSERT INTO product
VALUES	(222, 'Samsung Galaxy S21', '504', 1699),
		(223, 'Samsung Galaxy S20', '505', 1899),
		(224, 'Google Pixel 6', '501', 899),
		(225, 'Google Pixel 5', '502', 799),
		(226, 'OnePlus 9 Pro', '503', 1699),
		(227, 'OnePlus 9', '502', 1999),
		(228, 'Xiaomi Mi 11', '501', 899),
		(229, 'Xiaomi Mi 10', '504', 699),
		(230, 'Huawei P40 Pro', '505', 1099),
		(231, 'Huawei P30', '502', 1299),
		(232, 'Sony Xperia 1 III', '503', 1199),
		(233, 'Sony Xperia 5 III', '501', 999),
		(234, 'LG Velvet', '505', 1899),
		(235, 'LG G8 ThinQ', '504', 799),
		(236, 'Motorola Edge Plus', '502', 1099),
		(237, 'Motorola One 5G', '501', 799),
		(238, 'ASUS ROG Phone 5', '503', 1999),
		(239, 'ASUS ZenFone 8', '504', 999),
		(240, 'Nokia 8.3 5G', '502', 899),
		(241, 'Nokia 7.2', '501', 699),
		(242, 'BlackBerry Key2', '504', 1899),
		(243, 'BlackBerry Motion', '502', 799),
		(244, 'HTC U12 Plus', '501', 899),
		(245, 'HTC Desire 20 Pro', '505', 699),
		(246, 'Lenovo Legion Phone Duel', '503', 1499),
		(247, 'Lenovo K12 Note', '504', 1499),
		(248, 'ZTE Axon 30 Ultra', '501', 1299),
		(249, 'ZTE Blade 20', '502', 1599),
		(250, 'Oppo Find X3 Pro', '503', 1999);


-- Solution 1 with CTE

WITH CTE as (
		SELECT * ,
			row_number() over(partition by s.country ORDER by price DESC) as rn,
			Dense_rank() over(partition by s.country order by price DESC) as d_rank
		from product as P
		JOIN supplier as s
		ON p.supplier_id = s.supplier_id
		)
SELECT product_name,price, country
FROM cte
where d_rank=1;

-- Solution 2 using subquery

SELECT product_name, price, country
FROM(
	SELECT *,
	row_number() OVER (partition by s.country ORDER by p.price DESC)as rn
	FROM product as p
	JOIN supplier as s
	ON p.supplier_id = s.supplier_id) as subquery
WHERE rn =1;

/*
	You have two tables : customers and transactions.
	-customer table : customer_id, customer_name, registration_date
	- transaction table: transaction_id, customer_id,transaction_date, amount
-- write a SQL query to calculate the total transaction amount for each customer for
the current year.
the output should contain customer_name and total amount.
*/

CREATE TABLE customers(
	customer_id int PRIMARY key,
	customer_name varchar(25),
	registration_date date
);

CREATE TABLE transactions(
	transaction_id int PRIMARY key,
	customer_id int,
	transaction_date date,
	amount decimal(10,2),
	foreign key (customer_id) REFERENCES customers (customer_id)
);

INSERT INTO customers
VALUES
	(48, 'Rohit', '2011-10-01'),
	(18, 'Virat', '2010-01-25'),
	(07, 'Mahindra','2007-05-19')
;

INSERT INTO transactions
VALUES
	(101,48, '2024-01-20', 500.50),
	(201, 18, '2024-01-20', 50.00),
    (202, 48, '2024-02-05', 75.50),
    (203, 48, '2023-02-22', 100.00),
    (204, 07, '2022-03-15', 200.00),
    (205, 18, '2024-03-20', 120.75),
	(301, 18, '2024-01-20', 50.00),
    (302, 07, '2024-02-05', 75.50),
    (403, 07, '2023-02-22', 100.00),
    (304, 48, '2022-03-15', 200.00),
    (505, 07, '2024-03-20', 120.75)
;

--  Solution ----

SELECT c.customer_name, c.customer_id, sum(t.amount) as total_amount
FROM customers as c
JOIN transactions as t
ON c.customer_id = t.customer_id
WHERE extract(YEAR from t.transaction_date) = extract(YEAR from current_date)
GROUP BY 1,2;




















