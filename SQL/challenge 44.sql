-- https://www.linkedin.com/posts/ankitbansal6_here-is-a-very-interesting-question-asked-activity-7215195055748263936-x5ik/

drop database if exists challenges ;
create schema challenges ;
use challenges ;

-- find three consecutive empty seats

CREATE TABLE cinema (
 seat_id INT PRIMARY KEY,
 free int
);

delete from cinema;

INSERT INTO cinema (seat_id, free) VALUES (1, 1);
INSERT INTO cinema (seat_id, free) VALUES (2, 0);
INSERT INTO cinema (seat_id, free) VALUES (3, 1);
INSERT INTO cinema (seat_id, free) VALUES (4, 1);
INSERT INTO cinema (seat_id, free) VALUES (5, 1);
INSERT INTO cinema (seat_id, free) VALUES (6, 0);
INSERT INTO cinema (seat_id, free) VALUES (7, 1);
INSERT INTO cinema (seat_id, free) VALUES (8, 1);
INSERT INTO cinema (seat_id, free) VALUES (9, 0);
INSERT INTO cinema (seat_id, free) VALUES (10, 1);
INSERT INTO cinema (seat_id, free) VALUES (11, 0);
INSERT INTO cinema (seat_id, free) VALUES (12, 1);
INSERT INTO cinema (seat_id, free) VALUES (13, 0);
INSERT INTO cinema (seat_id, free) VALUES (14, 1);
INSERT INTO cinema (seat_id, free) VALUES (15, 1);
INSERT INTO cinema (seat_id, free) VALUES (16, 0);
INSERT INTO cinema (seat_id, free) VALUES (17, 1);
INSERT INTO cinema (seat_id, free) VALUES (18, 1);
INSERT INTO cinema (seat_id, free) VALUES (19, 1);
INSERT INTO cinema (seat_id, free) VALUES (20, 1);

delimiter |
CREATE FUNCTION generate_consecutive_numbers(start int, end int) RETURNS TEXT DETERMINISTIC
BEGIN
  DECLARE res TEXT DEFAULT '';
  WHILE start < end DO
    SET res = CONCAT(res, start, ', ');
    SET start = start + 1;
  END WHILE;
  SET res = substr(res, 1, length(res)-2);
  RETURN res;
END|
delimiter ;

set @seats = 3;

with cte as (
    select seat_id,
        sum(free) over(order by seat_id ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) as free_consecutive_seats
    from cinema
),
required_seats as (
    select seat_id
    from cte
    where free_consecutive_seats = @seats
)
select generate_consecutive_numbers(seat_id-@seats+1, seat_id+1) as free_seats
from required_seats ;
