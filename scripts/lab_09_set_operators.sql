-- Lab 9 - Using Set Operators
-- Task 1 - A list of department IDs that do not contain the job ID ST_CLERK
SELECT department_id FROM departments
MINUS
SELECT department_id FROM employees WHERE job_id = 'ST_CLERK';

-- Task 2 - A list of countries with no departments located in them.
select * from countries natural join locations
where location_id not in (select location_id from departments);

-- Task 3 - A list of all the employees who work in departments 50 and 80.
select employee_id, job_id, department_id 
from employees where department_id = 50
union
select employee_id, job_id, department_id
from employees where department_id = 80;

-- Task 4 - A report that list all employees who are sales representatives
-- and working in the sales department
select * from employees where job_id = 'SA_REP'
and department_id = (select department_id from departments where department_name = 'Sales');

-- Task 5 - The HR needs a report of all employees regardless wether they belong or not to a department
select last_name, d.department_id, department_name
from employees e left outer join departments d on (e.department_id = d.department_id);

