-- First approch 

-- SELECT Year, max(max_medal) max_medal From
-- (select year,USA as Max_medal from medal
-- UNION ALL
-- select year, India from medal
-- UNION ALL
-- select year, Russia from medal) as a
-- GROUP BY Year

WITH unpivot as (
select Year, 'USA' as Country, USA as medals from medal
UNION ALL
select Year, 'India' as Country , India as medals from medal
UNION ALL
select Year, 'Russia' as Country , Russia as medals from medal 
)

select * from unpivot
ORDER BY YEAR;

pivot as (
Select Year
,SUM(CASE WHEN Country ='USA' THEN medals ELSE 0 END) as usa
,sum(CASE WHEN Country ='India' THEN medals ELSE 0 END) as india
,SUM(CASE WHEN Country = 'Russia' THEN medals ELSE 0 END) as russia
FROM unpivot
GROUP BY Year
)
Select * from pivot