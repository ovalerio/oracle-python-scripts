-- Practice 7 : Displaying data from multiple tables by USING JOINS

-- Task 1. Produce the addresses of all the departments
select location_id, street_address, city, state_province, country_name
from locations natural join countries;

-- Task 2. All employees with corresponding departments.
select last_name, department_id, department_name
from employees natural join departments;

-- Task 3. Report of employees in Toronto.
select last_name, job_id, department_id, department_name
from employees natural join departments d
where d.location_id = (select location_id from locations l
where l.city = 'Toronto');

-- Task 4. Employees' last names and managers' last names
select e.last_name "Employee", e.employee_id "Emp#", m.last_name "Manager", m.employee_id "Mgr#"
from employees e left join employees m on e.manager_id = m.employee_id;

-- Task 5. All employees who has no manager. (makes no sense.)

-- Task 6. Work in same deparment as a given employee
select e.department_id, e.last_name, c.last_name
from employees e join employees c on (e.department_id = c.department_id)
where e.employee_id <> c.employee_id
order by e.department_id, e.last_name, c.last_name;


-- Task 7. Job grades and salaries
