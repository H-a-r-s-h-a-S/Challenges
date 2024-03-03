-- https://www.linkedin.com/posts/milind-zuge_sqlchallenge-day15-dataanalytics-activity-7150132123851554817-aHbG?utm_source=share&utm_medium=member_ios

drop database if exists challenges ;
create schema challenges ;
use challenges ;

-- Challenge statement:
-- Write a query to find personid, name, number of friends, sum of marks of persons friends 
-- who have a total score greater than 100.


CREATE TABLE friend (
	PersonID int,
	FriendID int
);

create table person (
	PersonID int,
	Name varchar(25),
	Email varchar(25),
	Score int
);

insert into friend(PersonID,FriendID) values 
	(1, 2),(1, 3),(2, 1),(2, 3),
	(3, 5),(4, 2),(4, 3),(4, 5);


insert into person(PersonID,Name,Email,Score) values
	(1, 'Alice','alice2018@hotmail.com',88),
	(2, 'Bob', 'bob2018@hotmail.com',11),
	(3, 'Davis','davis2018@hotmail.com',27),
	(4, 'Tara', 'tara2018@hotmail.com',45),
	(5, 'John', 'john2018@hotmail.com',63) ;

with mapping as (
	select personid, friendid from friend 
	union
	select friendid, personid from friend),
final as (
	select
		m.personid,
		count(m.friendid) friends, 
		group_concat(m.friendid separator ', ') lst, 
		sum(score) friends_score 
	from 
		mapping m 
	join
		person p
			on 
		m.friendid = p.personid 
	group by
		m.personid 
	having
		friends_score > 100 )
select 
	f.personid, 
	p.name, 
	f.friends number_of_friends, 
	-- f.lst friends, 
	f.friends_score
from 
	final f 
join 
	person p 
		on 
	f.personid = p.personid ;
