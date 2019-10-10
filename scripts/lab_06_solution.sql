-- Lab 06 Solutions

-- Task 4 :  Max, Min, Sum and Average
select max(salary) "Maximum", min(salary) "Minimum", sum(salary) "Sum", avg(salary) "Average" from employees;

-- Task 5 : Max, Min, Sum and Avg for each job type
select job_id, max(salary) "Maximum", min(salary) "Minimum", 
    sum(salary) "Sum", avg(salary) "Average" 
    from employees group by job_id;
    
-- Task 6 : Display the number of people with the same job
select job_id, count(*)
    from employees
    group by job_id;
    
-- Task 7 : Determine the number of managers
select COUNT(DISTINCT manager_id) from employees;

-- Task 8 : Difference between highest and lowest salaries
select max(salary) - min(salary) as difference
from employees;

-- Task 9 :  Lowest paid employee by manager
select manager_id, min(salary)
from employees
where manager_id is not null
group by manager_id
having min(salary) > 6000;

-- Task 10 : Total number of employees and number of employees hired in 2005 .. 2008
select count(*) AS TOTAL,
    sum(decode(TO_CHAR(hire_date, 'YYYY'), '2005',1,0)) AS "2005",
    sum(decode(TO_CHAR(hire_date, 'YYYY'), '2006',1,0)) AS "2006",
    sum(decode(TO_CHAR(hire_date, 'YYYY'), '2007',1,0)) AS "2007",
    sum(decode(TO_CHAR(hire_date, 'YYYY'), '2008',1,0)) AS "2008"
from employees;

select count(*) from employees where TO_CHAR(hire_date,'YYYY') = '2005';
select hire_date, TO_CHAR(hire_date, 'YYYY'),decode(TO_CHAR(hire_date, 'YYYY'), '2005', 1, 0) from employees;

-- Task 11 : Total salary by job and department.

select job_id,
    sum(decode(department_id, '20', salary)) as "Dept 20", 
    sum(decode(department_id, '50', salary)) as "Dept 50", 
    sum(decode(department_id, '80', salary)) as "Dept 80", 
    sum(decode(department_id, '90', salary)) as "Dept 90",
    sum(salary) as "Total"
from employees
group by job_id;


