drop database if exists challenges ;
create schema challenges ;
use challenges ;

-- Find duplicate rows in a table and group them by their count.

create table dupes (
    id int,
    name varchar(20)
) ;

insert into dupes (id, name) values (1, 'bob'), (2, 'tom'), (3, 'george'), (4, 'john'), (2, 'tom'), (3, 'george') ;

with cte as (select id, name, count(*) as dupes from dupes group by id, name)
select dupes, count(*) as records from cte where dupes > 1 group by dupes ;
