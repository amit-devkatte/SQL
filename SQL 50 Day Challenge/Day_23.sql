--Day 23

/* -- Amazon Data Analyst Interview Question
Write a query to identify returning active users. 
A returning active user is a user that has made a 
second purchase within 7 days of their first purchase

Output a list of user_ids of these returning active users.
*/

DROP TABLE IF EXISTS amazon_transactions;
CREATE TABLE amazon_transactions (
    id SERIAL PRIMARY KEY,
    user_id INT,
    item VARCHAR(255),
    purchase_date DATE,
    revenue NUMERIC
);

INSERT INTO amazon_transactions (user_id, item, purchase_date, revenue) VALUES
(109, 'milk', '2020-03-03', 123),
(139, 'biscuit', '2020-03-18', 421),
(120, 'milk', '2020-03-18', 176),
(108, 'banana', '2020-03-18', 862),
(130, 'milk', '2020-03-28', 333),
(103, 'bread', '2020-03-29', 862),
(122, 'banana', '2020-03-07', 952),
(125, 'bread', '2020-03-13', 317),
(139, 'bread', '2020-03-30', 929),
(141, 'banana', '2020-03-17', 812),
(116, 'bread', '2020-03-31', 226),
(128, 'bread', '2020-03-04', 112),
(146, 'biscuit', '2020-03-04', 362),
(119, 'banana', '2020-03-28', 127),
(142, 'bread', '2020-03-09', 503),
(122, 'bread', '2020-03-06', 593),
(128, 'biscuit', '2020-03-24', 160),
(112, 'banana', '2020-03-24', 262),
(149, 'banana', '2020-03-29', 382),
(100, 'banana', '2020-03-18', 599),
(130, 'milk', '2020-03-16', 604),
(103, 'milk', '2020-03-31', 290),
(112, 'banana', '2020-03-23', 523),
(102, 'bread', '2020-03-25', 325),
(120, 'biscuit', '2020-03-21', 858),
(109, 'bread', '2020-03-22', 432),
(101, 'milk', '2020-03-01', 449),
(138, 'milk', '2020-03-19', 961),
(100, 'milk', '2020-03-29', 410),
(129, 'milk', '2020-03-02', 771),
(123, 'milk', '2020-03-31', 434),
(104, 'biscuit', '2020-03-31', 957),
(110, 'bread', '2020-03-13', 210),
(143, 'bread', '2020-03-27', 870),
(130, 'milk', '2020-03-12', 176),
(128, 'milk', '2020-03-28', 498),
(133, 'banana', '2020-03-21', 837),
(150, 'banana', '2020-03-20', 927),
(120, 'milk', '2020-03-27', 793),
(109, 'bread', '2020-03-02', 362),
(110, 'bread', '2020-03-13', 262),
(140, 'milk', '2020-03-09', 468),
(112, 'banana', '2020-03-04', 381),
(117, 'biscuit', '2020-03-19', 831),
(137, 'banana', '2020-03-23', 490),
(130, 'bread', '2020-03-09', 149),
(133, 'bread', '2020-03-08', 658),
(143, 'milk', '2020-03-11', 317),
(111, 'biscuit', '2020-03-23', 204),
(150, 'banana', '2020-03-04', 299),
(131, 'bread', '2020-03-10', 155),
(140, 'biscuit', '2020-03-17', 810),
(147, 'banana', '2020-03-22', 702),
(119, 'biscuit', '2020-03-15', 355),
(116, 'milk', '2020-03-12', 468),
(141, 'milk', '2020-03-14', 254),
(143, 'bread', '2020-03-16', 647),
(105, 'bread', '2020-03-21', 562),
(149, 'biscuit', '2020-03-11', 827),
(117, 'banana', '2020-03-22', 249),
(150, 'banana', '2020-03-21', 450),
(134, 'bread', '2020-03-08', 981),
(133, 'banana', '2020-03-26', 353),
(127, 'milk', '2020-03-27', 300),
(101, 'milk', '2020-03-26', 740),
(137, 'biscuit', '2020-03-12', 473),
(113, 'biscuit', '2020-03-21', 278),
(141, 'bread', '2020-03-21', 118),
(112, 'biscuit', '2020-03-14', 334),
(118, 'milk', '2020-03-30', 603),
(111, 'milk', '2020-03-19', 205),
(146, 'biscuit', '2020-03-13', 599),
(148, 'banana', '2020-03-14', 530),
(100, 'banana', '2020-03-13', 175),
(105, 'banana', '2020-03-05', 815),
(129, 'milk', '2020-03-02', 489),
(121, 'milk', '2020-03-16', 476),
(117, 'bread', '2020-03-11', 270),
(133, 'milk', '2020-03-12', 446),
(124, 'bread', '2020-03-31', 937),
(145, 'bread', '2020-03-07', 821),
(105, 'banana', '2020-03-09', 972),
(131, 'milk', '2020-03-09', 808),
(114, 'biscuit', '2020-03-31', 202),
(120, 'milk', '2020-03-06', 898),
(130, 'milk', '2020-03-06', 581),
(141, 'biscuit', '2020-03-11', 749),
(147, 'bread', '2020-03-14', 262),
(118, 'milk', '2020-03-15', 735),
(136, 'biscuit', '2020-03-22', 410),
(132, 'bread', '2020-03-06', 161),
(137, 'biscuit', '2020-03-31', 427),
(107, 'bread', '2020-03-01', 701),
(111, 'biscuit', '2020-03-18', 218),
(100, 'bread', '2020-03-07', 410),
(106, 'milk', '2020-03-21', 379),
(114, 'banana', '2020-03-25', 705),
(110, 'bread', '2020-03-27', 225),
(130, 'milk', '2020-03-16', 494),
(117, 'bread', '2020-03-10', 209);

-- solution
-- using window LEAD function
WITH cte as(
select *
	, LEAD(purchase_date) Over(partition by user_id) second_purchase_date
from(
select *
	, row_number() over(partition by user_id order by purchase_date) date_rank
from amazon_transactions
)
where date_rank <=2
)
select id
	,user_id
	,item
	,revenue
	,purchase_date
	,second_purchase_date
	,(second_purchase_date-purchase_date) as day_between_orders
from cte
where (second_purchase_date - purchase_date) <=7;

--Solution (using self join)

select 
	DISTINCT ON (a1.user_id)
	a1.user_id
	,a1.purchase_date as first_purchase
	,a2.purchase_date as second_purchase
from amazon_transactions a1
JOIN amazon_transactions a2
ON a1.user_id = a2.user_id
	and a1.purchase_date < a2.purchase_date
	and a2.purchase_date - a1.purchase_date <=7
Order by 1,2
;

/*
Find the user_id who has not purchased anything for 7 days 
after first purchase but they have done second purchase after 7 days 
*/

select a1.user_id, a1.first_purchase, min(a2.purchase_date) second_purchase
	,min(a2.purchase_date) - a1.first_purchase
from
(
	select user_id, min(purchase_date) first_purchase 
	from amazon_transactions
	group by 1
) a1
JOIN amazon_transactions a2
ON a1.user_id = a2.user_id and a1.first_purchase != a2.purchase_date
Group by a1.user_id, a1.first_purchase
HAVING min(a2.purchase_date) - a1.first_purchase > 7
order by a1.user_id







