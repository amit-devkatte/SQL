/* Q50. We have a table which stores data of multiple sections. every section has 3 numbers 
We have to find top 4 numbers from any 2 sections (2 numbers each) whose addition should be maximum 
so in this case we will choose section b where we have 19(10+9)then we need to choose either c or d
because both has sum of 18 but in d we have 10 which is big from 9 so we will give priority to d
*/


select * from section_data;

with cte as (
	select section, number, lead(number) over(partition by section order by number desc)  second_number
		,number + lead(number) over(partition by section order by number desc) addition
	from(
		select *, case when rank() over(partition by section order by number desc)<3 then 1 else 0 end as flag
		from section_data)a
	where flag =1
)
select section, number, second_number, addition
from(
	select *, row_number()over(order by addition desc, number desc) rn
	from cte
	where second_number is not null
)aa
where rn<=2;






create table section_data
(
section varchar(5),
number integer
)
insert into section_data
values ('A',5),('A',7),('A',10) ,('B',7),('B',9),('B',10) ,('C',9),('C',7),('C',9) ,('D',10),('D',3),('D',8);