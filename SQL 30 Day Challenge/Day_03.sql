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


/* Q.6 Write a query to indentify the top two power users who sent highest
number of messages ON Microsoft Teams in August 2022. Display the IDs of 
the 2 users along with the total number of messages they sent. 
Output the result in descending order based on the count of the messages.
messages Table : message_id, sender_id, receiver_id, content, sent_date
*/


	SELECT sender_id, COUNT(1) as message_count
	FROM messages
	WHERE EXTRACT (MONTH FROM sent_date) = 8 AND
		  EXTRACT (YEAR FROM sent_date) = 2022
	-- WHERE sent_date BETWEEN '2022-08-01' AND '2022-08-31'	  
	GROUP BY sender_id
	ORDER BY message_count DESC
	LIMIT 2;
	







	