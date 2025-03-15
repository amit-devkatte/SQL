--Q43. Write a query to print the cumulative balance of the merchant account at the end of each day, with the total balance rest back to
--zero at the end of the month. output the transaction date and cumulative balance.(source : data Lemur merchant balance account)

select * from transaction_s;

with cte as(
	select transaction_date 
		,sum(case when type ='withdrawal' then -1*amount else amount end) as amount
	from transaction_s
	group by transaction_date
)
select  transaction_date, amount
	 ,sum(amount) over (partition by year( transaction_date),month(transaction_date) order by transaction_date) as balance
from cte



DROP table if exists transaction_s;
create table transaction_s
(
	transaction_id int,
	type varchar(20),
	amount decimal,
	transaction_date date
);

insert into transaction_s values (19153, 'deposit', 65.90, '07/10/2022'); 
insert into transaction_s values (53151, 'deposit', 178.55, '07/08/2022'); 
insert into transaction_s values (29776, 'withdrawal', 25.90, '07/08/2022'); 
insert into transaction_s values (16461, 'withdrawal', 45.99, '07/08/2022'); 
insert into transaction_s values (77134, 'deposit', 32.60, '07/10/2022'); 
insert into transaction_s values (41515, 'withdrawal', 16.31, '06/01/2022'); 
insert into transaction_s values (624804, 'deposit', 165.00, '06/17/2022'); 
insert into transaction_s values (757995, 'deposit', 7.50, '06/30/2022'); 
insert into transaction_s values (112465, 'withdrawal', 295.95, '06/28/2022'); 
insert into transaction_s values (996414, 'withdrawal', 67.00, '06/05/2022'); 
insert into transaction_s values (41515, 'withdrawal', 293.50, '06/01/2022'); 
insert into transaction_s values (41515, 'deposit', 490.50, '06/01/2022'); 

