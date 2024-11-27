/*Q17 
Indentify IBM High capacity users
Indentify users who have made purchases totaling more than $10,000 in the last month from the 
purchase table.
purchases table : user_id, purchase_date, product_id, amount
*/

SELECT 
	EXTRACT(month from purchase_date) as month
	user_id,
	SUM(amount) as total_amount
FROM 
	purchases
WHERE 
	Extract (month from purchase_date) = Extract(month from current_date) - INTERVAL '1 month'	
GROUP BY 1,2
HAVING SUM(amount) >10000
;

/* Q18.
Average duration of employee's service. 
Given the data on IBM employees, can you find the average duration of service across different
department? The duration of the service is represented as end_date -start_date.
if the end_date is null, consider it as the current_date.
empoyees table: emp_id, emp_name, start_date, end_date, department
*/

SELECT
	department,
	AVG(
		(CASE WHEN end_date ISNULL THEN current_date ELSE end_date END)
	- start_date ) as avg_duration
FROM employees
GROUP BY 1
;












