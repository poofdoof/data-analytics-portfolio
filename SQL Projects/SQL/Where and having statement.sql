-- Where and having statement and LIKE 

-- Where is for the conditions where this or that
-- having for a specified value
-- LIKE is for something which is not full but still there

Select occupation, avg(salary)
from parks_and_recreation.employee_salary
Where occupation LIKE ('%manager%')
group by occupation
having avg(salary) > 60000
order by occupation DESC;