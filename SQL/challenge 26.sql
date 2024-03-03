-- https://www.linkedin.com/posts/mohammad-tanweer-khan-6ba27953_sql-sqltraining-dataanalytics-activity-7151562559261700096-6iCX?utm_source=share&utm_medium=member_ios

drop database if exists challenges ;
create schema challenges ;
use challenges ;

-- Write a SQL query to display the employee names who are earning salary more than their manager's salary.

CREATE TABLE Employees (
  EMPID INT PRIMARY KEY,
  EMPNAME VARCHAR(255),
  SALARY DECIMAL(10, 2),
  MGRID INT
);

INSERT INTO Employees VALUES
  (1, 'Tom', 200, 5), 
  (2, 'John', 650, 4), 
  (3, 'Sara', 500, 6), 
  (4, 'Michael', 600, 7), 
  (5, 'Abdul', 400, 8) ;

select
  e.EMPID emp_id, e.EMPNAME emp_name, e.SALARY emp_salary,
  m.EMPID mgr_id, m.EMPNAME mgr_name, m.salary mgr_salary
from Employees e join Employees m on e.EMPID=m.MGRID and e.SALARY > m.SALARY ;
