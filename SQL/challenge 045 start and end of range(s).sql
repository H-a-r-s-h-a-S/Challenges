-- https://www.linkedin.com/posts/snehakulkarni01_sql-dataanalytics-linkedincommunity-ugcPost-7226264927835996160-8ZAK/?utm_source=share&utm_medium=member_ios

drop database if exists challenges ;
create schema challenges ;
use challenges ;

-- Find the start and end number of continuous ranges.

CREATE TABLE logs (log_id INT PRIMARY KEY);

INSERT INTO logs (log_id) VALUES (1), (2), (3), (7), (8), (10);

WITH cte AS (
    SELECT
        log_id,
        log_id - ROW_NUMBER() OVER(
        ORDER BY
            log_id
        ) AS rn
    FROM
        logs
)
SELECT
    min(log_id) AS range_start,
    max(log_id) AS range_end
FROM
    cte
GROUP BY
    rn ;
