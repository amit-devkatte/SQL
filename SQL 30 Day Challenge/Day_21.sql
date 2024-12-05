/*
	Q29. Booking.com Data Analyst Interview Question
Find the top-performing two months by revenue for each hotel for each year.
Return hotel_id, year, months, revenue
*/

-- bookings table : hotel_id, booking_date, amount

/*
Solution :
-- Group by  hotel, year , months and year
-- aggregate amount
-- use DENSE_RANK() window function
*/

SELECT hotel_id, year, month, revenue
FROM (
		SELECT 
			hotel_id,
			date_part('YEAR', booking_date) as year,
			date_part('Month', booking_date) as month,
			SUM(amount) as revenue,
			DENSE_RANK() OVER(PARTITION BY hotel_id, 
											date_part('YEAR', booking_date),
											date_part('Month', booking_date)
								ORDER BY SUM(amount) DESC)) as d_rank
		FROM bookings
		GROUP BY 1,2,3
	 ) as x
WHERE d_rank <=2
;