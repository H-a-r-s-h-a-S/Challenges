-- https://www.linkedin.com/posts/ankitbansal6_sql-analytics-activity-7234404172127744000-edLt/?utm_source=share&utm_medium=member_ios
drop database if exists challenges ;
create schema challenges ;
use challenges ;

-- You are given the travel data for each customer in no particular order.
-- You need to find the start location and end location of the customer.

CREATE TABLE travel_data (
    customer VARCHAR(10),
    start_loc VARCHAR(50),
    end_loc VARCHAR(50)
);

INSERT INTO travel_data (customer, start_loc, end_loc) VALUES
     ('c1', 'New York', 'Lima'),
     ('c1', 'London', 'New York'),
     ('c1', 'Lima', 'Sao Paulo'),
     ('c1', 'Sao Paulo', 'New Delhi'),
     ('c2', 'Mumbai', 'Hyderabad'),
     ('c2', 'Surat', 'Pune'),
     ('c2', 'Hyderabad', 'Surat'),
     ('c3', 'Kochi', 'Kurnool'),
     ('c3', 'Lucknow', 'Agra'),
     ('c3', 'Agra', 'Jaipur'),
     ('c3', 'Jaipur', 'Kochi');

WITH `journey start` AS (
    SELECT customer, start_loc FROM travel_data
    EXCEPT
    SELECT customer, end_loc FROM travel_data
),
`journey end` AS (
    SELECT customer, end_loc FROM travel_data
    EXCEPT
    SELECT customer, start_loc FROM travel_data
),
`journey` AS (
    SELECT s.customer,
        s.start_loc AS source,
        e.end_loc AS destination
    FROM `journey start` s
        INNER JOIN `journey end` e
            ON s.customer = e.customer
)
SELECT j.customer,
    j.source,
    j.destination,
    count(*) +1 AS `cities visited`
FROM journey j
    JOIN travel_data t
        ON j.customer = t.customer 
GROUP BY j.customer,
    j.source,
    j.destination ;