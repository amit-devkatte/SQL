/*Q49. Write a query to find all couples of trade for same stock that happen in the range of 10 seconds
and having price difference by more than 10%
Output result should also list the percentage of price difference between the 2 trades
*/

select  a.trade_id, b.trade_id
from Trade_tbl a
left join Trade_tbl b
on a.trade_id < b.trade_id
where datediff(second,a.trade_timestamp,b.trade_timestamp) <=10
	and abs(cast (a.price as float)/b.price-1)*100 > 10
;



Create Table Trade_tbl(
TRADE_ID varchar(20),
Trade_Timestamp time,
Trade_Stock varchar(20),
Quantity int,
Price Float
)

Insert into Trade_tbl Values('TRADE1','10:01:05','ITJunction4All',100,20)
Insert into Trade_tbl Values('TRADE2','10:01:06','ITJunction4All',20,15)
Insert into Trade_tbl Values('TRADE3','10:01:08','ITJunction4All',150,30)
Insert into Trade_tbl Values('TRADE4','10:01:09','ITJunction4All',300,32)
Insert into Trade_tbl Values('TRADE5','10:10:00','ITJunction4All',-100,19)
Insert into Trade_tbl Values('TRADE6','10:10:01','ITJunction4All',-300,19)