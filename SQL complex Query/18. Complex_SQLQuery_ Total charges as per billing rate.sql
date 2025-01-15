--18. Total charges as per billing rate

select * from billings;
select * from hoursworked;

with date_range as (
select *,
	Lead(dateadd(day,-1,bill_date),1,'9999-12-31') over(partition by emp_name order by bill_date) as bill_date_end
from billings
)
select d.emp_name, sum(bill_rate * coalesce(bill_hrs,0)) totalcharges
from date_range d
left join hoursworked h
on h.emp_name = d.emp_name and h.work_date between d.bill_date and d.bill_date_end
group by d.emp_name
order by totalcharges desc;






create table billings 
(
emp_name varchar(10),
bill_date date,
bill_rate int
);
delete from billings;
insert into billings values
('Sachin','01-JAN-1990',25)
,('Sehwag' ,'01-JAN-1989', 15)
,('Dhoni' ,'01-JAN-1989', 20)
,('Sachin' ,'05-Feb-1991', 30)
;
create table HoursWorked 
(
emp_name varchar(20),
work_date date,
bill_hrs int
);
insert into HoursWorked values
('Sachin', '01-JUL-1990' ,3)
,('Sachin', '01-AUG-1990', 5)
,('Sehwag','01-JUL-1990', 2)
,('Sachin','01-JUL-1991', 4)