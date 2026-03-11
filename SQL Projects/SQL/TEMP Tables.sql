-- Creating temporary tables part 1
DROP TABLE temp_table;
DROP TABLE tempp_table;

CREATE temporary table tempp_table
(
first_name varchar(50),
last_name varchar(50),
age int,
birth_date date
);

Insert into tempp_table (first_name, last_name, age, birth_date)
values ('Prajjwal', 'Raj', 24, '2001-07-16');

Select *
from tempp_table; 

-- Creating temp tables part 2--------------------------------------

Select *
from employee_salary;

CREATE temporary table salary_over_50k
Select *
from employee_salary
where salary > 50000;

Select *
from salary_over_50k;