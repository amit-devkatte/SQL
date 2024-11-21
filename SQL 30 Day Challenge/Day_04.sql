/* IBM Data Analyst interview question
Q.7 customer segementation problem : 
customers table : customer_id, customer_name, age, gender
orders table: order_id, customer_id, order_date, total_amount
Write a sql query to find the average order amount for the male and female customers
seperately. return the results with 2 decimal.
*/

SELECT c.gender AS Gender, ROUND( avg(o.total_amount), 2) as avg_order_amount
FROM customer c
JOIN order o
ON c.customer_id = o.customer_id
GROUP BY gender


/* Q8. Sales table : order_id, order_date, product_id, quantity, price_per_unit
Write a sql query to find out the total sales reveue generated for each month 
in the year 2023.
*/

SELECT 
	TO_CHAR (order_date, 'month') AS month_name, 
	SUM(quantity * price_per_unit)
FROM 
	sales
WHERE 
	EXTRACT(YEAR FROM order_date) = '2023'
GROUP BY 
	month_name
ORDER BY 
	EXTRACT (MONTH FROM order_date)


	