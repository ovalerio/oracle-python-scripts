ALTER SESSION SET CONTAINER=CDB$ROOT;

SELECT FILE_NAME FROM DBA_DATA_FILES;

-- FIND OUT WHICH CON_ID IS USED BY THE SEED PDB
select name, cdb from v$database;
select con_ID, name, open_mode from v$pdbs;

select name from v$datafile where con_id = 2;

-- SHOW AVAILABLE PDBS
show pdbs;

-- CLONE THE ORCL DATABASE
create pluggable database orclclone from orcl
    file_name_convert = ('orcl', 'orclclone');

-- CREATE A PLUGGABLE DATABASE USING THE PDBSEED AT *ORCLCDB* (notice the name) 
CREATE PLUGGABLE DATABASE salespdb 
ADMIN USER salesadm IDENTIFIED BY password
ROLES = (dba)
DEFAULT TABLESPACE sales 
DATAFILE '/u01/app/oracle/oradata/ORCLCDB/salespdb/sales01.dbf' SIZE 50M AUTOEXTEND ON
PATH_PREFIX = '/u01/app/oracle/oradata/ORCLCDB/salespdb/'
FILE_NAME_CONVERT=('/u01/app/oracle/oradata/ORCLCDB/pdbseed/','/u01/app/oracle/oradata/ORCLCDB/salespdb/');

-- NOTICE THAT SALESADM HAS BEEN CREATED WITH DBA ROLE
-- TO GRANT SYSDBA ROLE USE A GRANT SYSDBA TO SALESADM
GRANT SYSDBA TO SALESADM;

-- FIND IN WHICH MODE IS CURRENTLY THE RECENTLY CREATED PDB
select con_id, name, open_mode from v$pdbs;

-- MOUNT AND OPER THE PLUGABBLE DATABASE
ALTER PLUGGABLE DATABASE salespdb OPEN READ WRITE;

-- GRANTING UNLIMITED TABLESPACE FOR USESR SALESADM AT SALESPDB
alter user salesadm quota unlimited on sales;

-- FINALLY CONNECT AS SALESADM IN ORDER TO RUN THE SALES_DATA.SQL SCRIPT