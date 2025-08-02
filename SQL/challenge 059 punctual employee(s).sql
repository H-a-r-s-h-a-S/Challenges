drop database if exists challenges ;
create schema challenges ;
use challenges ;

-- write a query to get users who logged in consecutively 4 days (users can login multiple times a day)

create table login_data (
	user_id int,
	login_date date
) ;

insert into login_data (user_id, login_date)
values (1, '2025-01-04'), (1, '2025-01-05'), (1, '2025-01-06'), (1, '2025-01-06'), (1, '2025-01-07'), (2, '2025-01-05'), (2, '2025-01-06'), (3, '2025-01-07'),
	   (4, '2025-01-04'), (4,'2025-01-06'), (4, '2025-01-08'), (4, '2025-01-10'), (4, '2025-01-11'), (4, '2025-01-12'), (4, '2025-01-13'),
	   (5, '2025-01-14'), (5, '2025-01-15'), (5, '2025-01-16'), (5, '2025-01-17'), (5, '2025-01-18'), (5, '2025-01-18');


with cte as (
	SELECT distinct user_id,
		login_date,
		dense_rank() OVER (partition by user_id ORDER BY login_date) AS drnk
	FROM login_data
),
	cte2 as (
	select *,
		date_sub(login_date, interval drnk day) as adjusted_date
	from cte
),
cte3 as (
	select
		*,
		count(adjusted_date) over(partition by user_id, adjusted_date) as cnt
	from cte2
)
select user_id,
	login_date
from cte3
where cnt = 4 -- or cnt >= 4
order by user_id,
	login_date asc ;

