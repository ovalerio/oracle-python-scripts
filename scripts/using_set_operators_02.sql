select last_name, hire_date FROM employees
UNION ALL
select last_name || '*', NULL FROM retired_employees
order by 1;




select count(last_name) from employees;

select count(last_name) from retired_employees;