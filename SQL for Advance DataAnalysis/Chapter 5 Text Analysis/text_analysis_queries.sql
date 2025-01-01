-- text characteristics
select * from ufo;
select length('sample string');

select length( sighting_report) ,count(*) as records
from ufo
group by 1
order by 1
;

--------------------------------------------- Text parsing ------------------------------------------------------------------

select left('the data is about ufo''s',3) as left_digits
	,right ('the data is about ufo''s',5) as right_digits
;

--parsing first word 'occurred' from sighting_report column
select left(sighting_report, 8) from ufo;

select left(sighting_report,8), count(*) as cnt 
from ufo
group by 1
;

--parsing datetime after occurred word
select right(left(sighting_report ,25),14) as occurred
from ufo
;

--parsing using split_part() or substring_index()
--split_part(string or field, delimiter, index)

select split_part('This is an example of an example string','an example',1) as split_part;
--This is
select split_part('This is an example of an example string','an example',2)as split_part;
-- of

--getting string after occurred word
select split_part(sighting_report, 'Occurred : ',2) as split_1
from ufo
;

select split_part(sighting_report, '(Entered',1) as split_2 
from ufo
;
--nesting of split_part

select split_part(
		split_part (sighting_report,'(Entered',1)
		,'Occurred : '
		,2) as occurred
from ufo
;

--some records omit the 'Entered as ' string because of that 'Reported' lab;e is appearing.
-- to remove that we need one more split_part() nesting as below
select split_part(
			split_part(
				split_part(sighting_report, '(Entered',1), 'Occurred : ',2),'Reported',1) as occurred
from ufo
;

select split_part(
			split_part(
				split_part(sighting_report, '(Entered',1), 'Occurred : ',2),'Reported',1) as occurred
				,count(*) cnt
from ufo
group by 1
;

--applying parsing to other fields occurred,Enetered reported, posted, location, shape, duration

create view split_report as(
select split_part(
			split_part(
				split_part(sighting_report , 'Occurred : ',2),'(Entered',1),'Reported',1) as occurred
		,split_part(
			split_part(sighting_report, '(Entered as : ',2),')',1) as entered
		,split_part(
			split_part(
				split_part(
					split_part(sighting_report,'Reported: ',2)
				,'Posted',1)
			,' PM',1)
		,' AM',1) as reported
	,split_part(
		split_part(sighting_report,'Posted: ',2)
	,'Location',1) as posted
	,split_part(
		split_part(sighting_report, 'Shape',1),'Location: ',2) as location
	,split_part(
		split_part(sighting_report, 'Shape: ',2),'Duration',1) as shape
	,split_part(sighting_report,'Duration:',2)as duration
from ufo
);
select * from split_report;

--------------------------------------------- Text Transformation ------------------------------------------------------------------
-- functions : upper(),lower(),initcap(),trim(),trim(leading/trailing '$' from '$california'),replace()
-- date type conversion :: or cast( as )

select upper('some sample text');
select lower ('SOME SAMPLE TEXT');
select initcap('sachin ramesh tendulkar');
select trim(' california ');
select trim(leading '$' from '$california#');
select trim (trailing '#' from (select trim(leading '$' from '$california#')))
select ltrim('$california#','$');  --left trim
select rtrim('$california#','#');	--right trim

-- converting 'TRIANGULAR' to initcap from shape column.
select distinct shape, initcap(shape)as shape_clean
from(
select split_part(
		split_part(sighting_report,'Shape: ',2),'Duration',1) as shape
from ufo
)a
;

-- removing white spaces from duration column
-- -testing
select
	distinct(length(split_part (sighting_report,'Duration:',2)) 
	- length(trim(split_part (sighting_report,'Duration:',2)))
	)
	as length_diff
	,count(*)
from ufo
group by 1
;

select duration, trim(duration) as duration_clean
from(
	select split_part(sighting_report,'Duration:',2) as duration
	from ufo
)a

--Data type conversion
set datestyle to US;  -- Due to different datestyle when postgres installed, its does not match with the book which is us datestyle.

select 
	case when occurred ='' then null 
		 when length(occurred) < 8 then null
		 else occurred::timestamp end as occurred
	,case when length (reported)< 8 then null
		  else reported :: timestamp
		  end reported
	,case when posted ='' then null
		  else posted :: date
		  end as posted
	,location, shape, duration
from(select trim(occurred) as occurred, reported, posted, location, shape, duration from split_report)
;

select * from split_report;

select location ,
	replace (replace (location, 'close to','near')
	,'outside of','near') as location_clean
from split_report
;

select 
	case when occurred ='' then null 
		 when length(occurred) < 8 then null
		 else occurred::timestamp end as occurred
	,case when length (reported)< 8 then null
		  else reported :: timestamp
		  end reported
	,case when posted ='' then null
		  else posted :: date
		  end as posted
	,replace (replace (location,'close to','near'),'outside of','near')as location
	, initcap(shape) as shape
	, trim(duration) as duration
from(select trim(occurred) as occurred, reported, posted, location, shape, duration from split_report)
;

------------------------------Finding elements in larger block of text------------------------------------------------
--like _ % 
select count(*) cnt 
from ufo
where description like '%wife%'
;

--make search case insensitive
select count(*)
from ufo
-- where lower(description) like '%wife%' 
where description ilike '%wife%'
;

--records that do not mentioned 'wife' then use NOT LIKE
select count(*)
from ufo
where lower(description) not like '%wife%'
;

--filtering multiple string using AND and OR operator
--find records containing either wife or husband
select count(*)
from ufo
where lower(description) like '%wife%' or lower(description) like '%husband%'
;

--when using AND and OR operator sequence/ order of operation is important, proper use of parenthesis is required.
select count(*)
from ufo
where lower(description) like '%wife%'
or lower(description) like '%husband%'
and lower(description) like '%mother%'
;
--6610
select count(*)
from ufo
where (lower(description) like '%wife%'
		or lower(description) like '%husband%'
	   )
and lower(description) like '%mother%'
;
--382

--Categorization

select
case when lower(description) like '%driving%' then 'driving'
	 when lower(description) like '%walking%' then 'walking'
	 when lower(description) like '%running%' then 'running'
	 when lower(description) like '%cycling%' then 'cycling'
	 when lower(description) like '%swimming%' then 'swimming'
	 else 'none' end as activit
,count(*)
from ufo
group by 1
order by 2 desc
;


select 
	description ilike '%south%' as south
	,description ilike '%north%' as north
	,description ilike '%east%' as east
	,description ilike '%west%' as west
	,count(*)
from ufo
group by 1,2,3,4
order by 1,2,3,4
;

select 
 count(case when description ilike '%south%' then 1 end) as south
 ,count(case when description ilike '%north%' then 1 end) as north
 ,count(case when description ilike '%west%' then 1 end) as west
 ,count(case when description ilike '%east%' then 1 end) as east
from ufo
;

----Exact mathches :IN, NOT IN


























































