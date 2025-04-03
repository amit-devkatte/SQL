--Q45. scenario :
/* There is a live production system with a table (orders) that captures orders information in real-time.We wish to capture 'deltas' from
this table (insers and delets) by leveraging a nightly copy of the table. There are no timestamps that can be used for delta processing.
order :
order table : order_id(primary key ) This table processing 10000 transactions per day including inserts , deletes, updates. the deletes
are physical , so the records will no longer exists in the table.

every day at 12:00 am a snapshot copy of this table created and is an exact copy of the table at that time.

requirement: Write a query that (as efficiently as possible) will return only new inserts into orders since the snapshot was taken 
(record is in order but not order_copy) or only new delete from order since the snapshot was taken (record is in order_copy , but not in order)

the query should return the primary key and single character (I for insert and D for delete) as INSERT_OR_DELETE_FLAG.
Rule : Not to use minus, union, merge , union all ....exist and not exist can be used.
*/

select * from tbl_orders;
select * from tbl_orders_copy;

--solution

select coalesce (o.order_id, c.order_id) as order_id,
	CASE when c.order_id is null then 'I' 
		when o.order_id is null then 'D' end as INSERT_OR_DELETE_FLAG
from tbl_orders o
full outer join tbl_orders_copy c
on o.order_id = c.order_id
where o.order_id is null or c.order_id is null;






create table tbl_orders (
order_id integer,
order_date date
);
insert into tbl_orders
values (1,'2022-10-21'),(2,'2022-10-22'),
(3,'2022-10-25'),(4,'2022-10-25');

select * into tbl_orders_copy from  tbl_orders;

select * from tbl_orders;
insert into tbl_orders
values (5,'2022-10-26'),(6,'2022-10-26');
delete from tbl_orders where order_id=1;
