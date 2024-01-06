-- https://www.linkedin.com/posts/milind-zuge_complex-sql-problem-activity-7149400678417833984-hS9r?utm_source=share&utm_medium=member_ios

drop database if exists challenges ;
create schema challenges ;
use challenges ;

-- Challenge statement: 
-- Write an SQL to get the required output from the image below. 
-- You have given an entries dataset with columns like [name, address, email, floor, resourses_used], 
-- where you have to find out the user's total_visits, most_visited_floor, and total resources used by them.

create table entries ( 
	name varchar(20),
	address varchar(20),
	email varchar(20),
	floor int,
	resources varchar(10)
) ;

insert into entries values
	('A','Bangalore','A@gmail.com',1,'CPU'),
	('A','Bangalore','A1@gmail.com',1,'CPU'),
	('A','Bangalore','A2@gmail.com',2,'DESKTOP'),
	('B','Bangalore','B@gmail.com',2,'DESKTOP'),
	('B','Bangalore','B1@gmail.com',2,'DESKTOP'),
	('B','Bangalore','B2@gmail.com',1,'MONITOR') ;

with cte1 as (select
	name,
	floor,
	count(1) over(partition by name) total_visits,
	count(1) over(partition by name, floor) floor_visits
from
	entries ),
cte2 as (select *, row_number() over(partition by name order by floor_visits desc) rn from cte1)
select e.name, c.total_visits, c.floor most_visited_floor, group_concat(distinct e.resources separator ', ') resources_used 
from entries e join cte2 c on e.name=c.name 
where c.rn=1
group by e.name, c.total_visits, c.floor ;
