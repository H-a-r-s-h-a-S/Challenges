-- https://www.linkedin.com/posts/ankitbansal6_namastesql-analytics-sql-activity-7152873301529251841-wGU3/?utm_source=share&utm_medium=member_ios

drop database if exists challenges ;
create schema challenges ;
use challenges ;

-- You need to find the cities where not even a single order was returned.
-- In this case the output will be Mysore.

-- The catch is you can't use subquery or CTE as this assignment is just after the basics are covered
-- like filters , joins , aggregation.

create table namaste_orders (
	order_id int,
	city varchar(10),
	sales int
) ;

create table namaste_returns(
	order_id int,
	return_reason varchar(20)
) ;

insert into namaste_orders values
	(1, 'Mysore' , 100),
	(2, 'Mysore' , 200),
	(3, 'Bangalore' , 250),
	(4, 'Bangalore' , 150)
	,(5, 'Mumbai' , 300),
	(6, 'Mumbai' , 500),
	(7, 'Mumbai' , 800) ;

insert into namaste_returns values
	(3,'wrong item'),
	(6,'bad quality'),
	(7,'wrong item');

select city 
from namaste_orders o
	left join namaste_returns r
		on r.order_id = o.order_id 
group by o.city
having count(r.return_reason)=0 ;