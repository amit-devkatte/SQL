/*Q15 Write a SQL query to find for each month and country, the number of transactions
and their total amount, the number of approved transactions and their total amount.
transactions table: id, country, status, amount, trans_date
OUtput : month, contry, trans_count, approved_count, trans_total_amount, approved_total_amount
*/

SELECT
	to_char(trans_date, 'YYYY-MM') as month,
	country,
	count(*) as trans_count,
	SUM(CASE WHEN status= 'approved' THEN 1 ELSE 0 END) as approved_count,
	SUM(amount) as trans_total_amount,
	SUM(CASE WHEN status= 'approved' THEN amount ELSE 0 END) as approved_total_amount
FROM 
	transactions
GROUP BY 1,2
;