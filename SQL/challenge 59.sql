drop database if exists challenges ;
create schema challenges ;
use challenges ;

-- write a query to get users who logged in consecutively 4 days (users can login multiple times a day)

create table login_data (
	user_id int,
	login_date date
) ;

insert into login_data (user_id, login_date)
values (1, '2025-01-04'), (1, '2025-01-05'), (1, '2025-01-06'), (1, '2025-01-06'), (1, '2025-01-07'), (2, '2025-01-05'), (2, '2025-01-06'), (3, '2025-01-07') ;


with cte as (select *, dense_rank() over(partition by user_id order by login_date) as rnk from login_data)
select distinct user_id from cte where rnk=4 ; -- rnk >= 4 
