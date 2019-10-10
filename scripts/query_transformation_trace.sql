-- STEPS for tracing a ROW LIMITING (TOP-N QUERY) QUERY TRANSFORMATION to Oracle pre 12c databases
-- Meine Gedanken
-- Meine Prüfung Backlog ist mittlerweile so groß geworden.  Man kann den ganzen Tag etwas neues von Oracle lernen.  
-- Ich bekomme neue Fragen nach jede Fragebogen fürs Prufungs vorbereitung.

-- STEP 1: Find the trace file for the current session
select value from v$diag_info where name = 'Default Trace File';

-- STEP 2: Perform a 10053 of the statement
alter session set events '10053 trace name context forever';

select last_name, salary, job_id
from employees
order by job_id desc
fetch next 5 percent rows with ties;

alter session set events '10053 trace name context off';

