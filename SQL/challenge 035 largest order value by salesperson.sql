-- https://www.linkedin.com/posts/bikash-deb_withoutcte-activity-7150716587849719809-czZ0/?utm_source=share&utm_medium=member_ios

drop database if exists challenges ;
create schema challenges ;
use challenges ;

-- Create a table and find the largest order by value for each salesperson
-- 𝐰𝐢𝐭𝐡𝐨𝐮𝐭 𝐮𝐬𝐢𝐧𝐠 𝐬𝐮𝐛-𝐪𝐮𝐞𝐫𝐢𝐞𝐬, 𝐂𝐓𝐄𝐬, 𝐰𝐢𝐧𝐝𝐨𝐰 𝐟𝐮𝐧𝐜𝐭𝐢𝐨𝐧𝐬, 𝐨𝐫 𝐭𝐞𝐦𝐩 𝐭𝐚𝐛𝐥𝐞𝐬.

CREATE TABLE int_orders (
	order_number INT NOT NULL,
	order_date DATE NOT NULL,
	cust_id INT NOT NULL,
	salesperson_id INT NOT NULL,
	amount FLOAT NOT NULL
);

INSERT INTO int_orders (order_number, order_date, cust_id, salesperson_id, amount)
VALUES
	(30, '1995-07-14', 9, 1, 460),
	(10, '1996-08-02', 4, 2, 540),
	(40, '1998-01-29', 7, 2, 2400),
	(50, '1998-02-03', 6, 7, 600),
	(60, '1998-03-02', 6, 7, 720),
	(70, '1998-05-06', 9, 7, 150),
	(20, '1999-01-30', 4, 8, 1800) ;

select salesperson_id,
	max(amount) as max_amount
from int_orders
group by salesperson_id ;

select a.*
from int_orders a 
	left join int_orders b
		on a.salesperson_id = b.salesperson_id
			and a.amount < b.amount 
where b.salesperson_id is null ;
