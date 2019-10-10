-- Chapter 5: Conversion Functions
select to_char(sysdate, 'fmMONTH, YEAR') FROM DUAL;

select to_char(sysdate, 'fmDDth MONTH') from dual;

select to_char(sysdate, 'fmddTH Month') from dual;


select to_char(sysdate, 'DD'),
        to_date(to_char(sysdate, 'DD'), 'DD'),
        to_char(to_date(to_char(sysdate, 'DD'), 'DD'), 'YEAR') 
    from dual;


select nullif('coda','sid'), 
        nvl2(nullif('coda','sid'), 'spaniel','terrier')
from dual;


select substr('AM I NULL',10),
        nvl(substr('AM I NULL',10),'YES I AM')
        from dual;
        
select decode(to_char(sysdate, 'MM'),'02','TAX DUE', 'PARTY') FROM DUAL;

select count(*), count(commission_pct) from employees;


select length(100) from dual;

select sum(avg(length(nvl(commission_pct,0)))) from employees
group by commission_pct;

select department_id, sum(salary) from employees group by department_id;

select job_id, max_salary from jobs group by max_salary;

select employee_id, last_name, job_id, salary
from employees
where salary < ANY (SELECT salary FROM employees
                    WHERE job_id = 'IT_PROG')
AND job_id <> 'IT_PROG';                    


select employee_id, last_name, job_id, salary
from employees
where NOT salary  < ANY (SELECT salary FROM employees
                    WHERE job_id = 'IT_PROG')
AND job_id <> 'IT_PROG';   

SELECT DISTINCT JOB_ID  FROM EMPLOYEES;

SELECT * from EMPLOYEES NATURAL JOIN DEPARTMENTS
ORDER BY DEPARTMENT_ID, MANAGER_ID;

SELECT * FROM EMPLOYEES JOIN DEPARTMENTS USING (MANAGER_ID, DEPARTMENT_ID)
ORDER BY DEPARTMENT_ID, MANAGER_ID;

-- Comparing two queries
SELECT * from EMPLOYEES NATURAL JOIN DEPARTMENTS
MINUS
SELECT * FROM EMPLOYEES JOIN DEPARTMENTS USING (MANAGER_ID, DEPARTMENT_ID);

SELECT * FROM EMPLOYEES E JOIN DEPARTMENTS D USING (DEPARTMENT_ID);

-- Previous and current job
SELECT E.EMPLOYEE_ID, E.LAST_NAME, J.JOB_ID PREV_JOB, E.JOB_ID CURR_JOB
FROM JOB_HISTORY J JOIN EMPLOYEES E ON (J.START_DATE = E.HIRE_DATE);

SELECT E.EMPLOYEE_ID, E.LAST_NAME, J.JOB_ID PREV_JOB, E.JOB_ID CURR_JOB
FROM JOB_HISTORY J JOIN EMPLOYEES E ON (J.START_DATE = E.HIRE_DATE);

-- JOINING REGIONS
SELECT * FROM REGIONS R1 JOIN REGIONS R2 ON (R1.REGION_ID=LENGTH(R2.REGION_NAME)/2);

--- MULTI ROW SUBQUERY
select first_name, department_id, salary
from employees
where (salary, department_id) = ((17000, 90)); 

