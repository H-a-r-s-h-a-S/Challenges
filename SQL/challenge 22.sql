-- https://www.linkedin.com/posts/vishalsahu05_sql-interview-leetcode-activity-7151218739865079808-N5Uu?utm_source=share&utm_medium=member_ios

drop database if exists challenges ;
create schema challenges ;
use challenges ;


-- Table: Weather
-- +---------------+---------+
-- | ColumnName | Type |
-- +---------------+---------+
-- | id | int |
-- | recordDate | date |
-- | temperature | int |
-- +---------------+---------+
-- id is the column with unique values for this table.
-- This table contains information about the temperature on a certain day.
 
-- Write a solution to find all dates' IDs with higher temperatures compared to their previous dates (yesterday).

-- The result format is in the following example.
 
-- Example 1:
-- Input:
-- Weather table:
-- +----+------------+-------------+
-- | id | recordDate | temperature |
-- +----+------------+-------------+
-- | 1 | 2015-01-01 | 10 |
-- | 2 | 2015-01-02 | 25 |
-- | 3 | 2015-01-03 | 20 |
-- | 4 | 2015-01-04 | 30 |
-- +----+------------+-------------+
-- Output:
-- +----+
-- | id |
-- +----+
-- | 2 |
-- | 4 |
-- +----+
-- Explanation:
-- In 2015-01-02, the temperature was higher than the previous day (10 -> 25).
-- In 2015-01-04, the temperature was higher than the previous day (20 -> 30).

-- Comment down your answers below. To make it interesting, 
-- try this without the window/join function, 
-- or see if you can come up with the simplest solution. 

create table weather (
	id int,
	recorddate date,
	temperature int
) ;

insert into weather values 
	(1,'2015-01-01',10), 
	(2,'2015-01-02',25), 
	(3,'2015-01-03',20), 
	(4,'2015-01-04',30) ;

select w2.*, w1.temperature as `previous day temperature` from weather w1 
join weather w2 on w1.temperature < w2.temperature and 
date_add(w1.recorddate, interval 1 day) = w2.recorddate ;
