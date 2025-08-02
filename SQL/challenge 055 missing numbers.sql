drop database if exists challenges ;
create schema challenges ;
use challenges ;

-- Write a query to identify missing numbers of a sequence.

create table sequence 
(
    n int
) ;

insert into sequence values (1), (2), (3), (5), (6), (7), (9), (10) ;

WITH RECURSIVE numbers AS (
    SELECT 1 AS number
    UNION ALL
    SELECT number + 1
    FROM numbers
    WHERE number + 1 <= 10
)
SELECT n.number as `missing number(s)`
FROM numbers n
where not exists (select 1 from sequence s where s.n = n.number) ;
