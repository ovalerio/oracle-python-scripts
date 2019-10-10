-- Additional exercises lesson 3
-- Last maes of employees where the third letter is "a"
select last_name from employees where last_name like '__a%';

-- All employees with 'a' and 'e' in their last name
select last_name from employees where instr(last_name, 'a')>0 and instr(last_name, 'e')>0;

-- Look out for upper case letter in employee names
select last_name from employees where instr(lower(last_name), 'g') > 0;

-- Case insensitive 'a' and 'e' employees 
select last_name from employees where instr(lower(last_name), 'a')>0 and instr(lower(last_name), 'e')>0;

-- Employees whose jobs not sales representative or a stock clerk
select last_name, job_id, salary from employees
where job_id in ('SA_REP', 'ST_CLERK')
and salary not in (2500, 3500, 7000)
order by last_name;