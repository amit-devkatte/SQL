--Day 28
/*
	Write a query to find the highest selling product for each customer.
	return cx id, product description, total count of purchase
*/
select * from walmart_eu;

select customerid, description, no_of_purchase
from(
	select customerid
		,description
		,count(*) no_of_purchase
		,rank()over(partition by customerid order by count(*) desc) rnk
	from walmart_eu
	group by 1,2
)
WHERE rnk =1;


/*
Find each country and best selling product 
Return country_name, description, total count of sale
*/

select country, description, total_amount
from(
	select country
		,description
		,sum(unitprice * quantity) as total_amount
		,rank()over(partition by country order by sum(unitprice * quantity) desc) rnk
	from walmart_eu
	group by 1,2
)
WHERE rnk =1;

