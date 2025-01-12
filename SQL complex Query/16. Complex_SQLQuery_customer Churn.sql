---16 . Customer Churn Anlaysis (continuation to previous question of customer retention)
-------------------------Customer Churn -----------------
select month(last_month.order_date)as month_num, count(distinct last_month.cust_id) no_customers
from transactions last_month
LEFT JOIN transactions this_month
on this_month.cust_id = last_month.cust_id and datediff(month, last_month.order_date, this_month.order_date)=1
where this_month.cust_id is null
group by month(last_month.order_date);