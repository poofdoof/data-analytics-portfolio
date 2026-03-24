-- CTEs aka common table expressions

-- CTE exmp
WITH CTE_Example (GENDER, Average_Salary, max_salary, Min_salary, Salary_count) AS 
(
Select Gender, avg(salary), MAX(salary) , MIN(salary) , COUNT(salary)
from employee_demographics as dem
join employee_salary as sal
 on dem.employee_id = sal.employee_id 
 group by gender, dem.first_name 
 order by gender
 )
 Select *
 from CTE_Example;
 
 -- subquery exmp
 Select avg (avg_sal)
from (
Select Gender, avg(salary) avg_sal, MAX(salary) max_sal, MIN(salary) min_sal, COUNT(salary) sal_count
from employee_demographics as dem
join employee_salary as sal
 on dem.employee_id = sal.employee_id
 group by gender, dem.first_name 
 order by gender
 ) exm_subquery;
 
 -- using CTE for tables
 
 WITH CTE_Example1 AS
(
Select Gender, employee_id, birth_date
from employee_demographics as dem
where birth_date > '1985-01-01'
 ),
 CTE_Example2 AS
 (
 Select employee_id, salary
 from employee_salary as sal
 where salary > 30000
 )
 Select *
 from CTE_Example1
 join CTE_Example2
 On CTE_Example1.employee_id = CTE_Example2.employee_id;