-- https://www.linkedin.com/posts/ankitbansal6_sql-stringmanipulation-activity-7175699956635168768-v7El/?utm_source=share&utm_medium=member_ios#

drop database if exists challenges ;
create schema challenges ;
use challenges ;

-- You are given the customer name and you need to create 3 columns of first name , middle name and last name.
-- The challenge here is with the middle name and last name as it depends on the number of words in the name. 
-- PS : Try to solve it without a split part function as that function is limited to a few databases. 

create table if not exists `customers` (
	full_name varchar(100),
	first_name varchar(50),
	middle_name varchar(50),
	last_name varchar(50)
) ;

insert into `customers` (full_name)
values
	('Ankit Bansal'),
	('Vishal Pratap Singh'),
	('Michael'),
	('A B C D') 
;

with cte1 as (
	select full_name,
		substring_index(full_name, ' ', 1) as first_name,
		trim(
				replace(
				replace(full_name, substring_index(full_name, ' ', -1), ''), 
				substring_index(full_name, ' ', 1),
				'')
			) as middle_name,
		substring_index(full_name, ' ', -1) as last_name
	from customers 
),
cte as (
	select full_name,
		first_name,
		middle_name,
		case 
			when full_name=last_name 
				then NULL 
				else last_name 
		end as last_name 
	from cte1
)
update customers c2
	join cte c1
		on c1.full_name=c2.full_name 
	set c2.first_name=c1.first_name,
		c2.middle_name=case when c1.middle_name='' then NULL else c1.middle_name end,
		c2.last_name=case when c1.last_name='' then NULL else c1.last_name end ;

select * 
from customers ;