-- https://www.linkedin.com/posts/ankitbansal6_sql-analytics-activity-7145619321916960768-ob-s?utm_source=share&utm_medium=member_ios

-- here is an interesting google interview question asked for a data analyst position.
-- write an sql query to get the individual words from all rows whose count is more than one from the content column. please refer to the image for a better idea.
-- we all have written a map reduce program to get the world count 😀. this time we need to do it using sql.

drop database if exists challenges ;
create schema challenges ;
use challenges ;

create table namaste_python (
	file_name varchar(25),
	content varchar(200)
);

insert into namaste_python values ('python bootcamp1.txt','python for data analytics 0 to hero bootcamp starting on jan 6th'), ('python bootcamp2.txt','classes will be held on weekends from 11am to 1 pm for 5-6 weeks'), ('python bootcamp3.txt','use code ny2024 to get 33 percent off. you can register from namaste sql website. link in pinned comment') ;

drop procedure if exists split_to_table ;

delimiter $$ 
create procedure split_to_table(str text)
begin
drop table if exists tmp ;
create temporary table tmp (`word` varchar(100) ) ;
set @s = replace(str,'|',' ') ;
set @tmp = '' ;
set @i = 1;
  loop1: loop
  	if @i+1 = length(@s) then
  		leave loop1 ;
  	end if ;
  	set @var = substring(@s,@i,1) ;
  	if @var = ' ' then
  		insert into tmp (word) values (ltrim(rtrim(@tmp))) ;
  		set @tmp = '' ;
  	end if ;
  	set @tmp = concat(@tmp, @var) ;
  	set @i = @i + 1 ;
 end loop loop1;
end $$
delimiter ;

set @contents = (select group_concat(content separator ' ') from namaste_python) ;

call split_to_table(@contents) ;

select word value, count(1) count_of_word from tmp group by word having count(1) > 1;
