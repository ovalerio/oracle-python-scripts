select department_id, avg(salary)
from employees
group by department_id
order by avg(salary) desc
fetch first 1 row only;


select department_id, avg(salary)
from employees
group by department_id
having avg(salary) = (select max(avg(salary)) from employees group by department_id)


select department_id, avg(salary) over(partition by department_id)
from employees;

select department_id, avg(salary) over(partition by department_id)
from employees;



SELECT INSTR('How_long_is_a_piece_of_string?','_',5,3) FROM DUAL;
SELECT INSTR('How_long_is_a_piece_of_string?','_',5,5) FROM DUAL;

