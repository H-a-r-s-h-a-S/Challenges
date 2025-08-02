-- https://www.linkedin.com/posts/moha%mad-tanweer-khan-6ba27953_sql-dataanalytics-dataanalyst-activity-7149635767852589056-0Xsj/?utm_source=share&utm_medium=member_ios

drop database if exists challenges ;
create schema challenges ;
use challenges ;

-- Write a SQL query to find the list of customers who have purchased for 3 or more consecutive days.

CREATE TABLE purchases (
	purchase_id INT,
	customer_id INT,
	purchase_date DATE
) ;

INSERT INTO purchases (purchase_id, customer_id, purchase_date) VALUES (1, 101, STR_TO_DATE('2024-01-01', '%Y-%m-%d'));
INSERT INTO purchases (purchase_id, customer_id, purchase_date) VALUES (2, 102, STR_TO_DATE('2024-01-02', '%Y-%m-%d'));
INSERT INTO purchases (purchase_id, customer_id, purchase_date) VALUES (3, 101, STR_TO_DATE('2024-01-02', '%Y-%m-%d'));
INSERT INTO purchases (purchase_id, customer_id, purchase_date) VALUES (4, 103, STR_TO_DATE('2024-01-03', '%Y-%m-%d'));
INSERT INTO purchases (purchase_id, customer_id, purchase_date) VALUES (5, 101, STR_TO_DATE('2024-01-03', '%Y-%m-%d'));
INSERT INTO purchases (purchase_id, customer_id, purchase_date) VALUES (6, 104, STR_TO_DATE('2024-01-04', '%Y-%m-%d'));
INSERT INTO purchases (purchase_id, customer_id, purchase_date) VALUES (7, 102, STR_TO_DATE('2024-01-04', '%Y-%m-%d'));
INSERT INTO purchases (purchase_id, customer_id, purchase_date) VALUES (8, 103, STR_TO_DATE('2024-01-05', '%Y-%m-%d'));
INSERT INTO purchases (purchase_id, customer_id, purchase_date) VALUES (9, 102, STR_TO_DATE('2024-01-05', '%Y-%m-%d'));
INSERT INTO purchases (purchase_id, customer_id, purchase_date) VALUES (10, 103, STR_TO_DATE('2024-01-06', '%Y-%m-%d'));
INSERT INTO purchases (purchase_id, customer_id, purchase_date) VALUES (11, 102, STR_TO_DATE('2024-01-06', '%Y-%m-%d'));
INSERT INTO purchases (purchase_id, customer_id, purchase_date) VALUES (12, 107, STR_TO_DATE('2024-01-07', '%Y-%m-%d'));

with cte as (
	select *,
		dense_rank() over(partition by customer_id order by purchase_date) as rnk
	from purchases
),
cte2 as (
select *,
	date_add(purchase_date, interval -rnk day) date
from cte )
select customer_id
from cte2
group by customer_id, date
having count(1) > 2 ;
