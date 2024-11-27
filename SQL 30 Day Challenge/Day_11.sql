/* --------------------------------------------------------------------------------------
-- Amazon interview question for entry business analyst
-----------------------------------------------------------------------------------------

Q16. Given the review table , write a query to retrieve the average star rating for each 
product, group by month. the output should display the month as a numerical value, product ID,
and average star rating rounded to two decimal places.
sort the output first by month and then by product ID
reviews table : review_id, user_id,submit_date, product_id, stars 
*/

SELECT
	to_char(submit_date, 'MM') as month, 
	-- EXTRACT( month from submit_date) as month,
	product_id,
	ROUND( avg(stars),2) as avg_ratings
FROM
	reviews
GROUP BY 1,2
ORDER BY month, product_id
;
	
