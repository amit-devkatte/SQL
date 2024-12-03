

CREATE TABLE students
( 
	id int,
	name varchar
)
;

INSERT INTO students
VALUES
(1,'Amit'),
(2,'Arjun'),
(3,'Sujata'),
(4,'Amit'),
(5,'Arjun')
;

/*Q26. Get the count of distinct student that are unique */

SELECT  count(*) count_of_distinct_unique_student
FROM(
	SELECT name ,COUNT(name)
	FROM students
	GROUP BY name
	HAVING count(name) =1
);

/*Q27. Get the count of distinct student that are not unique */

SELECT count(*) count_of_students_not_unique
FROM(
	SELECT name, count(name)
	FROM students
	GROUP BY name
	HAVING Count(name)>1
);





