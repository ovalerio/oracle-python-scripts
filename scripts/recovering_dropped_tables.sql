-- creating a table to later test flashback funtionality
create table emp3 as select * from employees;

-- dropping the above created table from schema;
drop table emp3;

-- selecting all available  dropped object from recyclebin
select original_name, operation, droptime from recyclebin;
select * from recyclebin;

-- recovering table from recyclebin
flashback table emp3 to before drop;

-- purging from recycle bin
purge recyclebin;

-- nothing has been changed for Lorentz
select versions_starttime "START DATE",
        versions_endtime "END DATE",
        salary
FROM employees
    VERSIONS BETWEEN SCN MINVALUE AND MAXVALUE
WHERE last_name = 'Lorentz';

select * from employees where last_name = 'Lorentz';


ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MON-YYYY HH24:MI:SS';
ALTER SESSION SET TIME_ZONE = '-5:00';

SELECT DBTIMEZONE, SESSIONTIMEZONE, CURRENT_DATE FROM DUAL;

SELECT SESSIONTIMEZONE, CURRENT_TIMESTAMP, LOCALTIMESTAMP FROM DUAL
        