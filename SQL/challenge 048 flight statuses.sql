-- https://www.linkedin.com/posts/viswanadh-gandimenu_sql-sqlserver-tsql-activity-7217851828388970497-C90D/?utm_source=share&utm_medium=member_ios

drop database if exists challenges ;
create schema challenges ;
use challenges ;

-- Find the status of flight tickets

Create table if not exists flights(flight_id int,capacity int) ;
Create table if not exists passengers (passenger_id int,flight_id int,booking_time datetime) ;

Truncate table flights ;
insert into flights (flight_id, capacity) values ('1', '2') ;
insert into flights (flight_id, capacity) values ('2', '2') ;
insert into flights (flight_id, capacity) values ('3', '1') ;

Truncate table passengers ;
insert into passengers (passenger_id, flight_id, booking_time) values ('101', '1', '2023-07-10 16:30:00') ;
insert into passengers (passenger_id, flight_id, booking_time) values ('102', '1', '2023-07-10 17:45:00') ;
insert into passengers (passenger_id, flight_id, booking_time) values ('103', '1', '2023-07-10 12:00:00') ;
insert into passengers (passenger_id, flight_id, booking_time) values ('104', '2', '2023-07-05 13:23:00') ;
insert into passengers (passenger_id, flight_id, booking_time) values ('105', '2', '2023-07-05 09:00:00') ;
insert into passengers (passenger_id, flight_id, booking_time) values ('106', '3', '2023-07-08 11:10:00') ;
insert into passengers (passenger_id, flight_id, booking_time) values ('107', '3', '2023-07-08 09:10:00') ;

WITH cte AS (
    SELECT f.flight_id,
        f.capacity,
        p.passenger_id,
        p.booking_time,
        row_number() over(PARTITION BY f.flight_id ORDER BY p.booking_time) AS rn
    FROM flights f 
        JOIN passengers p 
            ON f.flight_id = p.flight_id 
)
SELECT -- passenger_id,
    *,
    CASE WHEN rn <= capacity THEN 'Confirmed' ELSE 'Waitlist' END AS `Ticket status`
FROM cte
ORDER BY flight_id,
    booking_time ;

