--Q.20  Find missing quarter

--method 1- Aggregation
select store, 'Q' + cast(10 - sum(cast(right(quarter,1) as int)) as char(2)) as missing_quarter
from stores
group by store;

-- Method 2 using recursion 
select * from stores ;
 with cte1 as 
 (
	select distinct store ,1 as Qtr from stores
	UNION ALL
	select store , Qtr + 1 as Qtr from cte1
	Where Qtr < 4
 )
 , cte2 as 
 (
	select store , 'Q'+ cast(Qtr as char(1)) as Qtr
	from cte1
 )
 select a.store, a.Qtr
 from cte2 a 
 left join stores b on a.store = b.store and a.Qtr = b.Quarter
 Where b.Quarter is null
 order by a.Store;


 --Method 3 Using cross join
 with cte as 
 (
	select distinct s1.store,s2.Quarter
	from stores s1,stores s2
 )
 select a.store, a.Quarter
 from cte a
 left join stores b on a.Store=b.Store and a.Quarter = b.Quarter
 Where b.Quarter is null;



















CREATE TABLE STORES (
Store varchar(10),
Quarter varchar(10),
Amount int);

INSERT INTO STORES (Store, Quarter, Amount)
VALUES ('S1', 'Q1', 200),
('S1', 'Q2', 300),
('S1', 'Q4', 400),
('S2', 'Q1', 500),
('S2', 'Q3', 600),
('S2', 'Q4', 700),
('S3', 'Q1', 800),
('S3', 'Q2', 750),
('S3', 'Q3', 900);