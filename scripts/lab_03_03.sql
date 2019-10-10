select last_name, salary from employees where salary < 5000 or salary > 12000;

-- Matos and Taylor report
select last_name, job_id, hire_date from employees
where last_name in ('Matos', 'Taylor') order by hire_date;

-- Employees in departments 20 or 50
select last_name, department_id from employees
where department_id in (20, 50) order by last_name;

-- All employees hired in 2006
select last_name, hire_date from employees
where hire_date like '%06';

-- Employees with no manager
select last_name, job_id from employees where manager_id is null;

-- Employees who earn comissions
select last_name, salary, commission_pct 
from employees
where commission_pct is not null
order by salary desc;
