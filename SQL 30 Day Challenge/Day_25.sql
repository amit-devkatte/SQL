/*
Q33. --Flipkart Business Analyst Interview Question
	Wrire a SQL query to calcualte the running total revenue for each combination of date
	and product ID.Table orders
	Expected output : date, product_id, product_name, revenue, running_total
	order by product_id, date ascending
*/

-- Using Window function
SELECT date, product_id, product_name, revenue,
		sum(revenue) over (partition by date, product_id order by product_id, date) as running_total
FROM orders;

--Using self JOIN
SELECT o1.date,
	o1.product_id,
	o1.product_name,
	o1.revenue
	SUM(o2.revenue)
FROM orders o1
JOIN orders o2
ON o1.product_id = o2.product_id
	and o1.date >= o2.date
GROUP BY 1,2,3,4
ORDER BY 2,1
;