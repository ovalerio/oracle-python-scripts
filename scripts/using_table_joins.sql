-- Using Table Joins

-- First example is using an INNER JOIN. The keyword INNER can be ommitted since Oracle defaults to use INNER JOIN
select first_name, last_name, department_name
from employees join departments on employees.department_id = departments.department_id;

-- In case there are null values on the left table joining row that we would like to retrieve use a LEFT JOIN instead
select first_name, last_name, department_name
from employees left join departments on employees.department_id = departments.department_id;

-- For displaying some department names who actually have no matching employees in the employee table
-- we can make use of a RIGHT JOIN
select first_name, last_name, department_name
from employees right join departments on employees.department_id = departments.department_id
order by last_name asc NULLS FIRST;

-- Use a FULL JOIN to retrieve all fields, no matter if there are some unknown values (NULL)
select first_name, last_name, department_name
from employees full join departments on employees.department_id = departments.department_id
order by last_name asc NULLS FIRST;

