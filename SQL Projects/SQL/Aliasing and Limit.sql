-- LIMIT is for setting a limit

Select * from parks_and_recreation.employee_salary
order by salary DESC
limit 1, 6;

-- Aliasing - AS is ALias

Select gender, avg(age) AS avg_age
from employee_demographics
group by gender
having avg_age > 40;
