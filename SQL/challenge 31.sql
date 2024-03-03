-- https://www.linkedin.com/posts/omkar-patil-5ab62b190_credits-to-ankit-bansal-for-a-stimulating-activity-7152673984730259457-Z6cu/?utm_source=share&utm_medium=member_ios

drop database if exists challenges ;
create schema challenges ;
use challenges ;

-- 𝐓𝐡𝐞 𝐂𝐡𝐚𝐥𝐥𝐞𝐧𝐠𝐞:
-- Utilize a SQL query to track the annual growth of new cities in Udaan's network, 
-- a critical metric for any growing business. 
-- This exercise is not just about executing a query, 
-- but about understanding the dynamics of business expansion through data.

create table business_city (
	business_date date,
	city_id int
);

delete from business_city;

insert into business_city
values (cast('2020-01-02' as date),3),
	(cast('2020-07-01' as date),7),
	(cast('2021-01-01' as date),3),
	(cast('2021-02-03' as date),19)
	,(cast('2022-12-01' as date),3),
	(cast('2022-12-15' as date),3),
	(cast('2022-02-28' as date),12);

with cte as (
	select business_date,	
		city_id,
		row_number() over(partition by city_id order by business_date) rn
	from business_city
),
cte2 as (
	select *,
		sum(case when rn=1 then 1 else 0 end) over(partition by year(business_date) rows between unbounded preceding and current row) as new_cities,
		sum(case when rn=1 then 1 else 0 end) over(order by business_date rows between unbounded preceding and current row) as total_cities
	from cte 
	order by business_date
),
cte3 as (
		select year(business_date) as business_year,
		max(new_cities) as new_cities,
		max(total_cities) as total_cities
	from cte2 
	group by year(business_date)
)
select business_year,
	new_cities,
	total_cities,
	round((new_cities*100)/total_cities,2) as new_cities_percentage
from cte3 ;
