-- https://www.linkedin.com/posts/ankitbansal6_sql-analytics-activity-7148154966149378048-fEsd?utm_source=share&utm_medium=member_ios

-- Find total clocked hours for each employee

drop database if exists challenges ;
create schema challenges ;
use challenges ;

create table clocked_hours(
	empd_id int,
	swipe time,
	flag char
);

insert into clocked_hours values
	(11114,'08:30','I'),
	(11114,'10:30','O'),
	(11114,'11:30','I'),
	(11114,'15:30','O'),
	(11115,'09:30','I'),
	(11115,'17:30','O') ;

with cte1 as (select *, row_number() over(partition by empd_id order by swipe asc) rn from clocked_hours)
select
	c1.empd_id,
	sec_to_time(sum(time_to_sec(timediff(c2.swipe, c1.swipe)))) `total clocked hours` 
from
	cte1 c1 
join
	cte1 c2 on 
		c1.empd_id = c2.empd_id and
		c1.rn+1 = c2.rn and 
		c1.flag = 'I'
group by
	c1.empd_id ;
