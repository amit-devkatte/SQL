/*Q28. Zomato business anlayst interview Question
	Find the city wise customers count who have placed more than three orders in november 2024
order table : order_id, city, customer_id, order_date, amount
*/

--group by city
-- count(customer)
-- filter more than 3 orders and date in november 2024

SELECT city, count(customer_id) tota_custmer_count
FROM(
	SELECT  city,
			customer_id,
			count(order_id) as n_orders
	FROM orders
	WHERE order_date between '2024-11-01' AND '2024-11-30'
	GROUP BY 1,2
	HAVING count(order_id) > 3
	) as x
GROUP BY city;
);