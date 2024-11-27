DROP TABLE if exists retail_sales;

CREATE TABLE retail_sales
(
	sales_month date
	,naics_codes varchar
	,kind_of_business varchar
	,reason_for_null varchar  
	,sales decimal
)
;

COPY retail_sales
FROM 'D:\Amit\SQL\SQL for DataAnalysis_cathyTanimura\chapter 3\us_retail_sales.csv'
DELIMITER ','
CSV HEADER
;

SELECT *
FROM retail_sales;