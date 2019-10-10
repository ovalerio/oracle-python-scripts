select to_char(sysdate, 'year " vs "  YYYYSP') from dual;
select to_char(sysdate, 'fmDay, Month "im Jahre" YYYY') from dual;
select to_char(sysdate, 'DdSPth') from dual;

-- Using the COUNT Function
select count(*) from employees where department_id = 50;
select count(commission_pct) from employees where department_id = 50;

-- Creating an index on salary column
create index emp_sal_idx ON employees(salary);

-- Querying employees by salary
select * from employees where salary = 24000;

-- Creating a multiple column index
create index emp_sal_hd_idx ON employees(salary, hire_date);

-- Querying employees and filtering by salary and hire_date
select * from employees where salary between 15000 and 25000
and hire_date > to_date('01.01.2003', 'DD.MM.YYYY');