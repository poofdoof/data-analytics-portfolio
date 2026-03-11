Select * from employee_demographics;

Select* from employee_salary;

-- Inner Joins - for joining tables with same values 
Select * 
from parks_and_recreation.employee_demographics as dem
Inner Join parks_and_recreation.employee_salary as sal
	ON dem.employee_id = sal.employee_id;
    
Select dem.employee_id, age, salary
from parks_and_recreation.employee_demographics as dem
Inner Join parks_and_recreation.employee_salary as sal
	ON dem.employee_id = sal.employee_id
    having salary > 30000;
    
    -- Left Joins for all the data from left table and common data from right table
Select *
from parks_and_recreation.employee_demographics as dem
Left Join parks_and_recreation.employee_salary as sal
	ON dem.employee_id = sal.employee_id;
    
    -- right Joins for all the data from right table and common data from left table
Select *
from parks_and_recreation.employee_demographics as dem
Right Join parks_and_recreation.employee_salary as sal
	ON dem.employee_id = sal.employee_id;
    
    -- Self Joins when a table is joined with itself.
Select *
from parks_and_recreation.employee_salary as emp1
join parks_and_recreation.employee_salary as emp2
ON emp1.employee_id + 1  = emp2.employee_id;

Select emp1.employee_id as emp_santa, 
emp1.first_name as first_name_santa,
emp1.last_name as last_name_santa,
emp2.employee_id as emp, 
emp2.first_name as first_name,
emp2.last_name as last_name
from parks_and_recreation.employee_salary as emp1
join parks_and_recreation.employee_salary as emp2
ON emp1.employee_id + 1  = emp2.employee_id;

-- Joining multiple tables with Inner Joins with same values 
Select * 
from parks_and_recreation.employee_demographics as dem
Inner Join parks_and_recreation.employee_salary as sal
	ON dem.employee_id = sal.employee_id
    Inner Join parks_and_recreation.parks_departments as pd
    ON sal.dept_id = pd.department_id;
    
select *
from parks_and_recreation.parks_departments;

-- Cross Joins

SELECT column_list
FROM table1
CROSS JOIN table2;
column_list can be * (all columns) or specific columns.
No ON condition is used (unlike INNER JOIN or LEFT JOIN).

Example
Suppose we have:

Table: Products
ProductID	ProductName
1	Pen
2	Notebook

Table: Colors
ColorID	ColorName
1	Red
2	Blue
3	Green

Query:
Sql
SELECT Products.ProductName, Colors.ColorName
FROM Products
CROSS JOIN Colors;

-- ProductName	ColorName 
-- Pen				Red
-- Pen				Blue
-- Pen				Green
-- Notebook			Red
-- Notebook			Blue
-- Notebook			Green --

