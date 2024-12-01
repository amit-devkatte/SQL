/*Q23. TIK TOK Data Analyst Interview Question
Find the median within a series of numbers in SQL;
1 8 3 4 5 odd
1 3 4 5 8 9 even
 tiktok table : views column
*/
WITH CTE AS(
	SELECT 
		views
		,ROW_NUMBER() OVER (ORDER BY views ASC) asc_rank
		,ROW_NUMBER() OVER (ORDER BY views DESC) desc_rank
	FROM tiktok)
	
SELECT 
	AVG(views) as median
FROM 
	CTE
WHERE 
	ABS(desc_rank - asc_rank) <=1
;


-- Create TikTok table
CREATE TABLE tiktok (
					views INT
);

-- Insert records into the tiktok table
INSERT INTO tiktok (views) 
VALUES 
	-- (1),(8),(3),(4),(5),
	(9)
	;