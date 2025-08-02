drop database if exists challenges ;
create schema challenges ;
use challenges ;

-- https://leetcode.com/problems/product-price-at-a-given-date/description/

drop table if exists products ;

create table if not exists products (
	product_id int,
	new_price int,
	change_date date
);


/*

	Initially, all products have price 10.
	
	Write a solution to find the prices of all products on the date 2019-08-16.
	
	Return the result table in any order.
	
	Input: 
	Products table:
	+------------+-----------+-------------+
	| product_id | new_price | change_date |
	+------------+-----------+-------------+
	| 1          | 20        | 2019-08-14  |
	| 2          | 50        | 2019-08-14  |
	| 1          | 30        | 2019-08-15  |
	| 1          | 35        | 2019-08-16  |
	| 2          | 65        | 2019-08-17  |
	| 3          | 20        | 2019-08-18  |
	+------------+-----------+-------------+
	Output: 
	+------------+-------+
	| product_id | price |
	+------------+-------+
	| 2          | 50    |
	| 1          | 35    |
	| 3          | 10    |
	+------------+-------+

*/

insert into products (product_id, new_price, change_date) values (1, 20, '2019-08-14'), (2, 50, '2019-08-14'), (1, 30, '2019-08-15'), (1, 35, '2019-08-16'), (2, 65, '2019-08-17'), (3, 20, '2019-08-18') ;

-- solution
with cte as (select product_id, 10 as new_price, '2019-08-16' as change_date from products),
cte2 as (select * from cte union all select * from products)
select product_id, max(new_price) as price from cte2 where change_date<='2019-08-16' group by product_id ;
