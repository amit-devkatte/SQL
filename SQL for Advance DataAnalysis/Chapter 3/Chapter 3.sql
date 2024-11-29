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
-- ROLLING TIME WINDOWS (moving avg, rolling sum)
-----------------------------------------------------------------------------------------------------
/* Three parts to Rlling time series calculations
1. Size of the WINDOW
2. Aggregating fuction
3. partitioning and grouping

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

-- Using SELF JOIN
SELECT a.sales_month,
		a.sales,
		b.sales_month as rolling_months,
		b.sales as rolling_months
FROM retail_sales a
JOIN retail_sales b
ON a.kind_of_business = b.kind_of_business
	AND b.sales_month BETWEEN a.sales_month - interval '11 months' AND a.sales_month
	AND b.kind_of_business = 'Women''s clothing stores' -- this is optional. enhance query as less rows to compare.
WHERE a.kind_of_business = 'Women''s clothing stores'
	AND a.sales_month = '2019-12-01'
;

-- Using SELF JOIN :  Apply the aggregation

SELECT a.sales_month,
		a.sales,
		count(b.sales_month) as record_counts,
		AVG(b.sales) AS moving_avg
FROM retail_sales a
JOIN retail_sales b
ON 	a.kind_of_business = b.kind_of_business
	AND b.sales_month BETWEEN a.sales_month - INTERVAL '11 months' AND a.sales_month
	AND b.kind_of_business = 'Women''s clothing stores'
WHERE a.kind_of_business = 'Women''s clothing stores'
	AND a.sales_month >='1993-01-01'
GROUP BY 1,2
ORDER BY 1
;

-- Using WINDOW Function with FRAME clause

SELECT sales_month, 
		kind_of_business,
		sales,
		avg(sales) over (order by sales_month 
							ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) as moving_avg,
		count(sales) over (order by sales_month 
							ROWS between 11 preceding and current row) as records_count
FROM retail_sales
WHERE kind_of_business = 'Women''s clothing stores'
;

-- Rolling Time Window with sparse DATA

SELECT 
	a.date, b.sales_month, b.sales
FROM 
	date_dim as a
JOIN(
		SELECT sales_month, sales
		FROM retail_sales
		WHERE kind_of_business = 'Women''s clothing stores'
			AND date_part('month', sales_month) in (1,7)
	) as b
ON 
	b.sales_month between a.date - interval '11 months' and a.date
WHERE
	a.date =a.first_day_of_month
	and a.date between '1993-01-01' and '2020-12-01'
;

---- aggregation
SELECT 
	a.date,
	Count(*) records,
	AVG(b.sales)
FROM 
	date_dim as a
JOIN(
		SELECT sales_month, sales
		FROM retail_sales
		WHERE kind_of_business = 'Women''s clothing stores'
			AND date_part('month', sales_month) in (1,7)
	) as b
ON 
	b.sales_month between a.date - interval '11 months' and a.date
WHERE
	a.date =a.first_day_of_month
	and a.date between '1993-01-01' and '2020-12-01'
GROUP BY 1
;

-- without date_dim dimension table
SELECT a.sales_month, avg(b.sales) as moving_avg
FROM
(
	SELECT DISTINCT (sales_month)
	FROM retail_sales
	WHERE sales_month between '1993-01-01' and '2020-12-01'
)a
JOIN
	retail_sales b
ON
	b.sales_month BETWEEN a.sales_month - INTERVAL '11 months' and a.sales_month
	and b.kind_of_business = 'Women''s clothing stores'
GROUP BY 1
order by 1
;

-----------------------------------------------------------------------------------------------------
--CUMULATIVE values calculation (YTD, QTD, MTD,)
-----------------------------------------------------------------------------------------------------
/*
Rolling Calculation : Window-frame size fixed and starting point changing
Cumulative calcualtion : Window size growing and starting point fixed.

*/

-- YTD
SELECT
		sales_month,
		sales,
		sum(sales) over(partition by date_part('year',sales_month) order by sales_month) as sales_ytd
FROM retail_sales
WHERE kind_of_business = 'Women''s clothing stores'
;

-- QTD

SELECT
		sales_month,
		sales,
		sum(sales) over(partition by date_part('year',sales_month) order by sales_month) as sales_YTD,
		sum(sales) over(partition by (date_part('year',sales_month), date_part('quarter', sales_month)) order by sales_month) as sales_QTD,
		-- count(sales)over(partition by(date_part('year',sales_month),date_part('quarter', sales_month)) order by sales_month) as sales_QTD
FROM retail_sales
WHERE kind_of_business = 'Women''s clothing stores'
;

--YTD using self-join

SELECT a.sales_month, a.sales,
		SUM(b.sales) as sales_YTD
FROM retail_sales a
JOIN retail_sales b
ON date_part('year',b.sales_month) = date_part('year',a.sales_month)
	and b.sales_month <= a.sales_month
	and b.kind_of_business = 'Women''s clothing stores'
WHERE a.kind_of_business = 'Women''s clothing stores'
GROUP BY 1,2
order by 1,2
;

--QTD using self-join
SELECT a.sales_month, a.sales,
		SUM(b.sales) as sales_YTD
