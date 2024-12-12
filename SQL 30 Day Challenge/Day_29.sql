/* Q.37 Walmart Data Analyst Interview Question
Write a solution to select the product id, year, quantity and price 
for the first year of every product sold.
*/

SELECT product_id, 
		MIN(EXTRACT (YEAR from order_date)) as first_year,
		SUM(quantity),
		SUM(price)
FROM sales
GROUP BY product_id
ORDER BY 1;