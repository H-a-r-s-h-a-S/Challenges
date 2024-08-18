-- https://youtu.be/WM2jN1gOs_8?si=WvCxoWhck_8xPfpl

drop database if exists challenges ;
create schema challenges ;
use challenges ;

-- Find the most and least populated cities in each state

CREATE TABLE city_population (
    state VARCHAR(50),
    city VARCHAR(50),
    population INT
);

-- Insert the data
INSERT INTO city_population (state, city, population) VALUES ('haryana', 'ambala', 100);
INSERT INTO city_population (state, city, population) VALUES ('haryana', 'panipat', 200);
INSERT INTO city_population (state, city, population) VALUES ('haryana', 'gurgaon', 300);
INSERT INTO city_population (state, city, population) VALUES ('punjab', 'amritsar', 150);
INSERT INTO city_population (state, city, population) VALUES ('punjab', 'ludhiana', 400);
INSERT INTO city_population (state, city, population) VALUES ('punjab', 'jalandhar', 250);
INSERT INTO city_population (state, city, population) VALUES ('maharashtra', 'mumbai', 1000);
INSERT INTO city_population (state, city, population) VALUES ('maharashtra', 'pune', 600);
INSERT INTO city_population (state, city, population) VALUES ('maharashtra', 'nagpur', 300);
INSERT INTO city_population (state, city, population) VALUES ('karnataka', 'bangalore', 900);
INSERT INTO city_population (state, city, population) VALUES ('karnataka', 'mysore', 400);
INSERT INTO city_population (state, city, population) VALUES ('karnataka', 'mangalore', 200);

select *
from city_population
order by state,
    population ;


with cte as (
    select *,
        max(population) over(partition by state) as max_population,
        min(population) over(partition by state) as min_population
    from city_population
),
min_population as (
    select a.state,
        a.city,
        a.population
    from cte a
        join city_population b
            on a.state = b.state and
                a.city=b.city and
                a.min_population = b.population
),
max_population as (
    select a.state,
        a.city,
        a.population
    from cte a
        join city_population b
            on a.state = b.state and
                a.city = b.city and
                a.max_population = b.population
)
select mn.state,
    concat(mn.city, ' (', mn.population, ')') as `minimum population`,
    concat(mx.city, ' (', mx.population, ')') as `maximum population`
from min_population mn
    join max_population mx
        on mn.state=mx.state 
order by mn.state ;


