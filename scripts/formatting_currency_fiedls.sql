select 'Das Gehalt von ' || 
       last_name ||
       ' betraegt nach einer 10%igen Erhoehung ' ||
       trim(to_char(salary * 1.1 , 'L99G999'))
from employees
order by salary desc
offset 10 rows
fetch next 10 rows only;

select to_char(salary, 'L99G999') from employees;