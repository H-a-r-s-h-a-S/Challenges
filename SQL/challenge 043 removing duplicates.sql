-- https://www.linkedin.com/posts/ankitbansal6_sql-analytics-accenture-activity-7204329616574980096-IaRx/?utm_source=share&utm_medium=member_ios

drop database if exists challenges ;
create schema challenges ;
use challenges ;

-- Here is a very interesting SQL interview question based on removing duplicate data.
--
-- You need to find duplicates based on email id and retain the lower case email id employee as shown in the picture.
--
-- Now the solution may vary based on your database case sensitivity settings.
--
-- You need to make sure that you display all the columns for each employee and not just email id.
--
-- I have solved this problem with both cases when your database is case sensitive and when it is not.
--
-- Can you solve this ?

create table employees (
    employee_id int,
    employee_name varchar(100),
    email_id varchar(100)
    ) ;

insert into employees
values (101, 'Liam Alton', 'li.al@abc.com'),
(102, 'Josh Day', 'jo.da@abc.com'),
(103, 'Sean Mann', 'se.ma@abc.com'),
(104, 'Evan Blake', 'ev.bl@abc.com'),
(105, 'Toby Scott', 'jo.da@abc.com'),
(106, 'Anjan Chouhan', 'JO.DA@ABC.COM') ;


-- SHOW COLLATION WHERE Charset = 'utf8mb4' ;

with cte as (
    select email_id,
    count(1) as duplicates
    from employees
    group by email_id
    having count(1) > 1
    )
select e.*
from employees e
join cte c
on c.email_id collate utf8mb4_0900_as_cs = e.email_id ;
