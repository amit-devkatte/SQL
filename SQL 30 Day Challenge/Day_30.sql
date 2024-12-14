/* Q.38 Spotify - Write a sql query to find the 10 most popular songs by total number of listens.
	songs table : song_id, song_name, artist_name
	listens table : listen_id, user_id, song_id, listen_date
*/

WITH CTE AS(
	SELECT s.song_name 
		,n_listens
		,DENSE_RANK()OVER(order by n_listens DESC) as popularity_rank
	FROM songs s
	JOIN
	(SELECT song_id , count(listen_id) as n_listens FROM listens  GROUP BY song_id) l
	ON s.song_id = l.song_id
	)
SELECT *
FROM CTE
WHERE popularity_rank <=10
;