-- advance data analytics chapter 5 text analysis
-- table creation 

drop table if exists ufo;
CREATE TABLE ufo
(
	sighting_report varchar(1000)
	,description text
)
;


-- change the localpath as  per directory where the csv files saved on local drive

copy ufo from 'D:\Amit\SQL\SQL for Advance DataAnalysis\Chapter 5 Text Analysis\ufo1.csv' delimiter ',' csv header;

copy ufo from 'D:\Amit\SQL\SQL for Advance DataAnalysis\Chapter 5 Text Analysis\ufo2.csv' delimiter ',' csv header;

copy ufo from 'D:\Amit\SQL\SQL for Advance DataAnalysis\Chapter 5 Text Analysis\ufo3.csv' delimiter ',' csv header;

copy ufo from 'D:\Amit\SQL\SQL for Advance DataAnalysis\Chapter 5 Text Analysis\ufo4.csv' delimiter ',' csv header;

copy ufo from 'D:\Amit\SQL\SQL for Advance DataAnalysis\Chapter 5 Text Analysis\ufo5.csv' delimiter ',' csv header;

-- select * from ufo;


