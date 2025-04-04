--Q47. write a query to find the users who purchased different products on different dates 
-- ie products purchased on any given day are not repeated on any other day

select * from purchase_history;

--solution 1 (using count and distinct logic)
select userid
	,count(distinct purchasedate)no_of_different_dates
	,count(productid) cnt_total_products
	,count(distinct productid) cnt_differnt_products
from purchase_history
group by userid
having count(distinct purchasedate) > 1 and count(productid) = count(distinct productid)
;

--solution2 (using window dense rank function)
select userid
from(
	select *, DENSE_RANK() over(partition by userid, productid order by purchasedate) drn
	from purchase_history
)a
group by userid
having max(drn) =1 and count(distinct purchasedate)>1





create table purchase_history
(userid int
,productid int
,purchasedate date
);
SET DATEFORMAT dmy;
insert into purchase_history values
(1,1,'23-01-2012')
,(1,2,'23-01-2012')
,(1,3,'25-01-2012')
,(2,1,'23-01-2012')
,(2,2,'23-01-2012')
,(2,2,'25-01-2012')
,(2,4,'25-01-2012')
,(3,4,'23-01-2012')
,(3,1,'23-01-2012')
,(4,1,'23-01-2012')
,(4,2,'25-01-2012')
;