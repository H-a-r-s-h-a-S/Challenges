-- https://www.linkedin.com/posts/milind-zuge_dataanlytics-sql-activity-7144577867413188608-spO9?utm_source=share&utm_medium=member_ios

-- Problem Statement:
-- Write an SQL query for the validation of records between source and target.
-- You have 2 input tables source, target and you need to derive output table.

drop database if exists challenges ;
create schema challenges ;
use challenges ;

create table source (
	id int,
	name varchar(5)
) ;

create table target (
	id int,
	name varchar(5)
) ;

insert into source values (1,'A'),(2,'B'),(3,'C'),(4,'D') ;

insert into target values (1,'A'),(2,'B'),(4,'X'),(5,'F') ;

with new_in_source as (select id, 'New in source' comment from source s where not exists (select 1 from target t where t.id=s.id) ),
new_in_target as (select id, 'New in target' comment from target t where not exists (select 1 from source s where t.id=s.id) ),
mismatch as (select s.id, 'mismatch' comment from source s join target t on t.id=s.id and t.name<>s.name)
select * from new_in_source
union all
select * from new_in_target
union all
select * from mismatch ;