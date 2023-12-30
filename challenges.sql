use challenges ;

-- -----------------
-- challenges table
-- -----------------
drop table if exists `challenges` ;
create table `challenges` (
	`id` int AUTO_INCREMENT,
	`problem` text,
	`status` varchar(10) DEFAULT 'pending',
	primary key (`id`)
) ;

-- ----------------
-- solutions table
-- ----------------
drop table if exists `solutions` ;
create table `solutions` (
	`id` int,
	`solution` text
) ;

-- update challenge status
drop procedure if exists `update_status` ;

DELIMITER $$ 
CREATE PROCEDURE update_status()
BEGIN
	update challenges c set c.status='solved' where exists (select 1 from solutions s where c.id=s.id) ;
END $$
DELIMITER ;


-- challenges
insert into challenges (problem) values ('Table - Movie_Seats\nColumns - Seat_no, Occupant_gender\nTask - Design a SQL code to see if there are more than 3 consecutive males sitting together.') ;
insert into challenges (problem) values ('Table - Order_Fact\nColumns - Order_ID, Order_status (delivered, approved, cancelled, returned), Order_date\nTask - Write a sql query to Fetch month on month return rate') ;


-- solutions
insert into solutions (id, solution) values (1, "with three_seats as (select seat_no, occupant_gender, lag(occupant_gender) over(order by seat_no) previous_seat, lead(occupant_gender) over(order by seat_no) next_seat from movie_seats) select seat_no-1 previous, seat_no current, seat_no+1 next, occupant_gender from three_seats where occupant_gender=previous_seat and occupant_gender=next_seat and occupant_gender='M';") ;
insert into solutions (id, solution) values (2, "with temp as (select monthname(order_date) as month, 100 * sum(case when order_status = 'returned' then 1 else 0 end) / count(1) as return_rate, 100 * sum(case when order_status = 'delivered' then 1 else 0 end) / count(1) as deliver_rate, 100 * sum(case when order_status = 'approved' then 1 else 0 end) / count(1) as approved_rate, 100 * sum(case when order_status = 'cancelled' then 1 else 0 end) / count(1) as cancelled_rate from order_fact group by monthname(order_date) ) , highest_rate as (select *, greatest(return_rate, deliver_rate, approved_rate, cancelled_rate) as `highest rate` from temp ) , highest_status as (select *, case when `highest rate` = return_rate then 'returned' when `highest rate` = deliver_rate then 'delivered' when `highest rate` = approved_rate then 'approved' when `highest rate` = cancelled_rate then 'cancelled' else '' end as `highest status` from highest_rate ) , summary as ( select `highest status`, count(*) cnt from highest_status group by `highest status`) , visual as (select `highest status` order_status, (100.0 * cnt)/(select sum(cnt) from summary) rate from summary group by `highest status` ) select *, repeat('|',rate/5) tally from visual ;") ;


-- check status
call `update_status`() ;
select c.id, case when s.solution is null then 'Not yet solved' else 'Solved' end as solution from challenges c left join solutions s on c.id=s.id ;
