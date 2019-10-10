-- Lab 6 - Reporting aggregated data.
-- Task 6-04.  Find highest, lowest, sum, and average salary of employees.
select max(salary) "Maximum", min(salary) "Minimum", 
sum(salary) "Sum", round(avg(salary)) "Average"
from employees;

-- Task 6-05.  For each job type find high, low, sum and average. 
select job_id, max(salary) "Maximum", min(salary) "Minimum", 
sum(salary) "Sum", round(avg(salary)) "Average"
from employees
group by job_id;

-- Task 6-06.  People with the same job.
select job_id, count(*)
from employees
group by job_id;

-- Task 6-07.  Determine the number of managers without listing them.
select count(distinct manager_id)
from employees;

-- Task 6-08. Difference between highest and lowest salaries.
select max(salary) - min(salary)  DIFFERENCE
from employees;

-- Task 6-09. Lowest paying employees by manager.
select manager_id, min(salary)
from employees
where manager_id is not null
group by manager_id
order by min(salary) desc;

-- Task 6-10.  Display the total number of employees.
select  count(*) "TOTAL", 
        sum(decode(to_char(hire_date,'YYYY'),'2005',1,0)) "2005",
        sum(decode(to_char(hire_date,'YYYY'),'2006',1,0)) "2006",
        sum(decode(to_char(hire_date,'YYYY'),'2007',1,0)) "2007",
        sum(decode(to_char(hire_date,'YYYY'),'2008',1,0)) "2008"
from employees;

-- Task 6-11. Salary based on the department number.
SELECT
job_id "Job",
SUM(DECODE(department_id , 20, salary)) "Dept 20",
SUM(DECODE(department_id , 50, salary)) "Dept 50",
SUM(DECODE(department_id , 80, salary)) "Dept 80",
SUM(DECODE(department_id , 90, salary)) "Dept 90",
SUM(salary) "Total"
FROM
employees
GROUP BY job_id;

-- Operating with dates
select sysdate, sysdate + 3, sysdate - 3 from dual;

-- Truncating dates
SELECT TO_CHAR(SYSDATE, 'DD-MM-YYYY HH24:MI:SS') SYS_DATE,
TO_CHAR(TRUNC(SYSDATE, 'DD'), 'DD-MM-YYYY HH24:MI:SS') TRUNC_DAY, 
TO_CHAR(TRUNC(SYSDATE, 'MM'), 'DD-MM-YYYY HH24:MI:SS') TRUNC_MONTH, 
TO_CHAR(TRUNC(SYSDATE, 'YYYY'), 'DD-MM-YYYY HH24:MI:SS') TRUNC_YEAR
FROM DUAL;