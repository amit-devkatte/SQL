/*
	Q36. Amazon - Write a query to find top 3 sellers with highest sales amount 
	but lowest return quantity.
	orders table : order_id, seller_id, sales_amount
	returns table : return_id, seller_id, return_qty
*/

DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    seller_id INT,
    sale_amount DECIMAL(10, 2)
);


DROP TABLE IF EXISTS returns;

CREATE TABLE returns (
    return_id INT PRIMARY KEY,
    seller_id INT,
    return_quantity INT
);


INSERT INTO orders (order_id, seller_id, sale_amount) VALUES
(1, 101, 1500.00),
(2, 102, 2200.00),
(3, 103, 1800.00),
(4, 104, 2500.00),
(5, 107, 1900.00),
(6, 106, 2100.00),
(7, 107, 2400.00),
(8, 107, 1700.00),
(9, 108, 2000.00),
(10, 107, 2300.00),
(11, 103, 2600.00),
(12, 102, 2900.00),
(13, 101, 3100.00),
(14, 101, 2800.00),
(15, 101, 3300.00),
(16, 106, 2700.00),
(17, 101, 3000.00),
(18, 108, 3200.00),
(19, 107, 3400.00),
(20, 106, 3500.00),
(21, 101, 3600.00),
(22, 102, 3700.00),
(23, 103, 3800.00),
(24, 102, 3900.00),
(25, 105, 4000.00);

INSERT INTO returns (return_id, seller_id, return_quantity) VALUES
(1, 101, 10),
(2, 102, 5),
(3, 103, 8),
(4, 104, 3),
(5, 105, 12),
(6, 106, 6),
(7, 107, 4),
(8, 108, 9);

-- Solution --

SELECT o.seller_id, total_sale, return_qty FROM
((SELECT seller_id, SUM(sale_amount) as total_sale FROM orders GROUP BY 1) o
LEFT JOIN
(SELECT seller_id, SUM(COALESCE(return_quantity,0)) as return_qty FROM returns GROUP BY 1) r
ON o.seller_id = r.seller_id)
ORDER BY 2 DESC, 3 ASC
;

