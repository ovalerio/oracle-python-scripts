-- EXTERNAL TABLE
CREATE OR REPLACE DIRECTORY emp_dir AS '/media/sf_virtual_maschine_transfer';

-- GRANTING USER ORA21 rights on emp_dir
GRANT READ ON DIRECTORY emp_dir TO ora21;

DROP TABLE EXT_EMP;

-- CREATING AN EXTERNAL TABLE
CREATE TABLE EXT_EMP
(
    empno  number(6),
    ename varchar2(20),
    job varchar2(10),
    mgr number(6),
    hiredate date,
    sal  number(8),
    comm  number(8,2),
    deptno  number(4)
)
ORGANIZATION EXTERNAL
(TYPE ORACLE_LOADER
DEFAULT DIRECTORY emp_dir
ACCESS PARAMETERS
(RECORDS DELIMITED BY NEWLINE
    FIELDS TERMINATED BY ','
    (empno char,
     ename char,
     job char,
     mgr char,
     hiredate date 'DD-MON-YYYY',
     sal char,
     comm char,
     deptno char))
LOCATION ('emp2.dat'));


SELECT * FROM EXT_EMP;

