SELECT department_name, city
FROM
departments
NATURAL JOIN (SELECT location_id, city, country_id
FROM locations
NATURAL JOIN countries
NATURAL JOIN regions
WHERE region_name = 'Europe');


SELECT department_name, city
FROM departments
NATURAL JOIN locations
NATURAL JOIN countries
NATURAL JOIN regions
WHERE region_name = 'Europe';


SELECT first_name, last_name, manager_id, department_id
FROM employees
WHERE manager_id IN ( select manager_id
        from employees WHERE first_name = 'Daniel')
AND department_id IN (SELECT department_id
        FROM employees WHERE first_name = 'Daniel');


SELECT first_name, last_name, manager_id, department_id
FROM employees
WHERE manager_id IN ( select manager_id
        FROM employees WHERE first_name = 'John')
AND department_id IN (SELECT department_id
        FROM employees WHERE first_name = 'John');


SELECT TO_DATE(
    'January 15, 1989',
    'Month dd, YYYY',
     'NLS_DATE_LANGUAGE = American')
     FROM DUAL;
