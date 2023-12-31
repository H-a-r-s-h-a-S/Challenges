-- https://www.linkedin.com/posts/gauravowlcity_walmart-sql-interview-activity-7136976684280385536-AFUe?utm_source=share&utm_medium=member_ios

-- table - teams_info
-- columns - team_id, team_name
-- task - write a sql code to design teams of 2 to play for matches, every team should play with every other team

drop database if exists challenges ;
create schema challenges ;
use challenges ;

drop table if exists team_info ;
create table team_info (
	`team_id` int auto_increment,
	`team_name` varchar(50),
	primary key (`team_id`)
) ;

insert into team_info (team_name) values ('strikers'), ('enforcers'), ('kingmakers'), ('bandits'), ('bosses'), ('cowboys'), ('defenders'), ('dynamos');

select a.team_name, b.team_name, row_number() over(partition by a.team_id order by a.team_id, b.team_id) `round` from team_info a join team_info b on a.team_id < b.team_id order by 3 ;