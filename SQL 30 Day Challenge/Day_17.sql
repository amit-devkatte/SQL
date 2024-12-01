-- Q24. Zomato Business analyst Interview Question

/*
	HOW many delayed orders does delivery partners have, considering the predicted delivery
	time and the actual delivery time?
	order_details table : order_id, del_partner, estimated_time, actual_time
	ex. (111, 'Amit', '2024-11-28 07:10:23', '2024-11-28 07:29:56')
*/

SELECT del_partner,
		count(order_id) as n_delayed_order
FROM order_details
WHERE estimated_time < actual_time
Group BY del_partner
;