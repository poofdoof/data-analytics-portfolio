-- Stored Procedures

CREATE PROCEDURE large_salaries ()
Select * 
from parks_and_recreation.employee_salary
where salary >= 50000;

CALL large_salaries ();

-- Using delimeter (// or $$) for using multiple queries in stored_procedures

Delimiter $$
CREATE PROCEDURE large_salaries3 ()
Begin
	Select * 
	from parks_and_recreation.employee_salary
	where salary >= 50000;
	Select *
	from parks_and_recreation.employee_salary
	where salary >= 10000;
END $$
Delimiter ;

Call large_salaries3;

-- Passing parameters just like passing values in a function

Delimiter $$
CREATE PROCEDURE large_salaries4 (Parameter_employee_id INT)
Begin
	Select * 
	from parks_and_recreation.employee_salary
	where employee_id = Parameter_employee_id;
END $$
Delimiter ;

Call large_salaries4 (1);