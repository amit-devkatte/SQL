DROP table if exists date_dim;

CREATE TABLE date_dim
AS
SELECT date::date
	,to_char(date, 'yyyymmdd'):: int as date_key
	,date_part('day', date) as day_of_month
	,date_part('doy', date) as day_of_year
	,date_part('dow',date) as day_of_week
	,trim(to_char(date, 'day')) as day_name
	-- ,length(to_char(date, 'day')) as fixed_lenth_day_name
	-- ,length(trim(to_char(date,'day'))) as trimmed_lenth_day_name
	,trim(to_char(date, 'dy')) as day_short_name
	,date_part('week',date) as week_number
	,to_char(date,'w')::int week_of_month
	,date_trunc('week',date)::date as week_start_date
	,date_part('month',date)::int as month_number
	,trim(to_char(date,'MONTH')) as month_name   -- 'month' then january if 'Month' then January
	,trim(to_char(date,'Mon')) as month_short_name
	,date_trunc('month',date)::date as first_day_of_month
	,(date_trunc('month',date) + interval '1 month' - interval '1 day')::date as last_day_of_month
	,date_part('quarter',date)::int as qtr_number
	,trim( 'Q' || (date_part('quarter',date)::int)) as qtr_name
	,date_trunc('quarter', date)::date as first_day_of_qtr
	,(date_trunc('quarter',date) + interval '3 months' - interval '1 day' ):: date as last_day_of_qtr
	,date_part('year',date)::int as year
	,date_part('decade',date)::int * 10  as decade
	,date_part('century', date)::int as centurys
FROM generate_series ('1770-01-01'::date , '2030-12-31'::date, '1 day') as date
;

SELECT * FROM date_dim;
/*
---- Why TRIM() Used ? -----
In SQL, the TRIM function is often used to remove unwanted spaces from a string. 
When you use the TO_CHAR function with the format 'day', 
it returns the full name of the day (like "Monday", "Tuesday", etc.) 
but padded with spaces to make it a fixed-width result 
(usually 9 characters wide, depending on the length of the longest day name in the language).
*/