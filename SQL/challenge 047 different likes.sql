-- https://www.linkedin.com/posts/snehakulkarni01_dataanalyst-sql-linkedincommunity-activity-7218255561383899136-JLeJ/?utm_source=share&utm_medium=member_ios

drop database if exists challenges ;
create schema challenges ;
use challenges ;

-- Problem Statement:
-- Determine the user ids and corresponding page_id of the pages liked by their friend but not user itself yet.

-- SQL Script:
CREATE TABLE friends (
    user_id INT,
    friend_id INT
) ;

-- Insert data into friends table
INSERT INTO friends VALUES
    (1, 2),
    (1, 3),
    (1, 4),
    (2, 1),
    (3, 1),
    (3, 4),
    (4, 1),
    (4, 3);

-- Create likes table
CREATE TABLE likes (
    user_id INT,
    page_id CHAR(1)
) ;

-- Insert data into likes table
INSERT INTO likes VALUES
    (1, 'A'),
    (1, 'B'),
    (1, 'C'),
    (2, 'A'),
    (3, 'B'),
    (3, 'C'),
    (4, 'B');


WITH cte AS ( 
    select f.user_id, l.user_id as friend_id, l.page_id from friends f join likes l on f.friend_id=l.user_id -- pages liked BY friends
    EXCEPT -- except
    select l.user_id, f.friend_id, l.page_id from friends f join likes l on f.user_id=l.user_id -- pages liked BY user
)
SELECT user_id,
    -- GROUP_CONCAT(concat(friend_id, ' has liked ', page_id) SEPARATOR '\n') AS `pages liked by friends`, -- verbose
    group_concat(DISTINCT page_id SEPARATOR ', ') AS `pages user has not liked but their friends have`
FROM cte
GROUP BY user_id ;

