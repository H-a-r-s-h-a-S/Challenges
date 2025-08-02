-- https://www.linkedin.com/posts/bikash-deb_movie-activity-7151818287155142658-S1g4/?utm_source=share&utm_medium=member_ios

drop database if exists challenges ;
create schema challenges ;
use challenges ;

-- We have a movie hall with 3 rows, each containing 10 seats. 
-- The task at hand is to write a SQL query that identifies 4 consecutive empty seats in the hall.

create table movie(
	seat varchar(50),
	occupancy int
) ;

insert into movie
values ('a1',1), ('a2',1), ('a3',0), ('a4',0), ('a5',0), ('a6',0), ('a7',1), ('a8',1), ('a9',0), ('a10',0), 
	('b1',0), ('b2',0), ('b3',0), ('b4',1), ('b5',1), ('b6',1), ('b7',1), ('b8',0), ('b9',0), ('b10',0),
	('c1',0), ('c2',1), ('c3',0), ('c4',1), ('c5',1), ('c6',0), ('c7',1), ('c8',0), ('c9',0), ('c10',1) ;

with cte as (
	select *,
		left(seat,1) as row_id,
		convert(right(seat,length(seat)-1), signed) as seat_id
	from movie 
),
cte2 as (
		select *,
		sum(occupancy) over(partition by row_id order by row_id, seat_id rows between 3 preceding and current row) as cnt
	from cte
),
cte3 as (
		select row_id,
		seat_id
	from cte2
	where seat_id > 3
		and cnt = 0 
)
select c1.seat
from cte3 c3
	join cte c1
		on c1.row_id = c3.row_id
			and c1.seat_id between c3.seat_id - 3 and c3.seat_id ;
