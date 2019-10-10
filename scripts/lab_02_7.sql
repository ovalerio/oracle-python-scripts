select employee_id as "Emp #", last_name as "Employee", job_id as "Job", to_char(hire_date, 'DD-MON-YY') as "Hire Date" 
from employees;