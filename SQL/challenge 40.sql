-- https://www.linkedin.com/posts/dhirajgupta141_sql-pyspark-sql-activity-7154003357064404992-sX17/?utm_source=share&utm_medium=member_ios

drop database if exists challenges ;
create schema challenges ;
use challenges ;

-- Calculate the % Marks for each student. Each subject is of 100 marks. 
-- Create a result column by following the below condition

--     1. % Marks greater than or euqal to 70 then 'Distinction'
--     2. % Marks range between 60-69 then 'First Class'
--     3. % Marks range between 50-59 then 'Second Class'
--     4. % Marks range between 40-49 then 'Third Class'
--     5. % Marks Less than or equal to 39 then 'Fail'

create table student (
    student_id int ,
    name varchar(40)
) ;

create table marks (
    student_id int ,
    subject_name varchar(50) ,
    marks int
) ;

insert into student(student_id , name)
values
    (1,'Steve'),
    (2,'David'),
    (3,'Aryan') ;

insert into marks(student_id , subject_name, marks)
values 
    (1,'pyspark',90),
    (1,'sql',100),
    (2,'sql',70),
    (2,'pyspark',60),
    (3,'sql',60),
    (3,'pyspark',55) ;

with cte as (
    select s.student_id,
        s.name,
        round(avg(m.marks),2) as percentage
    from student s
        join marks m
            on s.student_id = m.student_id 
    group by s.student_id,
        s.name 
)
select *,
    case
        when percentage >= 70 then 'Distinction'
        when percentage between 60 and 69 then 'First Class'
        when percentage between 50 and 59 then 'Second Class'
        when percentage between 40 and 49 then 'Third Class'
        when percentage <= 39 then 'Fail'
    end as result
from cte ;
