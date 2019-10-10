CREATE OR REPLACE DIRECTORY emp_dir AS '/usr/local/emp_dir';

SELECT user from dual;

CREATE TABLE emp_load
    (employee_number      CHAR(5),
     employee_dob         CHAR(20),
     employee_last_name   CHAR(20),
     employee_first_name  CHAR(15),
     employee_middle_name CHAR(15),
     employee_hire_date   DATE)
  ORGANIZATION EXTERNAL
    (TYPE ORACLE_LOADER
     DEFAULT DIRECTORY emp_dir
     ACCESS PARAMETERS
       (RECORDS DELIMITED BY NEWLINE
        FIELDS (employee_number      CHAR(2),
                employee_dob         CHAR(20),
                employee_last_name   CHAR(18),
                employee_first_name  CHAR(11),
                employee_middle_name CHAR(11),
                employee_hire_date   CHAR(10) date_format DATE mask "mm/dd/yyyy"
               )
       )
     LOCATION ('emp_data.dat')
    );
    
    