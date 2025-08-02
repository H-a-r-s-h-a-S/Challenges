drop database if exists challenges ;
create schema challenges ;
use challenges ;

-- write a query to identify products that were never purchased together in the same transaction.

-- SET sql_mode = (SELECT REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY', ''));

create table sales (
    id int,
    product varchar(20),
    sale_date date
) ;

create table products (
    product varchar(20)
) ;

insert into products (product)
values ('prod1'), ('prod2'), ('prod3') ;

insert into sales (id, product, sale_date)
values (1, 'prod1', '2025-01-01') ,
    (2, 'prod2', '2025-01-01') ,
    (3, 'prod1', '2025-01-02') ,
    (4, 'prod2', '2025-01-02') ,
    (5, 'prod3', '2025-01-03') ,
    (6, 'prod2', '2025-01-03') ,
    (7, 'prod3', '2025-01-03') ;


SELECT distinct p1.product AS product_1,
    p2.product AS product_2
FROM products p1
    JOIN products p2
        ON p1.product < p2.product -- all possible combinations
    LEFT JOIN sales t1
        ON t1.product = p1.product
    LEFT JOIN sales t2
        ON t2.product = p2.product
WHERE NOT EXISTS (
    SELECT 1
    FROM sales tr1
        JOIN sales tr2 
            ON tr1.sale_date = tr2.sale_date
    WHERE tr1.product = p1.product AND
        tr2.product = p2.product -- all combinations present
) ;
