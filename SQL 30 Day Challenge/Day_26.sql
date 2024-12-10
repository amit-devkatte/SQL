/*
Q34. Amazon Data Analyst Interview Question (Hard Category Question)

	Suppose you have given two tables - Orders and Returns.
	the table contain information regarding orders and returns by customers.
	Wirte a SQL query to find the top 5 customers with the highest percentage OF
	return items out of their total purchases.
	Return Customer_id and the percenatge of return items rounded by 2 decimal places.
*/
-- orders : order_id, customer_id, order_date, order_items, amount
-- returns : return_id, order_id, return_date, return_items, amount

SELECT x.customer_id,  
	(SUM(x.return_items)/ SUM(x.order_items)) *100 as percenatge_return,
FROM(
	SELECT 
	(SELECT order_id,customer_id, sum(order_items) as order_items
	FROM orders
	GROUP BY 1,2) as o
	INNER JOIN
	(SELECT return_id, order_id,sum(return_items) as return_items
	FROM returns
	GROUP BY 1,2) r
	ON o.order_id = r.order_id
	) x
GROUP BY x.customer_id
ORDER BY percenatge_return
LIMIT 5
;

-- Note : The solution may change depends on what input table provided in questions.