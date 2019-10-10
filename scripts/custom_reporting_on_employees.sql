-- This are some custom queries created in order to provide some material for the bubbles graph (plotly)

desc employees;

-- Using extract
select last_name, extract(year from hire_date) from employees;

-- Obtaining the number of years a employee has been at the company
select last_name, extract(year from sysdate), extract(year from hire_date), 
trunc(months_between(sysdate, hire_date)/12), salary from employees;

-- Displaying average salaries vs years of experience.
select  trunc(months_between(sysdate, hire_date)/12) years_of_experience, 
        trunc(avg(salary)) average_salary,
        count(*) 
from employees
group by trunc(months_between(sysdate, hire_date)/12)
order by years_of_experience asc;

desc departments;

-- Joining employees with their departments
select trunc(months_between(sysdate, hire_date)/12) years_of_experience, 
        trunc(avg(salary)) average_salary, count(*)
from employees e 
join departments d using (department_id)
join locations l using (location_id)
group by trunc(months_between(sysdate, hire_date)/12)
order by years_of_experience asc;


select department_id as "DEPT_ID", department_name, 
        trunc(avg(salary)) average_salary,
        trunc(avg(months_between(sysdate, hire_date)/12)) average_years_in_company,
        count(*) dept_total_employees
from employees
join departments using (department_id)
group by department_id, department_name
order by average_salary;

desc departments;


desc locations;

-- SELECT * FROM SESSION_PRIVS;
-- SELECT * FROM USER_SYS_PRIVS;
-- SELECT VIEW_NAME, TEXT_VC FROM ALL_VIEWS WHERE VIEW_NAME IN ('SESSION_PRIVS', 'USER_SYS_PRIVS');