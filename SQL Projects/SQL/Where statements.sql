select * 
from parks_and_recreation.employee_salary
WHERE salary > 50000;

Select distinct salary, first_name, last_name
from parks_and_recreation.employee_salary
where salary >= 50000;

# AND OR NOT (!=)

Select *
from parks_and_recreation.employee_demographics
where gender != 'Male';

Select * from parks_and_recreation.employee_demographics
Where (age = 44 and first_name = 'leslie') OR gender = 'female';

# LIKE, Between and In Statements
# _ - precise and % = anything

Select * from parks_and_recreation.employee_demographics
Where first_name LIKE 'a___%';

Select * from parks_and_recreation.employee_demographics
where age between 40 and 57;

Select * from parks_and_recreation.employee_demographics
Where birth_date IN ('1977-07-30');

# Wildcard Characters
# Symbol	Description
# " % "	Represents zero or more characters
# _	Represents a single character
# []	Represents any single character within the brackets *
-- ^	Represents any character not in the brackets *
 #  -	Represents any single character within the specified range *
-- {}	Represents any escaped character **"



