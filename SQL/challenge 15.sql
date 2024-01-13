-- https://www.linkedin.com/posts/milind-zuge_sql-iphone-dataset-case-study-ugcPost-7147083529108054016--Rb0?utm_source=share&utm_medium=member_ios

-- ❓Q1 : Write a query to get the users who have bought iphone first time and model is i-15 only.

-- ❓Q2 : Write a query to get users who have upgraded iphone from i-12 to i-15.

-- ❓Q3 : Write a query to get summary of users who have bought iphone first time and one who upgraded.

-- ❓Q4 : Write a query to get users who have bought all the iphone models [i-11, i-12, i-13, i-14, i-15].


drop database if exists challenges ;
create schema challenges ;
use challenges ;

create table iphone_fever (
	user_id int,
	iphone_model varchar(10)
) ;

insert into iphone_fever values 
	(1,'i-11'), 
	(1,'i-12'),
	(1,'i-13'), 
	(1,'i-14'),
	(1,'i-15'), 
	(2,'i-15'),
	(3,'i-12'), 
	(3,'i-15') ;

-- Q1
with tmp as (select *, row_number() over(partition by user_id order by iphone_model) rn from iphone_fever)
select user_id from tmp where rn=1 and iphone_model='i-15' ;

-- Q2
with tmp as (select *, row_number() over(partition by user_id order by iphone_model) rn from iphone_fever)
select
	t1.user_id
from
	tmp t1 join tmp t2 on 
		t1.user_id=t2.user_id and 
		t1.iphone_model='i-12' and 
		t2.iphone_model='i-15' and
		t1.rn+1=t2.rn ;

-- Q3
with tmp as (select *, row_number() over(partition by user_id order by iphone_model) rn from iphone_fever)
select user_id, case when count(distinct rn) = 1 then 'First time' else 'Upgrade' end as summary
from tmp 
group by user_id ;

-- Q4
with aggregate as (select user_id, group_concat(distinct iphone_model order by iphone_model separator '|') models from iphone_fever group by user_id)
select user_id from aggregate where models = 'i-11|i-12|i-13|i-14|i-15' ;
