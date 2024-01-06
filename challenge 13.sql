-- https://www.linkedin.com/posts/milind-zuge_sqlchallenge-day10-analytics-activity-7148174731232399360-vgfT?utm_source=share&utm_medium=member_ios

-- Challenge Statement
-- Calculate the new, repeat customer count and revenue for the provided orders dataset.
-- You have given an order table with columns order_id, cust_id, order_date, order_amount

drop database if exists challenges ;
create schema challenges ;
use challenges ;

create table cust_orders (
	order_id integer,
	customer_id integer,
	order_date date,
	order_amount integer
);

insert into cust_orders values
	(1,100,cast('2022-01-01' as date),2000),
	(2,200,cast('2022-01-01' as date),2500),
	(3,300,cast('2022-01-01' as date),2100),
	(4,100,cast('2022-01-02' as date),2000),
	(5,400,cast('2022-01-02' as date),2200),
	(6,500,cast('2022-01-02' as date),2700),
	(7,100,cast('2022-01-03' as date),3000),
	(8,400,cast('2022-01-03' as date),1000),
	(9,600,cast('2022-01-03' as date),3000) ;

with cte as (select *, row_number() over(partition by customer_id) rn from cust_orders)
select 
	order_date, 
	sum(case when rn=1 then 1 else 0 end) first_visit,
	sum(case when rn<>1 then 1 else 0 end) repeat_visit,
	sum(case when rn=1 then order_amount else 0 end) first_visit_revenue,
	sum(case when rn<>1 then order_amount else 0 end) repeat_visit_revenue
from cte 
group by order_date;
