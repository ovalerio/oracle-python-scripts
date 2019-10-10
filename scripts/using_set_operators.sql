select job_id from
employees
union
select job_id from
retired_employees;

select job_id from
employees
union all
select job_id from
retired_employees;

-- Was macht die UNION in Hintergrund.
select distinct job_id from (
    select job_id from employees
    union all
    select job_id from retired_employees);
    

-- The MINUS operation
select job_id from employees
minus
select job_id from retired_employees;