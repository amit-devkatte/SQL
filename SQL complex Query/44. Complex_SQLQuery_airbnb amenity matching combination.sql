--Q44. The airbnb booking recommendation team is trying to understand the substitutaibility of two rentals and 
-- whether one rental is a good substitute for another. They want you to write a query to determine if two airbnb rentals have  the same exact
--amenities offered.

with cte as (
select rental_id,string_agg(amenity,',') within group (order by amenity) as amenity_list
from rental_amenities
group by rental_id
)
select count(1) matching_combination
from cte a join cte b 
on a.amenity_list = b.amenity_list and a.rental_id > b.rental_id
;



create table rental_amenities
(
	rental_id int,
	amenity varchar (50)
);

insert into rental_amenities values 
(123, 'pool'),
(123, 'kitchen'),
(234,'hot tub'),
(234, 'fireplace'),
(345,'kitchen'),
(345,'pool'),
(456,'pool'),
(452,'beach'),
(452,'free parking'),
(231,'pet-friendly'),
(956,'pet-friendly'),
(641, 'fireplace'),
(999, 'fireplace'),
(864, 'fireplace'),
(452,'beach'),
(642,'pool');