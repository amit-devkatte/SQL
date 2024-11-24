/*Q 13 Twitter question : HISTOGRAM
Write a query to obtain a histogram of tweets posted per user in 2022. Output the tweet 
count per user as the bucket and the number of Twitter users who fall into that bucker.
In other words , group the users by the number of tweets the posted in 2022 and count the
number of users in each group.
tweets table : tweet_id, user_id, msg, tweet_date
*/
SELECT 
	tweet_bucket, 
	count(*) as user_num
FROM
(
	SELECT 
		user_id, 
		count(*) as tweet_bucket
	FROM 
		tweets
	WHERE 
		EXTRACT(year from tweet_date) = 2022
	group by 1
) as x
GROUP BY 
	tweet_bucket
ORDER BY 
	tweet_bucket
;