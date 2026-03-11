-- Windows function in SQL

Select gender, avg (salary) as avg_salary
from employee_demographics as dem
join employee_salary as sal
ON dem.employee_id = sal.employee_id
group by gender;

Select dem.first_name, dem.last_name, gender, avg (salary) as avg_salary
from employee_demographics as dem
join employee_salary as sal
ON dem.employee_id = sal.employee_id
group by dem.first_name, dem.last_name, gender;

Select dem.first_name, dem.last_name, gender,
AVG(salary) OVER (partition by gender) 
from employee_demographics as dem 
join employee_salary as sal
ON dem.employee_id = sal.employee_id;

-- Rolling total function

Select dem.first_name, dem.last_name, gender, salary,
SUM(salary) OVER (partition by gender ORDER BY dem.employee_id)
from parks_and_recreation.employee_demographics as dem 
join parks_and_recreation.employee_salary as sal
ON dem.employee_id = sal.employee_id;

-- ROW_NUMBER , RANK and DENSE_RANK
Select dem.first_name, dem.last_name, gender, salary, dem.employee_id,
ROW_Number() OVER (partition by gender ORDER BY Salary DESC) as Row_num,
RANK() OVER (partition by gender ORDER BY Salary DESC) as Rank_num,
DENSE_RANK() OVER (partition by gender ORDER BY Salary DESC) as Rank_num
from employee_demographics as dem 
join employee_salary as sal
ON dem.employee_id = sal.employee_id;
