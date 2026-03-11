-- SUBQUERIES -- query inside query 
-- this is subquery within where statement

Select * 
from employee_demographics
  where employee_id IN 	
	(Select employee_id
		from employee_salary
         Where dept_id = 1);
		
-- Subquery within SELECT statement

Select first_name, salary, 
(Select avg (salary) as avg_salary
from employee_salary)
from employee_salary;

-- Subquery within FROM statement here always need alias

Select gender, avg (max_age)
from
(Select gender, avg(age), min(age), max(age) as max_age, count(age)
from employee_demographics
group by gender) as agg_table
group by gender;

