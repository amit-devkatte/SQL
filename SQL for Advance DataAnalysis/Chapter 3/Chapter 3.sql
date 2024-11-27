SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
;

SELECT * 
FROM
	retail_sales
;

SELECT '2020-09-01 00:00:00 -0' at TIME ZONE 'pst';

-- Current date time FUNCTIONS
SELECT 
	CURRENT_DATE,       -- only date no TIMESTAMP
	CURRENT_TIMESTAMP, -- with time zone
	localtimestamp,		-- without time zone	
	NOW(),
	current_time,
	localtime,			-- local means no time zone
	timeofday()			-- out out text with day, month in text name
	-- get_date()   -- not working in postgres
;

SELECT 	'2020-10-04 12:33:35':: timestamp,
		date_trunc ('month', '2020-10-04 12:33:35':: timestamp) as month,
		date_trunc ('year', '2020-10-04 12:33:35':: timestamp)  as year,
		date_trunc ('DAY', '2020-10-04 12:33:35':: timestamp) as day,
		date_trunc ('hour', '2020-10-04 12:33:35':: timestamp) as hour,
		date_trunc ('minute', '2020-10-04 12:33:35':: timestamp) as minute
;

-- date_trunc(text, datetimestamp)  supported in postgres
-- date_format(datetimestamp, '%y%m%d') this is supported in mysql and other databases

/* 
date_part('month', date)  -- return type FLOAT	
to_char(date, 'month')		-- return type TEXT
EXTRACT('MONTH' FROM date)  -- return type numerical


*/
---------------------------------------------------------------------------------------------------
-- Simple trends

SELECT sales_month, sales
FROM retail_sales
WHERE kind_of_business = 'Retail and food services sales, total';

-- aggregating the sales per YEAR

SELECT date_part('YEAR',sales_month) as sales_year,
		SUM(sales) as sales
FROM retail_sales
WHERE kind_of_business = 'Retail and food services sales, total'
GROUP BY 1
ORDER BY 1
;

--------------------------------------------------------------------------------------------------------
--Comapring components
SELECT date_part('year', sales_month) as sales_year,
		kind_of_business,
		SUM(sales)
FROM retail_sales
WHERE kind_of_business in ('Book stores', 'Sporting goods stores', 'Hobby, toy, and game stores' )
GROUP BY 1,2
order by 1,2
;

select distinct(kind_of_business)
from retail_sales
order by 1;

SELECT date_part('year', sales_month) as sales_year,
		kind_of_business,
		sales
from retail_sales
WHERE kind_of_business in ('Men''s clothing stores', 'Women''s clothing stores')
order by 2,1
;
-------------------------------------------------------------------------------------------------
-- yearly sum of sales
SELECT date_part('YEAR', sales_month) as sales_year,
		kind_of_business,
		SUM(sales)
FROM retail_sales
WHERE kind_of_business in ('Men''s clothing stores', 'Women''s clothing stores')
GROUP BY 1,2
order by 1,2
;

--------------------------------------------------------------------------------------------------------
-- using case statement component comparison

WITH CTE AS (
SELECT date_part('YEAR', sales_month) as sales_year,
		SUM(CASE WHEN kind_of_business = 'Men''s clothing stores' THEN sales END) as mens_sale,
		SUM(CASE WHEN kind_of_business = 'Women''s clothing stores' THEN sales END) as womens_sale
FROM retail_sales
WHERE kind_of_business in ('Men''s clothing stores', 'Women''s clothing stores')
GROUP BY 1
order by 1
)
-- Difference, times, %  between the comparing components
SELECT * ,
	womens_sale - mens_sale as women_minus_men_sale,
	ROUND((womens_sale / mens_sale),2) as womens_times_of_mens,
	ROUND((womens_sale/ mens_sale -1)*100 , 2) as women_percent_of_mens
FROM CTE
;
-----------------------------------------------------------------------------------------------------
-- Percent of total calculations ( MONTHLY)

		----using SELF-JOIN
		
SELECT a.sales_month,
	   a.kind_of_business,
	   a.sales,
	   SUM(b.sales) as total_sales,
	   ROUND(a.sales *100 / SUM(b.sales),2) as pct_total_sales
