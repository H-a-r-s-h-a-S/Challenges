-- https://www.linkedin.com/posts/ankitbansal6_sql-analytics-activity-7255422738440298498-fZJF/?utm_source=share&utm_medium=member_ios

drop database if exists challenges ;
create schema challenges ;
use challenges ;

/*

You are given a table of students along with their seat numbers. 
You need to write an SQL to swap the seats of consecutive students.
If the number of students is odd then the last student's seat won't be swapped. 

Here you need to do 2 tasks: 

(1) Write an SQL which creates a new id column with swapped seat ids.
(2) Update the original id column in the table with the swapped seat ids.

*/

create table students (
	id int,
	name varchar(20)
);

insert students (id, name)
values
	(1, 'amit'),
	(2, 'deepa'),
	(3, 'rohit'),
	(4, 'anjali'),
	(5, 'neha'),
	(6, 'kaushal'),
	(7, 'arun') ;

alter table students add column swap_id int ;

select max(id) from students into @max_id ;
update students set swap_id = case when id=@max_id and id%2 <> 0 then id when id %2 = 0 then id-1 else id+1 end ;

select *
from students ;
