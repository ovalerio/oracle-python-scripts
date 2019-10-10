-- Lab 05 :  Exercises with CASE, searched CASE, and DECODE

-- Task 1 .  Dream Salaries
select last_name || ' earns ' || to_char(salary,'fm$99,999.00') 
|| ' monthly but wants ' 
|| to_char(3 * salary,'fm$99,999.00')  as "Dream Salaries"
from employees;

-- Task 2 .  Salary Review Dates
select last_name, hire_date,
to_char( next_day( add_months(hire_date,6), 'MONDAY'), 'fmDay, "the" Ddspth "of" Month, YYYY') review
from employees;

-- Task 3 .  Display Commision Amounts
select last_name, nvl2(commission_pct, to_char(commission_pct), 'No Commission') as comm
from employees;

-- Task 4.  Using Case to display Employee Grade
select job_id,
    case job_id when 'AD_PRES' then 'A'
                when 'ST_MAN'  then 'B'
                when 'IT_PROG' then 'C'
                when 'SA_REP'  then 'D'
                when 'ST_CLERK' then 'E'
                else '0'
    end as "GRADE"
from employees;

-- Task 5. Using searched CASE (rewrite task 4)
select job_id,
    case when job_id = 'AD_PRES' then 'A'
         when job_id = 'ST_MAN'  then 'B'
         when job_id = 'IT_PROG' then 'C'
         when job_id = 'SA_REP'  then 'D'
         when job_id = 'ST_CLERK' then 'E'
         else '0'
    end as "GRADE"
from employees;

-- Task 6. Rewrite using DECODE
select job_id,
    DECODE( job_id, 'AD_PRES', 'A',
                    'ST_MAN', 'B',
                    'IT_PROG', 'C',
                    'SA_REP', 'D',
                    'ST_CLERK', 'E' , '0') as "GRADE"
from employees;