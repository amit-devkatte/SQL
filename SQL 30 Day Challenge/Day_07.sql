/* Q12. Assume you are given a table containing data on Amazon customers and their spending
on products in different category , write a query to identify the top two highest grossing 
products within each category in the year 2022. The output should include category, product
and total spend
product_spend table : category, product, user_id, spend, transaction_date
*/

WITH CTE As(
      SELECT
    	category,
    	product,
    	SUM(spend) as total_spend,
    	ROW_NUMBER() OVER(partition by category order by SUM(spend) DESC) AS rn
    FROM 
      product_spend
    WHERE 
      EXTRACT(YEAR from transaction_date) = 2022
    GROUP BY 
      category,product
)
SELECT 
  category, 
    product, 
    total_spend
FROM CTE
WHERE rn <3
;