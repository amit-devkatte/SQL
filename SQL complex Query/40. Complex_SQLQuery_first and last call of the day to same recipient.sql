--Q40. Write a sql query to find out callers whose first and last call was to the same person on a given day.
--there is a phonelog table that has information about callers call history

select * from phonelog;

with call as (
select callerid, cast(datecalled as date) cdate, min(datecalled) f_call, max(datecalled) l_call
from phonelog
group by callerid, cast(datecalled as date))

select c.callerid,c.cdate as call_date, p1.recipientid from call c
inner join phonelog p1 on c.callerid = p1.callerid and c.f_call = p1.datecalled
inner join phonelog p2 on c.callerid = p2.callerid and c.l_call = p2.datecalled
where p1.recipientid =  p2.recipientid









create table phonelog(
    Callerid int, 
    Recipientid int,
    Datecalled datetime
);

insert into phonelog(Callerid, Recipientid, Datecalled)
values(1, 2, '2019-01-01 09:00:00.000'),
       (1, 3, '2019-01-01 17:00:00.000'),
       (1, 4, '2019-01-01 23:00:00.000'),
       (2, 5, '2019-07-05 09:00:00.000'),
       (2, 3, '2019-07-05 17:00:00.000'),
       (2, 3, '2019-07-05 17:20:00.000'),
       (2, 5, '2019-07-05 23:00:00.000'),
       (2, 3, '2019-08-01 09:00:00.000'),
       (2, 3, '2019-08-01 17:00:00.000'),
       (2, 5, '2019-08-01 19:30:00.000'),
       (2, 4, '2019-08-02 09:00:00.000'),
       (2, 5, '2019-08-02 10:00:00.000'),
       (2, 5, '2019-08-02 10:45:00.000'),
       (2, 4, '2019-08-02 11:00:00.000');