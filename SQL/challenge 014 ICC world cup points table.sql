-- https://www.linkedin.com/posts/milind-zuge_derive-point-tables-and-solution-activity-7148538905368195072-SyJJ?utm_source=share&utm_medium=member_ios

-- Challenge Statement: 
-- Calculate the points table which will have total matches played, matches won, matches losses, and draw matches.
-- You have given table icc_world_cup with columns team_1, team_2, and winner

drop database if exists challenges ;
create schema challenges ;
use challenges ;

create table icc_world_cup (
	Team_1 Varchar(20),
	Team_2 Varchar(20),
	Winner Varchar(20)
);

INSERT INTO icc_world_cup values
	('India','SL','India'),
	('SL','Aus','Aus'),
	('SA','Eng','Eng'),
	('Eng','NZ','NZ'),
	('Aus','India','India'),
	('Aus','India','Draw') ;

with countries as (select distinct team_1 country from icc_world_cup union select distinct team_2 from icc_world_cup)
select 
	c.country, 
	count(1) matches_played,
	sum(case when c.country=i.winner then 1 else 0 end) matches_won,
	sum(case when c.country<>i.winner and lower(i.winner)<>'draw' then 1 else 0 end) matches_lost,
	sum(case when lower(i.winner)='draw' then 1 else 0 end) matches_drew
from
	countries c join icc_world_cup i on c.country=i.team_1 or c.country=i.team_2 
group by 
	c.country ;