FROM retail_sales a
JOIN retail_sales b
ON a.sales_month = b.sales_month
	AND b.kind_of_business in ('Men''s clothing stores', 'Women''s clothing stores')
WHERE a.kind_of_business in ('Men''s clothing stores', 'Women''s clothing stores')
GROUP BY 1,2,3
ORDER BY 1,2
;

		---- Using WINDOW FUNCTION

SELECT sales_month,
		kind_of_business,
		sales,
		SUM(sales) OVER(partition by sales_month order by sales_month) as total_monthly_sales,
		ROUND(sales * 100 / SUM(sales) OVER(partition by sales_month order by sales_month),2) as pct_monthly_sales
FROM retail_sales
WHERE kind_of_business in ('Men''s clothing stores', 'Women''s clothing stores')
;

-----------------------------------------------------------------------------------------------------
-- Percent of total calculations ( YEARLY )

		----using SELF-JOIN

SELECT  a.sales_month,
		a.kind_of_business,
		a.sales,
		sum(b.sales) as total_yearly_sales,
		a.sales*100 / SUM(b.sales) as pct_yearly
FROM retail_sales a 
JOIN retail_sales b
ON date_part('YEAR', a.sales_month) = date_part('YEAR', b.sales_month)
	AND a.kind_of_business = b.kind_of_business 	
	-- if we dont use above line of code then it will sum all (mens+Womens) yearly sales
	AND b.kind_of_business in ('Men''s clothing stores', 'Women''s clothing stores')
WHERE a.kind_of_business in ('Men''s clothing stores', 'Women''s clothing stores')
GROUP BY 1,2,3
order by 1,2
;

		---- Using WINDOW FUNCTION
SELECT	sales_month, 
		kind_of_business,
		sales,
		SUM(sales) OVER (partition by date_part('YEAR', sales_month), kind_of_business) as yearly_sales,
		sales * 100 / SUM(sales) OVER (partition by date_part('YEAR', sales_month), kind_of_business) as pct_yearly_sales
FROM retail_sales
WHERE kind_of_business in('Men''s clothing stores', 'Women''s clothing stores')
order by 1,2
;

-----------------------------------------------------------------------------------------------------

-- INDEXING(CPI - consumer price index) to see percentage change over TIME

		---- Using WINDOW first_value() Function

SELECT 
		sales_year,
		sales,
		first_value(sales) over(order by sales_year ASC) as index_sales,
		-- index value set as 1992 year sales value. No partition by used so that it take entire table as window.
	    (sales / first_value(sales) over(order by sales_year) -1) *100 as pct_from_index
FROM(
SELECT date_part('year', sales_month) sales_year,
		sum(sales) as sales
FROM retail_sales
WHERE kind_of_business = 'Women''s clothing stores'
group by 1
order by 1
) a
;

		---- Using SELF JOIN and subquery

SELECT sales_year, sales, index_sales,
		(sales / index_sales -1)*100 as pct_from_index
FROM(
	SELECT date_part('year', aa.sales_month) as sales_year,
			bb.index_sales,
			sum(aa.sales) as sales
	FROM retail_sales aa
	JOIN 
	(
		SELECT first_year, sum(a.sales) as index_sales
		from retail_sales a
		JOIN 
		(
			SELECT min(date_part('YEAR',sales_month)) first_year
			FROM retail_sales
			WHERE kind_of_business = 'Women''s clothing stores'
		)b
		ON date_part('year', a.sales_month) =b. first_year
		WHERE kind_of_business = 'Women''s clothing stores'
		GROUP BY 1
	) bb
	ON 1 =1 
	WHERE kind_of_business = 'Women''s clothing stores'
	GROUP BY 1,2
	order by 1
)
;

-----------------------------------------------------------------------------------------------------

-- ROLLING TIME WINDOWS
/* Three parts to Rlling time series calculations
1. Size of the WINDOW
2. Aggregating fuction
3. partitioning and grouping

 /* 
 	WINDOW  :	OVER(PARTITION BY ... ORDER BY .....)
    FRAME 	:	{RANGE | ROWS | GROUPS} BETWEEN frame_start AND frame_end
	frame_start and frame_end can be any of the following:
		UNBOUNDED PRECEDING
		offset PRECEDING
		CURRENT ROW
		UNBOUNDED FOLLOWING
		offset FOLLOWING
	Where offset is any numurical value
*/









