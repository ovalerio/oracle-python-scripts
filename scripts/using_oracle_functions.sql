--select last_name, hire_date from employees
--where hire_date = to_date('September 28, 2005', 'Month DD, YYYY');

-- select to_number(sysdate) from dual;

select initcap('jessica$jones%peter+parker') from dual;

select TO_DATE('Donnerstag, Februar 07. 2019', 'Day, Month DD. YYYY', 'NLS_DATE_LANGUAGE = German') FROM DUAL;

select TO_DATE('Thursday, February 07. 2019', 'Day, Month DD. YYYY', 'NLS_DATE_LANGUAGE = American') FROM DUAL;

select to_char(12345.67, '99999G99') from dual;

select to_number('11.11.11,03', '99G99G99D99') from dual;

-- aggregate functions
select department_id, manager_id, listagg(last_name || '(' || hire_date || ')', '-') WITHIN GROUP (ORDER BY hire_date) 
FROM EMPLOYEES
GROUP BY department_id, manager_id
ORDER BY manager_id ASC;

-- this works!
select employee_id, '  sss' ,first_name, '', last_name "ID SSS SS222" from employees;

select months_between(sysdate, '01-JAN-2000') from dual;