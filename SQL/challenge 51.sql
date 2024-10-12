-- https://www.linkedin.com/posts/ankitbansal6_sql-analytics-activity-7242874541318807553-g22X/?utm_source=share&utm_medium=member_ios

drop database if exists challenges ;
create schema challenges ;
use challenges ;

-- Can you solve this SQL interview question where we need to find phone numbers which do not have any repeating digits ( Excluding extensions)

create table phone_numbers (num varchar(20));

insert into phone_numbers values
	('1234567780'),
	('2234578996'),
	('+1-12244567780'),
	('+32-2233567889'),
	('+2-23456987312'),
	('+91-9087654123'),
	('+23-9085761324'),
	('+11-8091013345');

select *
from phone_numbers
where right(num,10) regexp '^(?!.*([0-9]).*\\1)[0-9]{10}$' ;
