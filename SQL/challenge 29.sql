-- https://www.linkedin.com/posts/dhirajgupta141_sql-pyspark-sql-activity-7152502178274762752-X96N/

drop database if exists challenges ;
create schema challenges ;
use challenges ;

-- 𝗖𝗵𝗮𝗹𝗹𝗲𝗻𝗴𝗲 : 𝔽𝕚𝕟𝕕 𝕥𝕙𝕖 𝕟𝕦𝕞𝕓𝕖𝕣 𝕠𝕗 𝕟𝕖𝕨 𝕦𝕤𝕖𝕣 𝕒𝕟𝕕 𝕡𝕖𝕣𝕔𝕖𝕟𝕥𝕒𝕘𝕖 𝕠𝕗 𝕟𝕖𝕨 𝕦𝕤𝕖𝕣 𝕠𝕟 𝕖𝕒𝕔𝕙 𝕕𝕒𝕪.

create table user_data (
	user_id int,
	join_date date
) ;

INSERT into user_data(user_id, join_date)
values (111,'2024-01-01'),
	(222,'2024-01-01'),
	(111,'2024-01-03'),
	(333,'2024-01-07'),
	(333,'2024-01-08'),
	(333,'2024-01-09'),
	(444,'2024-01-09') ;

with cte as (
	select user_id,
		join_date,
		row_number() over(partition by user_id order by join_date) rn
	from user_data 
),
new_users as (
	select user_id,
		join_date
	from cte
	where rn=1
)
select c.join_date,
	count(n.user_id) as new_users,
	(100 * count(n.user_id)) / count(c.user_id) as percentage_new_user
from cte c
	left join new_users n
		on c.user_id = n.user_id 
			and c.join_date = n.join_date
group by c.join_date ;