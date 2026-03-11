# Strings functions

Select *
from parks_and_recreation.employee_demographics;

#length

Select first_name, length(first_name) as Char_Length
from parks_and_recreation.employee_demographics
Order by Char_Length ASC;

# Trim
Select first_name
from parks_and_recreation.employee_demographics;

Select LTRIM('   Leslie    ') AS trim; 


-- UPPER LOWER and Substring and  LEFT or RIGHT
Select first_name, UPPER(first_name) as Upper_Length, LOWER(first_name) as Lower_Length
from parks_and_recreation.employee_demographics;

Select first_name, LOWER(first_name) as Lower_Length
from parks_and_recreation.employee_demographics;

Select first_name, LEFT(first_name, 2)
from parks_and_recreation.employee_demographics;

Select first_name, RIGHT(first_name, 2)
from employee_demographics;

Select birth_date, SUBSTRING(birth_date, 6,2) as Birth_Month
from parks_and_recreation.employee_demographics;

-- REPLACE 
Select first_name, replace (first_name, 'L', 'C') nigga, replace (first_name, 'l', 'C') pigga;

-- LOCATE
Select first_name, locate('AN', first_name)
from parks_and_recreation.employee_demographics;

-- CONCATENATION
Select first_name, last_name, CONCAT(first_name,' ', last_name) AS Full_Name
from parks_and_recreation.employee_demographics;

 