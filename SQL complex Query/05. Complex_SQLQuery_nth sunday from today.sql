
declare @today_date as date = getdate();
declare @n int =3;
select @today_date;		--gives today's date
select datepart(weekday, @today_date); -- gives day number of the week starting from sun=1
select dateadd(day , 8-datepart(weekday,@today_date), @today_date); -- sub weekday number from 8 and add those number of days in today date to get sunday
select dateadd(week, @n-1, dateadd(day, 8-datepart(weekday,@today_date), @today_date)) -- adding 1 less number of weeks to date to arrive nth sunday from today