/* Q11. Write a query to calculate the total viewership for the laptops and mobile devices,
where mobile definded as the sum of tablets and phone viewership. output the total 
viewership for laptop_views and total viewership for mobile devices as mobile_views.
*/

SELECT
	SUM(CASE WHEN device_type IN ('Phone', 'Tablet') THEN 1 ELSE 0 END)AS mobile_views,
	SUM(CASE WHEN device_type = 'Laptop' THEN 1 ELSE 0 END) AS laptop_views
FROM viewership
;

