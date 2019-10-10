ALTER SESSION SET nls_date_format='DD-MON-YYYY HH24:MI:SS';

-- Create data file.
SET PAGESIZE 0 LINESIZE 100 TRIMSPOOL ON FEEDBACK OFF
SPOOL /media/sf_virtual_maschine_transfer/emp.dat.tmp

SELECT employee_id || ',' || last_name || ',' || job_id || ',' 
|| manager_id || ',' || to_char(hire_date,'dd-mon-yyyy') || ',' 
|| trunc(salary) || ',' || commission_pct || ',' || department_id 
FROM employees;


SPOOL OFF
SET PAGESIZE 14 FEEDBACK ON