-- https://www.linkedin.com/posts/dhirajgupta141_google-sql-pyspark-activity-7169942122874191873-7DsK/?utm_source=share&utm_medium=member_ios

-- Given the Employee table, write a SQL query that finds out 
-- managers with at least 5 direct reportee.

drop database if exists challenges ;
create schema challenges ;
use challenges ;

create table if not exists employee (
	id int,
	name varchar(255),
	department varchar(255),
	managerid int
);

insert into employee(id, name, department, managerid) values
	('101', 'John', 'a', null),
	('102', 'Dan', 'a', '101'),
	('103', 'James', 'a', '101'),
	('104', 'Amy', 'a', '101'),
	('105', 'Anne', 'a', '101'),
	('106', 'Ron', 'b', '101'),
	('107', 'Tony', 'c', '103'),
	('108', 'Rocky', 'c', '103');

with aggregate as (
	select m.id,
		count(e.id) as reporters
	from employee m
		left join employee e
			on e.managerid = m.id
	group by m.id
)
-- select * from aggregate ;
select name 
from employee e
where exists (select 1 from aggregate a where a.id=e.id and a.reporters > 4) ;
