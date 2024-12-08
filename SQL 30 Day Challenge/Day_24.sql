/*
Q32. Consider a table named customers : customer_id, first_name, last_name, email
Write a SQL query to find all the duplicate email addresses in the customer table.
*/

SELECT customer_id, first_name, last_name, email
FROM(
	SELECT customer_id, 
		first_name, 
		last_name, 
		email,
		ROW_NUMBER() OVER (partition by email order by email) as rn
	FROM customers
	)	
WHERE rn > 1
;


SELECT email, count(*) cnt_email
FROM customers
GROUP BY email
HAVING count(email)>1
;