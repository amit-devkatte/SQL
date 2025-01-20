select * from person;
select * from friends;

with cte as(
select p.PersonID, p.name, p1.PersonID as friend_id, p1.Name as fname, p1.Score as fscore
from person p
left join friends f
on p.PersonID = f.user_id
join person p1 on f.friend_id = p1.personid
)

select personId, name, count(friend_id) as no_of_friends, sum(fscore) sum_of_friend_score
from cte
group by personId, name
having sum(fscore) >100
;