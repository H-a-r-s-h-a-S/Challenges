use challenges ;

drop table if exists movie_seats ;

create table movie_seats (
	`seat_no` int AUTO_INCREMENT,
	`occupant_gender` char,
	primary key (`seat_no`)
) ;

insert into movie_seats (occupant_gender) values ('M'), ('M'), ('F'), ('M'), ('F'), ('F'), ('F'), ('M'), ('M'), ('M'), ('F'), ('M'), ('M') ;

-- 8, 9, 10
with three_seats as (
select 
	seat_no, 
	occupant_gender, 
	lag(occupant_gender) over(order by seat_no) previous_seat, 
	lead(occupant_gender) over(order by seat_no) next_seat 
from movie_seats) 
select
	seat_no-1 previous, 
	seat_no current, 
	seat_no+1 next, 
	occupant_gender 
from 
	three_seats 
where 
	occupant_gender=previous_seat and 
	occupant_gender=next_seat and 
	occupant_gender='M';