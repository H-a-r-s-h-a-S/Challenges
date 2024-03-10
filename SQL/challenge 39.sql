-- https://www.linkedin.com/posts/bikash-deb_brands-activity-7151628668350427136-RIRr/?utm_source=share&utm_medium=member_ios

drop database if exists challenges ;
create schema challenges ;
use challenges ;

-- The task is to fetch records of brands whose revenue has been increasing every year 
-- from a given table structure. 

create table brands (
	year  int,
	brand  varchar(20),
	amount int
) ;

insert into brands
values
	(2018, 'Apple', 45000),
	(2019, 'Apple', 35000),
	(2020, 'Apple', 75000),
	(2018, 'Samsung', 15000),
	(2019, 'Samsung', 20000),
	(2020, 'Samsung', 25000),
	(2018, 'Nokia', 21000),
	(2019, 'Nokia', 17000),
	(2020, 'Nokia', 14000) ;

with cte as (
	select * ,
		row_number() over(partition by brand order by amount) rn
	from brands
)
select distinct c1.brand
from cte c1
	join cte c2
		on c1.brand = c2.brand
			and c1.year+1 = c2.year
			and c1.rn+1 = c2.rn ;
