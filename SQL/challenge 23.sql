-- https://www.linkedin.com/posts/bikash-deb_udaan-ugcPost-7151432757120843776-bECN?utm_source=share&utm_medium=member_ios

drop database if exists challenges ;
create schema challenges ;
use challenges ;

-- Utilize a SQL query to track the annual growth of new cities in Udaan's network, 
-- a critical metric for any growing business. 
-- This exercise is not just about executing a query, 
-- but about understanding the dynamics of business expansion through data.

create table business_city (
	business_date date,
	city_id int
) ;

insert into business_city values
	(cast('2020-01-02' as date),3),
	(cast('2020-07-01' as date),7),
	(cast('2021-01-01' as date),3),
	(cast('2021-02-03' as date),19),
	(cast('2022-12-01' as date),3),
	(cast('2022-12-15' as date),3),
	(cast('2022-02-28' as date),12) ;

with tmp as (select *, row_number() over(partition by city_id) rn from business_city)
select year(business_date) `year`, sum(case when rn=1 then 1 else 0 end) `new_cities`
from tmp
group by 1 ;