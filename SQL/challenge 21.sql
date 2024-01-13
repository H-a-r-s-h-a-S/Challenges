-- https://www.linkedin.com/posts/omkar-patil-5ab62b190_dataanalytics-mysql-database-activity-7150806071001894923-yAeq?utm_source=share&utm_medium=member_ios

drop database if exists challenges ;
create schema challenges ;
use challenges ;

-- Find the total number of messages exchanged between each person each day in the "subscriber" table

CREATE TABLE subscriber (
	sms_date date ,
	sender varchar(20) ,
	receiver varchar(20) ,
	sms_no int
);


INSERT INTO subscriber VALUES 
	('2020-4-1', 'Avinash', 'Vibhor',10), 
	('2020-4-1', 'Vibhor', 'Avinash',20), 
	('2020-4-1', 'Avinash', 'Pawan',30), 
	('2020-4-1', 'Pawan', 'Avinash',20), 
	('2020-4-1', 'Vibhor', 'Pawan',5), 
	('2020-4-1', 'Pawan', 'Vibhor',8), 
	('2020-4-1', 'Vibhor', 'Deepak',50) ;

with cte as (select *, row_number() over() rn from subscriber)
select 
	sms_date, 
	case when rn % 2 = 0 then sender else receiver end as sender,
	case when rn % 2 <> 0 then sender else receiver end as receiver,
	sum(sms_no) msg
from
	cte
group by
	1, 2, 3
order by
	4 desc ;
