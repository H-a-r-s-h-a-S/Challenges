-- https://www.linkedin.com/posts/bikash-deb_bosch-ugcPost-7153256994273976320-I-pd/?utm_source=share&utm_medium=member_ios

drop database if exists challenges ;
create schema challenges ;
use challenges ;

-- 1️⃣ Identify phone numbers that have both incoming and outgoing calls.
-- 2️⃣ Ensure the sum of outgoing call durations exceeds that of incoming calls.

create table call_details (
	call_type varchar(10),
	call_number varchar(12),
	call_duration int
);

insert into call_details
values ('OUT','181868',13),
	('OUT','2159010',8),
	('OUT','2159010',178),
	('SMS','4153810',1),
	('OUT','2159010',152),
	('OUT','9140152',18),
	('SMS','4162672',1),
	('SMS','9168204',1),
	('OUT','9168204',576),
	('INC','2159010',5),
	('INC','2159010',4),
	('SMS','2159010',1),
	('SMS','4535614',1),
	('OUT','181868',20),
	('INC','181868',54),
	('INC','218748',20),
	('INC','2159010',9),
	('INC','197432',66),
	('SMS','2159010',1),
	('SMS','4535614',1);

-- Both incoming and outgoing
select call_number 
from call_details 
where call_type in ('OUT', 'INC')
group by call_number
having count(distinct call_type) = 2 ;

-- outgoing > income
with cte as (
	select call_number 
	from call_details 
	where call_type in ('OUT', 'INC')
	group by call_number
	having count(distinct call_type) = 2
)
select call_number,
	sum(case when call_type='INC' then call_duration else 0 end) incoming_duration,
	sum(case when call_type='OUT' then call_duration else 0 end) outgoing_duration
from call_details
where call_number in (select call_number from cte)
group by call_number 
having outgoing_duration > incoming_duration ;
