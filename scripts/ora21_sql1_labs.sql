-- select * from countries;
-- select * from departments;
-- select * from employees;

-- select last_name, job_id, salary as sal from employees;
-- select * from job_grades;

select employee_id, last_name, (salary * 12) as annual_salary from employees;