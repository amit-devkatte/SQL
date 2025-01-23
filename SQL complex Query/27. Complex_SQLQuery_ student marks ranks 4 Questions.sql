--Q27.set of 4 complex problems

select * from students;
--Q1. Write a sql query get the list of students who scored above the average marks in each subject.(without Window function)
select *
from students s1
where s1.marks > (select avg(s2.marks) avg_marks 
				  from students s2 
				  where s1.subject = s2.subject)

--Q2. Write a sql query to get the percentage of students who score more than 90  in any subject amongst the total students
select 
cast(count (distinct case when marks >90 then studentid else null end)as float) /count(distinct studentid)*100 perc
from students;

--Q3. Write a sql query to get the second highest and second lowest marks for each subject.
	/* subject		second_highest_marks		second_lowest_marks
	subject1			91								63
	subject2			71								60
	subject3			29								98
	*/
--Method 1
with cte as (
select subject, marks , dense_rank() over(partition by subject order by marks desc) rnk
	,count(subject) over(partition by subject) cnt
from students
)
select subject
	, max(case when rnk=2 then marks else null end )as second_highest_marks
	, max(case when (cnt-rnk)=1 then marks else null end) as second_lowest_marks
from cte
group by subject;

--Method 2
select subject
	, max(case when desc_rnk=2 then marks else null end )as second_highest_marks
	, max(case when asc_rnk=2 then marks else null end) as second_lowest_marks
from
(
	select subject, marks
		,rank() over(partition by subject order by marks desc) desc_rnk
		,rank() over(partition by subject order by marks asc) asc_rnk
	from students
) a
group by subject;



--Q4. for each student and test identify if their marks increased or decreased from the previous test.
select * 
	, case when marks < prev_marks then 'Deceased' 
		   when marks > prev_marks then 'Increased' 
		   else 'N/A' end as status
from(
select *
	,lag(marks,1) over(partition by studentid order by testdate,subject) prev_marks
from students
)a;








CREATE TABLE [students]
(
 [studentid] [int] NULL,
 [studentname] [nvarchar](255) NULL,
 [subject] [nvarchar](255) NULL,
 [marks] [int] NULL,
 [testid] [int] NULL,
 [testdate] [date] NULL
)
data:
insert into students values (2,'Max Ruin','Subject1',63,1,'2022-01-02');
insert into students values (3,'Arnold','Subject1',95,1,'2022-01-02');
insert into students values (4,'Krish Star','Subject1',61,1,'2022-01-02');
insert into students values (5,'John Mike','Subject1',91,1,'2022-01-02');
insert into students values (4,'Krish Star','Subject2',71,1,'2022-01-02');
insert into students values (3,'Arnold','Subject2',32,1,'2022-01-02');
insert into students values (5,'John Mike','Subject2',61,2,'2022-11-02');
insert into students values (1,'John Deo','Subject2',60,1,'2022-01-02');
insert into students values (2,'Max Ruin','Subject2',84,1,'2022-01-02');
insert into students values (2,'Max Ruin','Subject3',29,3,'2022-01-03');
insert into students values (5,'John Mike','Subject3',98,2,'2022-11-02');
