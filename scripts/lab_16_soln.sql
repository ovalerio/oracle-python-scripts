-- Lab 16 - Retrieving data by using subqueries

-- Task 01. Create a query to display any employee who earns a comission.
SELECT last_name, department_id, salary
FROM employees
WHERE (salary, department_id) IN
    (   SELECT salary, department_id
        FROM employees
        WHERE commission_pct IS NOT NULL);
        
-- Task 02. Create a query of employees located in location with id 1700
SELECT e.last_name, d.department_name, e.salary
FROM employees e JOIN departments d
ON e.department_id = d.department_id
AND (salary, job_id) IN (   SELECT e.salary, e.job_id
                            FROM employees e JOIN
                            departments d
                            ON e.department_id = d.department_id
                            AND d.location_id = 1700);

-- Task 03. Create a query to display the last name, hire date, and salary for all employees who have
-- the same salary and manager_ID as Kochhar.
-- Note: Do not display Kochhar in the result set.
SELECT last_name, hire_date, salary
FROM employees
WHERE (salary, manager_id) IN
(SELECT salary, manager_id
FROM employees
WHERE last_name = 'Kochhar')
AND last_name != 'Kochhar';

-- Task 04. Employees with salary higher than all the sales managers (JOB_ID = 'SA_MAN')
SELECT last_name, job_id, salary
FROM employees
WHERE salary > ALL ( 
                SELECT salary
                FROM employees
                WHERE job_id = 'SA_MAN')
ORDER BY salary DESC;

-- Task 05. Employees who work in cities with names beginning with T
SELECT employee_id, last_name, department_id
FROM employees
WHERE department_id IN ( SELECT department_id
                        FROM departments NATURAL JOIN locations
                        WHERE city LIKE 'T%');

-- Task 06. Find all employees who earn more than average salary in their departments.
SELECT e.last_name ename, e.salary salary,
        e.department_id deptno, ROUND(AVG(a.salary), 2) dept_avg
FROM employees e, employees a
WHERE e.department_id = a.department_id
AND e.salary > (SELECT AVG(salary)
                FROM employees
                WHERE department_id = e.department_id )
GROUP BY e.last_name, e.salary, e.department_id
ORDER BY AVG(a.salary);

-- Task 07. All employees who are not supervisors.
-- a) Using the NOT EXISTS
SELECT last_name
FROM employees out_emp
    WHERE NOT EXISTS ( SELECT * FROM employees in_emp
                        WHERE in_emp.manager_id = out_emp.employee_id );
                        
-- b)  Using the NOT IN operator
SELECT last_name
FROM employees
WHERE employee_id NOT IN (SELECT distinct manager_id from employees);

-- The subquery picks up a NULL value so the entire query returns no rows.
-- All conditions that compare a NULL value result in NULL.
-- Do not use NOT IN as a substitute for NOT EXISTS.
SELECT last_name
FROM employees
WHERE employee_id NOT IN (
        SELECT DISTINCT manager_id 
        FROM employees
        WHERE manager_id IS NOT NULL);

-- Task 09. Display workers that have coworkers with later hire dates and higher salaries.
SELECT last_name
FROM employees out_emp
WHERE EXISTS ( SELECT 'X'
                FROM employees in_emp
                WHERE in_emp.department_id = out_emp.department_id
                AND in_emp.hire_date > out_emp.hire_date
                AND in_emp.salary > out_emp.salary);
                
-- Task 10. Query with employees and their department names. NOTE. Use a scalar subquery.
SELECT employee_id, last_name, ( SELECT department_name
                                FROM departments d
                                WHERE e.department_id = d.department_id ) department
FROM employees e
ORDER BY department;

--  Task 11. Department names of departments whose total salary cost is above one-eight (1/8)
--  of the total salry cost of the whole company.
SELECT d.department_name, (SELECT SUM(e.salary)
                           FROM employees e
                           WHERE e.department_id = d.department_id                                
                           GROUP BY e.department_id
                          ) AS dept_total
FROM departments d
WHERE (SELECT SUM(e.salary)
       FROM employees e
       WHERE e.department_id = d.department_id                                
       GROUP BY e.department_id
       ) > (SELECT SUM(e.salary) / 8
                FROM employees e);

-- The same but instead using a with clause.
WITH sum_emp as (
    SELECT d.department_name, SUM(e.salary) AS dept_sum
    FROM employees e
         JOIN departments d
         ON (e.department_id = d.department_id)
    GROUP BY d.department_name
)
select department_name, dept_sum
from departments natural join sum_emp
where dept_sum > (select sum(salary)/8 from employees);

-- As natural join will not work because employees and departments share more than one field
-- namely the department_id and the manager_id
SELECT department_name, SUM(salary) AS dept_total
FROM employees NATURAL JOIN departments
GROUP BY department_name;

DESC departments;
DESC employees;

-- Instead of using a join using a cross product as  Gholan recommedation
WITH summary AS
(
    SELECT department_name, SUM(salary) AS dept_total
    FROM employees e, departments d
    WHERE e.department_id = d.department_id
    GROUP BY department_name
)
SELECT department_name, dept_total
FROM summary
WHERE dept_total > (SELECT SUM(salary)/8 FROM employees)
ORDER BY department_name;


--Task 06.  Alternative solution using a WITH clause  (0,008 Sekunden)
WITH dept_summary AS
(
    SELECT department_id, AVG(salary) dept_avg
    FROM employees
    GROUP BY department_id
)
SELECT last_name, salary, department_id, round(dept_avg, 2) avg_dept
FROM employees NATURAL JOIN dept_summary
WHERE salary > dept_avg
ORDER BY avg_dept, last_name;

--Task 06. Solution using subquery (0,005 Sekunden)
SELECT e.last_name ename, e.salary salary,
        e.department_id deptno, ROUND(AVG(a.salary), 2) dept_avg
FROM employees e, employees a
WHERE e.department_id = a.department_id
AND e.salary > (SELECT AVG(salary)
                FROM employees
                WHERE department_id = e.department_id )
GROUP BY e.last_name, e.salary, e.department_id
ORDER BY AVG(a.salary), ename;
