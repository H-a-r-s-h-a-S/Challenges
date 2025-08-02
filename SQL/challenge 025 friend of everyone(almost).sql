-- https://www.linkedin.com/posts/aastha-jain-851ab3140_sqlchallenge-database-linkedinlearning-activity-7151483381338243072-Z3uN?utm_source=share&utm_medium=member_ios

drop database if exists challenges ;
create schema challenges ;
use challenges ;

-- find the user with the highest number of friends

create table `friendship` (
	requester_id int,
	accepter_id int,
	accept_date date
) ;

insert into friendship values
	(1,2,'2016-06-3'),
	(1,3,'2016-06-08'),
	(2,3,'2016-06-08'),
	(3,4,'2016-06-09') ;

with cte as (
	select requester_id, accepter_id from friendship
	union
	select accepter_id, requester_id from friendship
	),
cte1 as (select *, count(accepter_id) over(partition by requester_id) cnt from cte ),
cte2 as (select *, row_number() over(order by cnt desc) rn from cte1)
select requester_id user_id from cte2 where rn=1;
