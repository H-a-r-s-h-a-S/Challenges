-- https://www.linkedin.com/posts/asim-manna31_sql-dataanalysis-database-activity-7209034538067329025-Tn5y/?utm_source=share&utm_medium=member_ios

drop database if exists challenges ;
create schema challenges ;
use challenges ;

-- Write a SQL query to find out the cancellation rate each day only by the unbanned clients and drivers.

Create table Trips (id int, client_id int, driver_id int, city_id int, status varchar(50), request_at varchar(50));
Create table Users (users_id int, banned varchar(50), role varchar(50));

insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('1', '1', '10', '1', 'completed', '2013-10-01');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('2', '2', '11', '1', 'cancelled_by_driver', '2013-10-01');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('3', '3', '12', '6', 'completed', '2013-10-01');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('4', '4', '13', '6', 'cancelled_by_client', '2013-10-01');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('5', '1', '10', '1', 'completed', '2013-10-02');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('6', '2', '11', '6', 'completed', '2013-10-02');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('7', '3', '12', '6', 'completed', '2013-10-02');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('8', '2', '12', '12', 'completed', '2013-10-03');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('9', '3', '10', '12', 'completed', '2013-10-03');
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('10', '4', '13', '12', 'cancelled_by_driver', '2013-10-03');

insert into Users (users_id, banned, role) values ('1', 'No', 'client');
insert into Users (users_id, banned, role) values ('2', 'Yes', 'client');
insert into Users (users_id, banned, role) values ('3', 'No', 'client');
insert into Users (users_id, banned, role) values ('4', 'No', 'client');
insert into Users (users_id, banned, role) values ('10', 'No', 'driver');
insert into Users (users_id, banned, role) values ('11', 'No', 'driver');
insert into Users (users_id, banned, role) values ('12', 'No', 'driver');
insert into Users (users_id, banned, role) values ('13', 'No', 'driver');

with unbanned as (
    select users_id,
        banned,
        role
    from Users
    where banned = 'No'
),
unbanned_client_trips as (
    select request_at,
        status,
        driver_id
    from trips t
    where exists (select 1 from unbanned u where u.users_id = t.client_id and u.role='client')
),
unbanned_driver_trips as (
    select request_at,
        status
    from unbanned_client_trips a
    where exists (select 1 from unbanned u where u.users_id = a.driver_id and u.role='driver')
),
data as (
        select request_at,
        count(*) as total_trips,
        sum(case when status<>'completed' then 1 else 0 end) as cancelled_trips
    from unbanned_driver_trips
    group by request_at
)
select request_at,
    total_trips,
    cancelled_trips,
    round((cancelled_trips*100.0)/total_trips,4) as cancel_percentage
from data 
order by request_at ;