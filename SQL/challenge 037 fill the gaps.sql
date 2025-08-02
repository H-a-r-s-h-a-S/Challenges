-- https://www.linkedin.com/posts/bikash-deb_populate-ugcPost-7153970238139609088-DNg9/?utm_source=share&utm_medium=member_ios

drop database if exists challenges ;
create schema challenges ;
use challenges ;

-- Given a table with 'brands' and missing 'category' values,
-- can you craft an SQL query that fills those gaps with the last non-null category?

create table brands (
	category varchar(20),
	brand_name varchar(20)
);

insert into brands
values
	('Chocolates','5-star'),
	(null,'dairy milk'),
	(null,'perk'),
	(null,'eclair'),
	('Biscuits','britannia'),
	(null,'good day'),
	(null,'boost');

with cte as (
	select *,
		row_number() over(order by null) rn
	from brands
)
select rn,
	(@c := coalesce(category, @c)) category,
	brand_name
from cte
order by rn asc ;
