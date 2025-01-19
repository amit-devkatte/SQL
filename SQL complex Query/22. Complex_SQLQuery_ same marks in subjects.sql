--Q22. Find the students who has same marks in physics and chemistry.

select * from exams;

--Method 1 (Using Window function)
with cte as(
	select *
		,lag(subject) over(partition by student_id order by subject) sub1
		,lag(marks) over(partition by student_id order by subject) marks1
	from exams
)
Select student_id,subject as subject1, marks as marks1, sub1 as subject2, marks1 as marks2
from cte
where marks = marks1
;

--Method 2 (group by and Having)

select student_id
from exams
where subject in ('Chemistry', 'Physics')
group by student_id
having count(distinct subject) =2 and count(distinct marks) =1;

--Method 3 (self join)
select a.student_id
from exams a join exams b on a.student_id = b.student_id
Where a.subject < b.subject and a.marks = b.marks



-------------------------------------------------------------------------------------------------------

create table exams (student_id int, subject varchar(20), marks int);
delete from exams;
insert into exams values (1,'Chemistry',91),(1,'Physics',91)
,(2,'Chemistry',80),(2,'Physics',90)
,(3,'Chemistry',80)
,(4,'Chemistry',71),(4,'Physics',54);