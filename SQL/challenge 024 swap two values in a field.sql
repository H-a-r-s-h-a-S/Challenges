-- swap two values in a field

drop database if exists challenges ;
create schema challenges ;
use challenges ;

create table data (
	id int, 
	gender char(1)
) ;

insert into data values 
(1,'m'), (2,'m'),(3,'f'),(4,'f'), (5,'u') ;

DROP PROCEDURE IF EXISTS swap_values ;

DELIMITER $$ 
CREATE PROCEDURE `swap_values` (`table` varchar(30), field varchar(20), value1 varchar(100), value2 varchar(100))
BEGIN

set @temp = '|';
set @query1 = (select concat('update ', `table`, ' set ', field, ' = ''', @temp, ''' where ', field, ' = ''', value1, ''';') ) ; 
set @query2 = (select concat('update ', `table`, ' set ', field, ' = ''', value1, ''' where ', field, ' = ''', value2, ''';') ) ; 
set @query3 = (select concat('update ', `table`, ' set ', field, ' = ''', value2, ''' where ', field, ' = ''', @temp, ''';') ) ;

prepare stmt1 from @query1 ;
execute stmt1 ;
deallocate prepare stmt1 ;

prepare stmt2 from @query2 ;
execute stmt2 ;
deallocate prepare stmt2 ;

prepare stmt3 from @query3 ;
execute stmt3 ;
deallocate prepare stmt3 ;

END $$
DELIMITER ;

select * from data ;

call `swap_values`('data', 'gender', 'm', 'f') ;

select * from data ;

