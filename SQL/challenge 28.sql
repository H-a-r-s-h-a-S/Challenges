-- https://www.linkedin.com/posts/dhirajgupta141_read-third-quarter-of-the-table-in-sql-activity-7151420551943598080-KruY?utm_source=share&utm_medium=member_ios

drop database if exists challenges ;
create schema challenges ;
use challenges ;

-- Read the third quarter (25%) of emp_data table.

create table emp_data(
	name varchar(30),
	age int
) ;

insert into emp_data(name, age) values('Alice', 28),
	('Bob', 35),
	('Charlie', 42),
	('David', 25),
	('Eva', 31),
	('Frank', 38),
	('Grace', 45),
	('Henry', 29); 

with cte as (select *, ntile(4) over(order by age desc) tile from emp_data )
select name, age from cte where tile = 3;
