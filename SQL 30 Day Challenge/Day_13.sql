/*Q19
 Indetify the top 3 posts with the highest engagement (likes + comments) for each user on a
 facebook page. Display the user_id, engagement count rank for each post.
 posts table : post_id, user_id,likes, comments, 
*/
SELECT
	user_id, post_id, engagement_count, rnk
FROM (
	SELECT
		user_id, post_id,
		SUM(likes + comments) as engagement_count,
		DENSE_RANK() OVER (partition by user_id
							order by SUM(likes+comments) DESC) as rnk
	FROM posts
	GROUP BY user_id, post_id
	) as x
WHERE rnk <=3
;

/*Q20. Determine the users who have posted more than 2 times in the past week and calculate
the total number of likes they have received.
return user ID and number of post and number of likes.
posts table : post_id, user_id, likes, post_date
*/

SELECT
	user_id, 
	count(post_id) as number_of_post,
	SUM(likes) as number_of_likes
FROM posts
WHERE post date between current_date and current_date - interval '7 days'
GROUP BY user_id
HAVING count(post_id) > 2
;







