-- https://www.linkedin.com/posts/roshni-goswami-943a88181_top-interview-questions-and-answers-in-sql-activity-7153795883795460098-7jG9/?utm_source=share&utm_medium=member_ios

drop database if exists challenges ;
create schema challenges ;
use challenges ;

-- Find the number of new users and percentage of new users on each date.

create table user_data (
	user_id int,
	join_date date
);

INSERT into user_data(user_id, join_date)
values
	(111,'2023-01-01'),
	(222,'2023-01-01'),
	(111,'2023-01-03'),
	(333,'2023-01-07'),
	(333,'2023-01-08'),
	(333,'2023-01-09'),
	(444,'2023-01-09');

with cte as (
		select *,
		row_number() over(partition by user_id order by join_date) as rn
	from user_data
)
select join_date,
	sum(case when rn=1 then 1 else 0 end) as new_users,
	round(100 * sum(case when rn=1 then 1 else 0 end) / count(distinct user_id),2) as percentage_new_user
from cte
group by join_date ;
