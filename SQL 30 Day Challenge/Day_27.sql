/*
Q35. Flipkart
	Write a SQL query to fetch user_ids that have only bought both 'Burger' and 'Cold drink'.
	Expected output column : user_id
*/
-- orders table : user_id, items
SELECT user_id		
FROM orders
GROUP BY user_id
HAVING COUNT(DISTINCT items) = 2
	AND SUM(CASE WHEN items IN ('Burger', 'Cold drinks' THEN 1  ELSE 0 END) =2
;


