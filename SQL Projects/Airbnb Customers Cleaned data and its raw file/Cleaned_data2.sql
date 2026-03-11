Select * 
from lore.customer_orders;

Select *
from lore.customer_orders1;

Alter table customer_orders1
Modify Column quantity int;

-- Create a duplicate tables for old data to always reference 

Create table customer_orders1
Like customer_orders;

Insert into customer_orders1
Select *
from customer_orders;

-- 1. Standardaize the order_status	

Select *,
CASE
		When Lower(order_status) Like '%deliver%' THEN 'Delivered'
        When Lower(order_status) Like '%ship%' THEN 'Shipped'
        When Lower(order_status) Like '%refund%' THEN 'Refund'
        When Lower(order_status) Like '%pending%' THEN 'Pending'
        When Lower(order_status) Like '%return%' THEN 'Returned'
			Else 'other' 
END as Neat_order_status

from lore.customer_orders1;

-- Standardize the quantity

Select *,
CASE
		When lower(quantity) = 'two' THEN 2
        else cast(quantity as float)
END as Neat_quantity
from lore.customer_orders1;

-- Standardize product_name

Select *,
CASE
		When Lower(product_name) Like '%apple watch%' THEN 'Apple Watch'
        When Lower(product_name) Like '%Samsung Galaxy S22%' THEN 'Samsung Galaxy S22'
        When Lower(product_name) Like '%google pixel%' THEN 'Google Pixel'
        When Lower(product_name) Like '%iphone 14%' THEN 'iphone 14'
        When Lower(product_name) Like '%Macbook pro%' THEN 'Macbook Pro'
		Else 'other'
END as Neat_product_name

from lore.customer_orders1
  Where product_name is not null;
  
  -- Cleaning customer_name
  
UPDATE lore.customer_orders1
SET customer_name = 'Jessica'
WHERE customer_name IS NULL
  AND email = 'jessica@abc.com';

  
  -- Removing the duplicate values using windows functions
  
Select * 
from (
	Select *,
	row_number () over (partition by lower(email), lower(product_name)
    order by order_id ASC) as rownumber
    from lore.customer_orders1
    ) as cl
where rownumber = 1 and product_name is not null;

-- formatting the price
SELECT price,
		CASE
           WHEN price IS NULL OR TRIM(price) = '' THEN 0.00
           ELSE CAST(
               REPLACE(REPLACE(TRIM(price), '$', ''), ',', '')
               AS DECIMAL(10,2))
       END AS clean_price
       
FROM lore.customer_orders1;


-- Formatting the dates

-- Select order_date,
-- str_to_date(order_date, '%Y-%m-%d') as proper_order_date
-- from lore.customer_orders1;

Select order_date,
replace (replace(order_date, '11/02/2023', '2023-02-11'), '2023/10/30', '2023-10-30') as new_order_date
from lore.customer_orders1;

SELECT *, email
FROM customer_orders1
WHERE email IS NULL
   OR email = ''
   OR email NOT LIKE '%@%.%';
   
UPDATE customer_orders1
SET email = REPLACE(email, '@@', '@')
WHERE email LIKE '%@@%';

UPDATE customer_orders1
SET email = CONCAT(email, '.com')
WHERE email LIKE '%@outlook'
   OR email LIKE '%@gmail'
   OR email LIKE '%@yahoo';
   
UPDATE customer_orders1
SET email = NULL
WHERE email NOT REGEXP '^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$';

UPDATE customer_orders1
SET email = TRIM(BOTH FROM email);

Select coalesce (email, 'Unknown')
from lore.customer_orders1;

UPDATE lore.customer_orders1
SET email = 'tom.obrien@gmail.com'
WHERE email IS NULL
  AND customer_name Like '%TOM o''BRIEN%';
  
  Select *
  from lore.customer_orders1;
  
-- adding all the clean data by creating a CTE

WITH Cleaned_customer_orders AS(

Select DISTINCT order_id, UPPER(customer_name) as cleaned_customer_name,

COALESCE(
    CASE
        WHEN email IS NULL OR TRIM(email) = '' THEN NULL

        ELSE
            LOWER(
                REPLACE(
                    CASE
                        WHEN LOWER(TRIM(email)) LIKE '%@gmail'   THEN CONCAT(TRIM(email), '.com')
                        WHEN LOWER(TRIM(email)) LIKE '%@yahoo'   THEN CONCAT(TRIM(email), '.com')
                        WHEN LOWER(TRIM(email)) LIKE '%@outlook' THEN CONCAT(TRIM(email), '.com')
                        ELSE TRIM(email)
                    END,
                '@@', '@')
            )
    END,
'Unknown') AS clean_email,
            
CASE
		When Lower(product_name) Like '%apple watch%' THEN 'Apple Watch'
        When Lower(product_name) Like '%Samsung Galaxy S22%' THEN 'Samsung Galaxy S22'
        When Lower(product_name) Like '%google pixel%' THEN 'Google Pixel'
        When Lower(product_name) Like '%iphone 14%' THEN 'iphone 14'
        When Lower(product_name) Like '%Macbook pro%' THEN 'Macbook Pro'
		Else 'other'
END as Neat_product_name,

CASE
		When Lower(order_status) Like '%deliver%' THEN 'Delivered'
        When Lower(order_status) Like '%ship%' THEN 'Shipped'
        When Lower(order_status) Like '%refund%' THEN 'Refund'
        When Lower(order_status) Like '%pending%' THEN 'Pending'
        When Lower(order_status) Like '%return%' THEN 'Returned'
			Else 'other' 
END as Neat_order_status,

STR_TO_DATE(
			replace(
						replace(order_date, '11/02/2023', '2023-02-11'), 
			'2023/10/30', '2023-10-30'),
'%Y-%m-%d') as proper_order_date,

CASE
        WHEN LOWER(TRIM(country)) IN ('usa', 'us', 'united states', 'united states of america') THEN 'United States'
        WHEN LOWER(TRIM(country)) IN ('uk', 'u.k.', 'united kingdom', 'england') THEN 'United Kingdom'
        WHEN LOWER(TRIM(country)) IN ('canada', 'ca') THEN 'Canada'
        WHEN LOWER(TRIM(country)) IN ('india', 'in') THEN 'India'
        WHEN LOWER(TRIM(country)) IN ('spain', 'es') THEN 'Spain'
ELSE 'Other'
    END AS clean_country,
    
    CASE
           WHEN price IS NULL OR TRIM(price) = '' THEN 0.00
           ELSE CAST(
               REPLACE(REPLACE(TRIM(price), '$', ''), ',', '')
               AS DECIMAL(10,2))
       END AS clean_price,
            
            row_number () over (partition by lower(email), lower(product_name)
				order by order_id asc) as row_num
    FROM lore.customer_orders1
)

SELECT *
FROM cleaned_customer_orders
WHERE row_num = 1
order by order_id ASC;

Select *
from customer_orders1;
