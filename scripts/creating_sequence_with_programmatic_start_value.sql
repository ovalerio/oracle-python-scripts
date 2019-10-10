-- Defining an auto incrementing sequence for an already existing table using the 
-- max value present on the table to define the start value of the sequence.
-- This script uses a copy of the departments table and define a sequence for the department_id field  
set serveroutput on;  -- enabling DBMS_OUTPUT which is turned off by default.

-- Cleaning up in case the script has been run before.
drop table dept_copy;
drop sequence seq_dep_deptid;

-- Creating a copy of departments from HR 
create table dept_copy as select * from departments;

-- Creating the sequence to use every time rows are added into dept_copy
-- Necessary to use the procedure since start values of sequences cannot
-- be set using the result of a query
-- NOTE: Department id values are multiples of 10. Same convention is used by the sequence.
DECLARE
  max_deptid NUMBER;
BEGIN
  SELECT MAX(department_id) INTO max_deptid FROM dept_copy;
  IF SQL%FOUND THEN 
    DBMS_OUTPUT.PUT_LINE('Max Dept Id: ' || max_deptid );
  END IF;
  EXECUTE IMMEDIATE 'CREATE SEQUENCE seq_dep_deptid START WITH '|| TO_CHAR(max_deptid + 10) ||' INCREMENT BY 10 NOCYCLE';
END;

-- Defininig a trigger for table dept_copy that is used every time a row is added into the table
CREATE TRIGGER dept_copy_trigger
  BEFORE INSERT ON dept_copy
  FOR EACH ROW
BEGIN
  :new.department_id := seq_dep_deptid.NEXTVAL;
END;

-- Testing inserting some values
insert into dept_copy(department_name, manager_id, location_id) values ('Mathematics', 100, 1700);
insert into dept_copy(department_name, manager_id, location_id) values ('Chemistry', 103, 1400);
insert into dept_copy(department_name, manager_id, location_id) values ('Linguistics', 100, 1700);

-- Displaying contents of dept_copy
select * from dept_copy
order by department_id desc;