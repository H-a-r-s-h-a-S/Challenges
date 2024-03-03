-- https://www.linkedin.com/posts/nitish2308_swiggy-sql-interview-questions-activity-7146388114817667072-Xxs4?utm_source=share&utm_medium=member_ios

-- Write a SQL Query to fetch the visitors name, number of visits made(total visits as whole)  and 
-- most visited floor for each name?

drop database if exists challenges ;
create schema challenges ;
use challenges ;

create table building_visits (
	visit_date_time datetime,
	visitors_name varchar(25),
	visited_floor int
) ;

insert into building_visits values
	('2023-12-28 09:00','Arjun',5),
	('2023-12-28 10:30','Priya',8),
	('2023-12-28 11:15','Arjun',10),
	('2023-12-28 14:00','Ananya',3),
	('2023-12-28 15:45','Priya',8),
	('2023-12-28 16:30','Arjun',5),
	('2023-12-28 17:20','Ananya',2),
	('2023-12-28 18:10','Priya',6),
	('2023-12-28 18:45','Arjun',1),
	('2023-12-28 19:30','Ananya',2) ;

with cte1 as (select
	visitors_name, 
	visited_floor,
	visit_date_time,
	count(1) over(partition by visitors_name) total_visits,
	count(1) over(partition by visitors_name, visited_floor) count_by_floor
from
	building_visits)

, cte2 as (select
				*,
				row_number() over(partition by visitors_name order by count_by_floor desc, visit_date_time desc) rnk 
			from
				cte1 )

select
	visitors_name, 
	total_visits, 
	visited_floor `most visited floor` 
from 
	cte2
where
	rnk=1 ;