-- https://www.linkedin.com/posts/vivek-6a821b23a_deloitte-sql-interview-problem-write-activity-7146691886936670208-ykNE?utm_source=share&utm_medium=member_ios

-- write a sql query to find the products whose total sales revenue has increased every year. 
-- include the product_id, product_name and category in the result.

drop database if exists challenges ;
create schema challenges ;
use challenges ;

create table products (
	product_id int primary key,
	product_name varchar(50),
	category varchar(50)
) ;

insert into products (product_id, product_name, category) values
	(1, 'laptops', 'electronics'),
	(2, 'jeans', 'clothing'),
	(3, 'chairs', 'home appliances') ;

create table sales (
	product_id int,
	year int,
	total_sales_revenue decimal(10, 2),
	primary key (product_id, year),
	foreign key (product_id) references products(product_id)
) ;

insert into sales (product_id, year, total_sales_revenue) values
	(1, 2019, 1000.00),
	(1, 2020, 1200.00),
	(1, 2021, 1100.00),
	(2, 2019, 500.00),
	(2, 2020, 600.00),
	(2, 2021, 900.00),
	(3, 2019, 300.00),
	(3, 2020, 450.00),
	(3, 2021, 400.00) ;

with tmp as (select *, lag(total_sales_revenue) over(partition by product_id order by year) lg from sales)
select * from products p 
where not exists (select 1 from tmp t where (t.total_sales_revenue - t.lg)  <= 0 and t.product_id=p.product_id) ;
