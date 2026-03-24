-- Case Statements can be used with when not where

Select first_name, last_name, age,
CASE
when age < 40 THEN 'Young'
when age between 41 and 50 then 'old'
END as Age
from employee_demographics;

Select first_name, last_name, salary,
CASE
WHEN salary < 50000 THEN salary * 1.05
WHEN salary > 50000 THEN salary * 1.07
WHEN salary = 50000 THEN salary + (Salary * 1)
END as NEW_Salary
from employee_salary;