FROM retail_sales a
JOIN retail_sales b
ON date_part('year',b.sales_month) = date_part('year',a.sales_month)
	and date_part('Quarter',b.sales_month) = date_part('quarter',a.sales_month)
	and b.sales_month <= a.sales_month
	and b.kind_of_business = 'Women''s clothing stores'
WHERE a.kind_of_business = 'Women''s clothing stores'
GROUP BY 1,2
order by 1,2
;

-----------------------------------------------------------------------------------------------------
-- Period-Over-Period comparison (YoY , MoM, same month last year) (Seasonality Analysis)
-----------------------------------------------------------------------------------------------------
/* Window function 
	LAG(return_value[,offset [,default]])  
	*Optional offset - number of steps. default is 1.
*/

SELECT kind_of_business,sales_month, sales,
		lag(sales_month) over(partition by kind_of_business order by sales_month) as prev_month,
		lag(sales) over(partition by kind_of_business order by sales_month) as prev_sales
FROM retail_sales
WHERE kind_of_business = 'Book stores'
;

-- MoM growth in each kind of business

SELECT kind_of_business,
		sales_month,
		sales,
		lag(sales) over (partition by kind_of_business  order by sales_month) as prev_month_sales,
		ROUND((sales / lag(sales) over (partition by kind_of_business  order by sales_month) -1)*100 ,2)as pct_growth_from_prev_month
FROM retail_sales
where kind_of_business = 'Book stores'
;

-- YoY growth in each kind of business
SELECT Date_part('year',sales_month) as sales_year,
		sum(sales) as yearly_sales,
		lag(sum(sales)) over(order by Date_part('year',sales_month)) as prev_year_sales,
		ROUND(
			(sum(sales) / lag(sum(sales)) over(order by Date_part('year',sales_month)) -1)*100 ,2) as pct_growth_from_prev_year
FROM retail_sales
WHERE kind_of_business = 'Book stores'
GROUP BY 1
order by 1;

-- Period over Period comparison: same month versus last YEAR

SELECT sales_month,sales,
		lag(sales_month) over(partition by date_part('month', sales_month) order by sales_month) as prev_year_month,
		lag(sales) over(partition by date_part('month', sales_month) order by sales_month) as prev_year_same_month_sales
FROM retail_sales
where kind_of_business ='Book stores'
;


select sales_month, sales,
		lag(sales_month) over(partition by date_part('month', sales_month) order by sales_month) as prev_year_month,
		lag(sales) over(partition by date_part('month', sales_month) order by sales_month) as prev_year_same_month_sale,
		abs(sales - lag(sales) over(partition by date_part('month', sales_month) order by sales_month)) as abs_diff,
		ROUND((sales / lag(sales) over(partition by date_part('month', sales_month) order by sales_month) -1) *100, 2)  as pct_diff
from retail_sales
where kind_of_business = 'Book stores'
;

--Comparison for same month over multiple years.
SELECT date_part('month',sales_month) as month_number
		,to_char(sales_month, 'Month') month_name
		,SUM(CASE WHEN date_part('Year', sales_month) = 1992 THEN sales END) as sales_1992
		,SUM(CASE WHEN date_part('year', sales_month) = 1993 THEN sales END) as sales_1993
		,SUM(CASE WHEN date_part('year', sales_month) = 1994 THEN sales END) as sales_1994
		,sum(sales)
FROM retail_sales
WHERE kind_of_business = 'Book stores'
and sales_month between '1992-01-01' and '1994-12-01'
GROUP BY 1,2
;

--Comparing to multiple prior periods
SELECT sales_month
		,sales
		,lag(sales,1) over (partition by date_part('month', sales_month) order by sales_month) as prev_sales_1
		,lag(sales,2) over (partition by date_part('month', sales_month) order by sales_month) as prev_sales_2
		,lag(sales,3) over (partition by date_part('month', sales_month) order by sales_month) as prev_sales_3
FROM retail_sales
WHERE kind_of_business = 'Book stores' 
;


SELECT sales_month, sales
		, (sales/ ((prev_sales_1 + prev_sales_2 + prev_sales_3)/3) * 100) as pct_of_3_prev
FROM(
	SELECT sales_month
			,sales
			,lag(sales,1) over (partition by date_part('month', sales_month) order by sales_month) as prev_sales_1
			,lag(sales,2) over (partition by date_part('month', sales_month) order by sales_month) as prev_sales_2
			,lag(sales,3) over (partition by date_part('month', sales_month) order by sales_month) as prev_sales_3
	FROM retail_sales
	WHERE kind_of_business = 'Book stores' 
) as subquery
;


select sales_month, sales
		, avg(sales) over(partition by date_part('month',sales_month) 
						  order by sales_month
						  ROWS between 3 PRECEDING and 1 PRECEDING) as rolling_avg_prev_3
	    , sales / avg(sales) over(partition by date_part('month',sales_month) 
						  order by sales_month
						  ROWS between 3 PRECEDING and 1 PRECEDING) * 100 as pct_of_prev_3
from retail_sales
WHERE kind_of_business = 'Book stores';




-----------------------------------------------------------------------------------------------------
---------------------------------------- END of chapter 3 -------------------------------------------
-----------------------------------------------------------------------------------------------------
















