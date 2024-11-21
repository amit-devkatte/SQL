/* Q9 UBER data analyst interview question
Write a sql query to obtain the third transaction of every user from 
transactions table 
output the user_id, spend, transaction_date
*/

WITH CTE as 
(
	SELECT user_id, 
			spend, 
			transaction_date,
			ROW_NUMBER() OVER (partition by user_id order by transaction_date) as rn
	FROM transactions
)
 SELECT *
 FROM CTE
 WHERE rn =3;


/*Q10 Find the top 5 products whose revenue has decresed in comparison to the
previous year(both 2022 and 2023) Return the product_name, revenue for the 
previous year, revenue for the current year, revenue decreased and decreased ratio.
(prev_revenue -current_revenue)/prev_revenue) *100
Sales table : product_name, year, revenue

--- if table having date column with diffrent years then first need to filter
for only 2022 and 2023 and aggregate the sale for each year group by product.
*/

WITH revenue AS
(
	SELECT 
		product_name,
		year,
		revenue as current_revenue,
		LAG(revenue) OVER (PARTITION BY product_name ORDER BY year) as prev_revenue
	FROM sales
)
SELECT 
	Product_name,
	prev_revenue,
	current_revenue,
	(prev_revenue - curent_revenue) as revenue_decreased,
	((prev_revenue - curent_revenue)/ prev_revenue)*100 decreased_ratio%
FROM revenue
WHERE prev_revenue IS NOT NULL AND prev_revenue > current_revenue
ORDER BY revenue_decreased DESC
LIMIT 5
;
	









	














