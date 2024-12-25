--Day 31

/* Amazon Data Analyst Interview : Top Monthly Sellers

Write a query to list the top 3 sellers in each product category for January.
The output should contain 'seller_id' ,'total_sales' ,'product_category' ,'market_place', and 'month'.
*/

CREATE TABLE sales_data (
    seller_id VARCHAR(10),
    total_sales NUMERIC,
    product_category VARCHAR(20),
    market_place VARCHAR(10),
    month DATE
);



INSERT INTO sales_data (seller_id, total_sales, product_category, market_place, month)
VALUES
('s236', 36486.73, 'electronics', 'in', DATE '2024-01-01'),
('s918', 24286.4, 'books', 'uk', DATE '2024-01-01'),
('s163', 18846.34, 'electronics', 'us', DATE '2024-01-01'),
('s836', 35687.65, 'electronics', 'uk', DATE '2024-01-01'),
('s790', 31050.13, 'clothing', 'in', DATE '2024-01-01'),
('s195', 14299, 'books', 'de', DATE '2024-01-01'),
('s483', 49361.62, 'clothing', 'uk', DATE '2024-01-01'),
('s891', 48847.68, 'electronics', 'de', DATE '2024-01-01'),
('s272', 11324.61, 'toys', 'us', DATE '2024-01-01'),
('s712', 43739.86, 'toys', 'in', DATE '2024-01-01'),
('s968', 36042.66, 'electronics', 'jp', DATE '2024-01-01'),
('s728', 29158.51, 'books', 'us', DATE '2024-01-01'),
('s415', 24593.5, 'electronics', 'uk', DATE '2024-01-01'),
('s454', 35520.67, 'toys', 'in', DATE '2024-01-01'),
('s560', 27320.16, 'electronics', 'jp', DATE '2024-01-01'),
('s486', 37009.18, 'electronics', 'us', DATE '2024-01-01'),
('s749', 36277.83, 'toys', 'de', DATE '2024-01-01'),
('s798', 31162.45, 'electronics', 'in', DATE '2024-01-01'),
('s515', 26372.16, 'toys', 'in', DATE '2024-01-01'),
('s662', 22157.87, 'books', 'in', DATE '2024-01-01'),
('s919', 24963.97, 'toys', 'de', DATE '2024-01-01'),
('s863', 46652.67, 'electronics', 'us', DATE '2024-01-01'),
('s375', 18107.08, 'clothing', 'de', DATE '2024-01-01'),
('s583', 20268.34, 'toys', 'jp', DATE '2024-01-01'),
('s778', 19962.89, 'electronics', 'in', DATE '2024-01-01'),
('s694', 36519.05, 'electronics', 'in', DATE '2024-01-01'),
('s214', 18948.55, 'electronics', 'de', DATE '2024-01-01'),
('s830', 39169.01, 'toys', 'us', DATE '2024-01-01'),
('s383', 12310.73, 'books', 'in', DATE '2024-01-01'),
('s195', 45633.35, 'books', 'de', DATE '2024-01-01'),
('s196', 13643.27, 'books', 'jp', DATE '2024-01-01'),
('s796', 19637.44, 'electronics', 'jp', DATE '2024-01-01'),
('s334', 11999.1, 'clothing', 'de', DATE '2024-01-01'),
('s217', 23481.03, 'books', 'in', DATE '2024-01-01'),
('s123', 36277.83, 'toys', 'uk', DATE '2024-01-01'),
('s383', 17337.392, 'electronics', 'de', DATE '2024-02-01'),
('s515', 13998.997, 'electronics', 'jp', DATE '2024-02-01'),
('s583', 36035.539, 'books', 'jp', DATE '2024-02-01'),
('s195', 18493.564, 'toys', 'de', DATE '2024-02-01'),
('s728', 34466.126, 'electronics', 'de', DATE '2024-02-01'),
('s830', 48950.221, 'electronics', 'us', DATE '2024-02-01'),
('s483', 16820.965, 'electronics', 'uk', DATE '2024-02-01'),
('s778', 48625.281, 'toys', 'in', DATE '2024-02-01'),
('s918', 37369.321, 'clothing', 'de', DATE '2024-02-01'),
('s123', 46372.816, 'electronics', 'uk', DATE '2024-02-01'),
('s195', 18317.667, 'electronics', 'in', DATE '2024-02-01'),
('s798', 41005.313, 'books', 'in', DATE '2024-02-01'),
('s454', 39090.88, 'electronics', 'de', DATE '2024-02-01'),
('s454', 17839.314, 'toys', 'us', DATE '2024-02-01'),
('s798', 31587.685, 'toys', 'in', DATE '2024-02-01'),
('s778', 21237.38, 'books', 'jp', DATE '2024-02-01'),
('s236', 10625.456, 'toys', 'jp', DATE '2024-02-01'),
('s236', 17948.627, 'toys', 'jp', DATE '2024-02-01'),
('s749', 38453.678, 'toys', 'de', DATE '2024-02-01'),
('s790', 47052.035, 'toys', 'uk', DATE '2024-02-01'),
('s272', 34931.925, 'books', 'de', DATE '2024-02-01'),
('s375', 36753.65, 'toys', 'us', DATE '2024-02-01'),
('s214', 32449.737, 'toys', 'in', DATE '2024-02-01'),
('s163', 40431.402, 'electronics', 'in', DATE '2024-02-01'),
('s214', 30909.313, 'electronics', 'in', DATE '2024-02-01'),
('s415', 18068.768, 'electronics', 'jp', DATE '2024-02-01'),
('s836', 46302.659, 'clothing', 'jp', DATE '2024-02-01'),
('s383', 19151.927, 'electronics', 'uk', DATE '2024-02-01'),
('s863', 45218.714, 'books', 'us', DATE '2024-02-01'),
('s830', 18737.617, 'books', 'de', DATE '2024-02-01'),
('s968', 22973.801, 'toys', 'in', DATE '2024-02-01'),
('s334', 20885.29, 'electronics', 'uk', DATE '2024-02-01'),
('s163', 10278.085, 'electronics', 'de', DATE '2024-02-01'),
('s272', 29393.199, 'clothing', 'jp', DATE '2024-02-01'),
('s560', 16731.642, 'electronics', 'jp', DATE '2024-02-01'),
('s583', 38120.758, 'books', 'uk', DATE '2024-03-01'),
('s163', 22035.132, 'toys', 'uk', DATE '2024-03-01'),
('s918', 26441.481, 'clothing', 'jp', DATE '2024-03-01'),
('s334', 35374.054, 'books', 'in', DATE '2024-03-01'),
('s796', 32115.724, 'electronics', 'jp', DATE '2024-03-01'),
('s749', 39128.654, 'toys', 'in', DATE '2024-03-01'),
('s217', 35341.188, 'electronics', 'us', DATE '2024-03-01'),
('s334', 16028.702, 'books', 'us', DATE '2024-03-01'),
('s383', 44334.352, 'toys', 'in', DATE '2024-03-01'),
('s163', 42380.042, 'books', 'jp', DATE '2024-03-01'),
('s483', 16974.657, 'clothing', 'in', DATE '2024-03-01'),
('s236', 37027.605, 'electronics', 'de', DATE '2024-03-01'),
('s196', 45093.574, 'toys', 'uk', DATE '2024-03-01'),
('s486', 42688.888, 'books', 'in', DATE '2024-03-01'),
('s728', 32331.738, 'electronics', 'us', DATE '2024-03-01'),
('s123', 38014.313, 'electronics', 'us', DATE '2024-03-01'),
('s662', 45483.457, 'clothing', 'jp', DATE '2024-03-01'),
('s968', 47425.4, 'books', 'uk', DATE '2024-03-01'),
('s778', 36540.071, 'books', 'in', DATE '2024-03-01'),
('s798', 29424.55, 'toys', 'us', DATE '2024-03-01'),
('s334', 10723.015, 'toys', 'de', DATE '2024-03-01'),
('s662', 24658.751, 'electronics', 'uk', DATE '2024-03-01'),
('s163', 36304.516, 'clothing', 'us', DATE '2024-03-01'),
('s863', 20608.095, 'books', 'de', DATE '2024-03-01'),
('s214', 27375.775, 'toys', 'de', DATE '2024-03-01'),
('s334', 33076.155, 'clothing', 'in', DATE '2024-03-01'),
('s515', 32880.168, 'toys', 'us', DATE '2024-03-01'),
('s195', 48157.143, 'books', 'uk', DATE '2024-03-01'),
('s583', 23230.012, 'books', 'uk', DATE '2024-03-01'),
('s334', 13013.85, 'toys', 'jp', DATE '2024-03-01'),
('s375', 20738.994, 'electronics', 'in', DATE '2024-03-01'),
('s778', 25787.659, 'electronics', 'jp', DATE '2024-03-01'),
('s796', 36845.741, 'clothing', 'uk', DATE '2024-03-01'),
('s214', 21811.624, 'electronics', 'de', DATE '2024-03-01'),
('s334', 15464.853, 'books', 'in', DATE '2024-03-01');

--'seller_id' ,'total_sales' ,'product_category' ,'market_place', and 'month'
select * from sales_data;

Select product_category,seller_id,total_sales,market_place,months
from(
	select seller_id
		,SUM(total_sales) as total_sales
		,product_category
		,market_place
		,to_char(month, 'Month') as months
		,rank() over(partition by product_category order by SUM(total_sales) desc) rnk
	from sales_data
	where EXTRACT(month from month) =1
	group by 3,1,4,5
)
where rnk <=3;


/*
Find out Each market place and their top 3 seller based on total sale
*/
select * from sales_data;

SELECT market_place, seller_id, total_sales
FROM (
	select market_place, seller_id, sum(total_sales) as total_sales
		,rank()over(partition by market_place order by sum(total_sales) desc) as rnk
	from sales_data
	group by 1,2
)
WHERE rnk <=3;








