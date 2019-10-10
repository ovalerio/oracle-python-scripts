-- describe departments;
-- describe employees;

-- select last_name, job_id, hire_date, employee_id from employees;
-- select rowid, employee_id, last_name, job_id, hire_date as startdate from employees;
select employee_id, last_name, job_id, to_char(hire_date, 'DD-MON-YY') as stardate from employees;
-- select to_char(sysdate, 'DD-MON-YY') from dual;