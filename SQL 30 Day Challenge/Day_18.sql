-- Q.25 Swiggy Business Analyst Interview Question
/*
	Which metro city has the highest number of restaurant orders in september 2021?
	Write a query to retrieve the city name and the total count of orders , ordered by the 
	total count of orders in descending order.
	Metro city - Mumbai, Delhi, Banglore, Hyderabad
	orders table : order_id, restaurant_id, city, order_date
*/

SELECT
	city,
	count(order_id) as total_orders
FROM orders
WHERE city in ('Mumbai', 'Delhi','Banglore','Hyderabad')
		AND date_part('Year', order_date) = 2021 
		AND date_part('Month', order_date) = 9
		-- AND order_date between '2021-09-01' AND '2021-09-30'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1
;
