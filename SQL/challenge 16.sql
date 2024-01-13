-- https://www.linkedin.com/posts/nitish2308_sql-sqlqueries-dataanalyst-activity-7148700839631654913--y86?utm_source=share&utm_medium=member_ios

drop database if exists challenges ;
create schema challenges ;
use challenges ;

-- Write a query to identify employees who have been with the company for at least 2 years & 
-- their performance rating must be in the top 20% within their department.

CREATE TABLE employee_performance (
  employee_id INT PRIMARY KEY,
  performance_rating INT,
  department VARCHAR(255),
  tenure INT
) ;


INSERT INTO employee_performance (employee_id, performance_rating, department, tenure) VALUES 
	(101, 85, 'Engineering', 3),
	(102, 90, 'Engineering', 4),
	(103, 75, 'Marketing', 2),
	(104, 88, 'Marketing', 3),
	(105, 82, 'Sales', 4),
	(106, 70, 'Sales', 3),
	(107, 78,'Sales',2 ),
	(108 ,91 ,'Engineering' ,4) ;

with cte as (select *, percent_rank() over(partition by department order by performance_rating desc) rating
from employee_performance 
where tenure >= 2 )
select employee_id, performance_rating, department, tenure from cte where rating <= 0.2 ;
