-- https://www.linkedin.com/posts/milind-zuge_sqlchallenge-day16-input-activity-7150533496006971395-PqO8?utm_source=share&utm_medium=member_ios

drop database if exists challenges ;
create schema challenges ;
use challenges ;

-- Below is the flight schedule mentioning the source and destination. 
-- We have to show the unique combination of source and destination as an output. 
-- For eg: Delhi to Mumbai and Mumbai to Delhi is one unique combination

create table flight (
	src varchar(10),
	dest varchar(10)
) ;

insert into flight values 
	('Delhi','Mumbai'), 
	('Mumbai','Delhi'), 
	('Delhi','Kolkata'), 
	('Kolkata','Delhi'), 
	('Mumbai','Nagpure') ;

with tmp as (select *, row_number() over() rn from flight )
select
	distinct 
	case when rn%2=0 then dest else src end as src, 
	case when rn%2<>0 then dest else src end as dest
from tmp ;
