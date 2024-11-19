/* Q3. Assume you're given two tables containing data about Facebook Pages and their 
respective likes (as in "Like a Facebook Page").
Write a query to return the IDs of the Facebook pages that have zero likes. 
The output should be sorted in ascending order based on the page IDs.
pages Table:page_id, page_name
page_likes Table:user_id, page_id, liked_date*/

-- Create pages table
CREATE TABLE pages (
    page_id INTEGER PRIMARY KEY,
    page_name VARCHAR(255)
);

-- Insert data into pages table
INSERT INTO pages (page_id, page_name) VALUES
(20001, 'SQL Solutions'),
(20045, 'Brain Exercises'),
(20701, 'Tips for Data Analysts');

-- Create page_likes table
CREATE TABLE page_likes (
    user_id INTEGER,
    page_id INTEGER,
    liked_date DATE,
    FOREIGN KEY (page_id) REFERENCES pages(page_id)
);

-- Insert data into page_likes table
INSERT INTO page_likes (user_id, page_id, liked_date) VALUES
(111, 20001, '2022-04-08 00:00:00'),
(121, 20045, '2022-03-12 00:00:00'),
(156, 20001, '2022-07-25 00:00:00');

SELECT p.page_id
FROM pages as p
LEFT JOIN page_likes as l
ON p.page_id = l.page_id
GROUP BY p.page_id
HAVING count(l.page_id)=0
ORDER BY p.page_id;

/* Q4. Write a query to calculate the click-through-rate CTR for the app in 2022
and round the results to 2 decimal places.
percentage of ctr = 100.0* number of clicks / number of impressions
to avoid integer devision, multiply the ctr by 100.0, not 100
events table : app_id, event_type (clicks / impression), timestamp
*/

CREATE TABLE events(
	app_id integer,
	event_type varchar(25),
	timestamp TIMESTAMP
);

-- Insert records into the events table
INSERT INTO events (app_id, event_type, timestamp) VALUES
(123, 'impression', '2022-07-18 11:36:12'),
(123, 'impression', '2022-07-18 11:37:12'),
(123, 'click', '2022-07-18 11:37:42'),
(234, 'impression', '2022-07-18 14:15:12'),
(234, 'click', '2022-07-18 14:16:12')
(123, 'impression', '2021-07-18 11:36:12')
;

SELECT * from events;

SELECT 
	app_id,
 	ROUND( 100.0 * 
 	SUM(CASE WHEN event_type = 'click' THEN 1 ELSE 0 END)/
 	SUM(CASE WHEN event_type = 'impression' THEN 1 ELSE 0 END),2)
FROM 
	events
WHERE 
	EXTRACT (YEAR FROM timestamp) = '2022'
GROUP BY
	app_id
;




