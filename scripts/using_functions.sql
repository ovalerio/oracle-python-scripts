-- String, Number and Date Functions

-- to_char used to format currency columns
select to_char(salary, 'L99G999') from employees;

-- to_char used to filter specific parts of date columns
select last_name, hire_date from employees
where to_char(hire_date,'MON') = 'JAN';

-- to_char and sysdate using a date format
select to_char(sysdate, 'DD-MON-YYYY HH24:MI:SS') from dual;

-- the systimestamp
select systimestamp from dual;