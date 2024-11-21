/* Q5. Write a SOL query to calculate the difference between 
the higest salaries in the marketing and engineering department
output the absolute difference in salaries*/
-- Leetcode problem LeetCode SQL Premium Problem 2853: 'Highest Salary Difference'

---- Using CASE Statement
SELECT 
	abs
	(
		MAX(CASE WHEN department= 'Marketing' Then salary END) as Mark_highest_sal -
		MAX(CASE WHEN department= 'Engineering' Then salary END) as Eng_highest_sal
	)
FROM salaries


----Using CTE

WITH Mark_highest_sal as 
(
	SELECT MAX(Salary) mark_sal
	FROM salaries
	WHERE department = 'Marketing'
)
,Eng_highest_sal AS
(
	SELECT MAX(Salary) eng_sal
	FROM salaries
	WHERE department = 'Engineering'
)
SELECT ABS( SELECT mark_sal FROM Mark_highest_sal  - SELECT eng_sal FROM Eng_highest_sal )
 as abs_diff

 
	