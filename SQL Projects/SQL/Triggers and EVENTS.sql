-- Triggers and Events

Select * 
from employee_demographics;

Select * 
from employee_salary;

-- Triggers -- Before is for triggring before deletion and AFTER is for adding or inserting data trigger create

Delimiter $$
Create Trigger emp_insert
	AFTER INSERT ON employee_salary
    FOR EACH ROW 
Begin
	Insert into employee_demographics (employee_id, first_name, last_name)
    Values (NEW.employee_id, NEW.first_name, NEW.last_name);
END $$

Delimiter ;

Insert into employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
Values (13, 'Doland', 'Trump', 'President', 2140000, NULL);

-- EVENTSS

Delimiter $$
Create Event Retirees
ON Schedule Every 1 Minute
Do
BEGIN
DELETE
from employee_demographics
where age >=60;
END $$
Delimiter ;
