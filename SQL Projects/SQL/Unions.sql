# UNION always picks the distinct value not the all value and cant be used everywhere as it can produce bad unorganized data 
#UNION ALL is another function used for all data from different tables

select first_name, last_name, 'old man' as label
from employee_demographics
where age > 40 and gender = 'male'
Union
select first_name, last_name, 'old lady' as label 
from employee_demographics
where age > 40 and gender = 'female' 
Union
select first_name, last_name, 'High Paid Emp' as label 
from employee_salary
Where salary > 70000
order by first_name, last_name;