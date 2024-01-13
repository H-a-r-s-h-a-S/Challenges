-- https://www.linkedin.com/posts/nitish2308_30dayssqlchallenge-sql-sqlquery-activity-7151852888787427330--rm9/?utm_source=share&utm_medium=member_ios

drop database if exists challenges ;
create schema challenges ;
use challenges ;

-- Write a SQL query to generate a report for e-commerce database.
-- The report should include the product ID, title, total stock (including incoming stock and total Returns).

create table returns (
	product_id int,
	dt timestamp
);

create table products (
	id int primary key,
	title varchar(255) not null
);

create table stocks (
	product_id int primary key,
	quantity int not null
);

insert into returns (product_id, dt) values 
	(1, '2023-07-28 14:58:52'),
	(1, '2023-07-30 09:48:25'),
	(1, '2023-07-06 05:51:37'),
	(1, '2023-07-26 06:44:08'),
	(1, '2023-07-01 04:29:56'),
	(1, '2023-07-18 00:50:04'),
	(2, '2023-07-25 00:42:58'),
	(2, '2023-07-02 00:51:43'),
	(2, '2023-07-08 14:55:06');

insert into products (id, title) values 
	(1, 'Sleek Widget'),
	(2, 'Gizmo Deluxe'),
	(3, 'Techy Gadget');

insert into stocks (product_id, quantity) values 
	(1, 80),
	(2, 56),
	(3, 13);

select
	distinct s.product_id,
			 p.title, 
			 s.quantity + count(r.product_id) over(partition by s.product_id) total_stock
from
	stocks s left join returns r on s.product_id=r.product_id
				  join products p on s.product_id=p.id ;
