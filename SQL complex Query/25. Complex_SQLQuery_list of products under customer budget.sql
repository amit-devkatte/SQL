--Q25. MISSHO HAcker RANK online SQL test
--Find how many products falls into customer budget along with list of products
-- in case of clash choose the less costly product

select * from products_missho;
select * from customer_budget_missho;

select customer_id,max(budget) Budget, count(product_id) no_of_products, STRING_AGG(product_id, ',') product_list 
from(
	select *
	,case when b.budget > sum(p.cost) over(partition by b.customer_id order by p.cost) Then 1 else 0 end  flag
	from customer_budget_missho b left join products_missho p on b.budget > p.cost
) a
Where flag =1
group by customer_id;



create table products_missho
(
product_id varchar(20) ,
cost int
);
insert into products_missho values ('P1',200),('P2',300),('P3',500),('P4',800);

create table customer_budget_missho
(
customer_id int,
budget int
);
insert into customer_budget_missho values (100,400),(200,800),(300,1500);