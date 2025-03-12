--Q39. Write a sql query to report the students (student_id, student_name) being "quite" in all exams
-- a "quite" student is the one who took at least one exam and didn't score neighther highest or the lowest score in any of the exam.
--don't return the student who has not taken any exam. return the table ordered by student_id.
select * from student;
select * from exam;


select aa.student_id,s.student_name 
from (
select student_id
from(
	select * 
		,min(score) over(partition by exam_id ) min_score
		,max(score) over(partition by exam_id ) max_score
		,case when score >  min(score) over(partition by exam_id ) 
			and score < max(score) over(partition by exam_id ) then 0 else 1 end flag
	from exam ) a
group by student_id
having max(flag)=0) aa
Join student s on aa.student_id=s.student_id;



create table student
(
student_id int,
student_name varchar(20)
);
insert into student values
(1,'Daniel'),(2,'Jade'),(3,'Stella'),(4,'Jonathan'),(5,'Will');

create table exam
(
exam_id int,
student_id int,
score int);

insert into exam values
(10,1,70),(10,2,80),(10,3,90),(20,1,80),(30,1,70),(30,3,80),(30,4,90),(40,1,60)
,(40,2,70),(40,4,80);