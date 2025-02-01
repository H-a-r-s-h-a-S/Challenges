drop database if exists challenges ;
create schema challenges ;
use challenges ;

-- write a query to generate time series report for sales data, filling in missing dates with zero sales.

CREATE TABLE sales (
    sale_id INT AUTO_INCREMENT PRIMARY KEY,
    sale_date DATE NOT NULL,
    sale_amount DECIMAL(10, 2) NOT NULL
);

INSERT INTO sales (sale_date, sale_amount) VALUES
('2025-02-01', 100.00),
('2025-02-03', 150.00),
('2025-02-04', 200.00),
('2025-02-06', 250.00);

SELECT min(sale_date) INTO @sale_start FROM sales ;
SELECT max(sale_date) INTO @sale_end FROM sales ;

WITH RECURSIVE date_range AS (
    SELECT @sale_start AS sale_date
    UNION ALL
    SELECT DATE_ADD(sale_date, INTERVAL 1 DAY)
    FROM date_range
    WHERE sale_date < @sale_end
)
SELECT
    dr.sale_date,
    COALESCE(SUM(s.sale_amount), 0) AS total_sales
FROM date_range dr
LEFT JOIN sales s ON dr.sale_date = s.sale_date
GROUP BY dr.sale_date
ORDER BY dr.sale_date;
