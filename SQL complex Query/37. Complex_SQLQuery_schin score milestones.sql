--Q.37 find sachin's milestones innings/matches
select * from sachin_scores;

with cte1 as(
	select *, sum(runs) over (order by match rows between unbounded preceding and current row) rolling_sum
	from sachin_scores
)
,cte2 as (
	select 1 as milestone_number , 1000 as milestone_runs
	union all
	select 2 as milestone_number , 5000 as milestone_runs
	union all
	select 3 as milestone_number , 10000 as milestone_runs
	union all
	select 3 as milestone_number , 15000 as milestone_runs
)
select milestone_number,milestone_runs, min(match) no_of_matchs, min(innings) no_of_innings
from cte2 join cte1 
on rolling_sum > milestone_runs
group by milestone_number,milestone_runs