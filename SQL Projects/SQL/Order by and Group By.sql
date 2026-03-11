-- Group by - used to group the same sort of data from multiple tables

Select * from parks_and_recreation.employee_salary;
Select * from parks_and_recreation.employee_demographics;

Select occupation, salary
from employee_salary, employee_demographics
Where salary > 50000
group by occupation, salary
Order by salary desc;

# different function used - max, avg, min, count and sum of values
select age, Max(age), avg (age), MIN(age), Count(Gender), sum(age) 
from parks_and_recreation.employee_demographics
group by age;


# Order by 
Select * from parks_and_recreation.employee_salary
Order by dept_id, salary;

Select * from parks_and_recreation.employee_demographics
Order by 5, 4 desc;

# default the table would be in ASC not in DESC




