--Day 45
/*
Write a query to calculate the total order amount for each customer who joined in the current year
orders table : order_id, customer_id, order_date, amount
customers table : customer_id, customer_name, join_date
out put should contain customer name and amount
*/

select c.customer_name, sum(amount) total_amount
FROM orders o
join customers c
on o.customer_id = c.customer_id
where extract(year from current_date) = extract (year from order_date)
group by 1;


/*
Write a sql query to return each month and total orders for current year
*/

select 
	extract(month from order_date) month_number
	,sum(amount) total_amount
from 
	orders
where 
	extract(year from current_date) = extract(year from order_date)
group by 
	1;





