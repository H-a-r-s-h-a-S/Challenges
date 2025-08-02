-- https://www.linkedin.com/posts/ankitbansal6_sql-zepto-interview-activity-7236938308503625728-LKPB/?utm_source=share&utm_medium=member_ios

-- MSSQL

drop table if exists #numbers ;
drop table if exists #cte ;

with cte as (
	select 1 as n union all
	select 2
	union all
	select 5
)
select n
into #numbers
from cte ;

select top 0 *
into #cte
from #numbers ;

declare @n int = 1 ;
declare @max int = (select MAX(n) from #numbers) ;

while @n <= @max
BEGIN
	insert into #cte
		select @n ;
	set @n = @n + 1 ;
END ;

select a.n
from #numbers a
	cross join #cte b
where a.n >= b.n
order by a.n ;
