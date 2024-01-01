-- https://www.linkedin.com/posts/milind-zuge_sqlchallenge-day8-dataanalytics-activity-7147468111342993408-30NH?utm_source=share&utm_medium=member_ios

-- Challenge Statement: Calculate the total business working days for the resolution of tickets, 
-- where you have a ticket table with a column ticket_id, create_date, resolved_date and 
-- holiday table, where you have column holiday_date, reason.

drop database if exists challenges ;
create schema challenges ;
use challenges ;

create table tickets (
	ticket_id varchar(10),
	create_date date,
	resolved_date date
);

insert into tickets values
	(1,'2022-08-01','2022-08-03'),
	(2,'2022-08-01','2022-08-12'),
	(3,'2022-08-01','2022-08-16') ;

create table holidays
(
	holiday_date date,
	reason varchar(100)
);

insert into holidays values
	('2022-08-13','Week public holiday'),
	('2022-08-11','Rakhi'),
	('2022-08-15','Independence day');

DROP FUNCTION IF EXISTS business_days ;
DELIMITER |
CREATE FUNCTION `business_days` (start_date date, end_date date)
RETURNS int
DETERMINISTIC
BEGIN
set @days = (select datediff(end_date, start_date) - (select count(*) from holidays where holiday_date between start_date and end_date and dayofweek(holiday_date) not in (6,7))) ;
RETURN @days ;
END;
|
DELIMITER ;

select *, business_days(create_date, resolved_date) as `business_days` from tickets ;

-- or simply
select *, (select datediff(resolved_date, create_date) - (select count(*) from holidays where holiday_date between create_date and resolved_date and dayofweek(holiday_date) not in (6,7))) business_days from tickets ;
