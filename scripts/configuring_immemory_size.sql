-- Displaying information on the container
SELECT SYS_CONTEXT('USERENV', 'CON_NAME') FROM DUAL;

-- Changing into the root context
ALTER SESSION SET CONTAINER=CDB$ROOT;

-- Validate that inmemory size is currently enabled
SHOW PARAMETER INMEMORY_SIZE;

-- Query to the SGA
SELECT NAME, VALUE FROM V$SGA;

-- Altering inmemory size
ALTER SYSTEM SET INMEMORY_SIZE=256m SCOPE=SPFILE;

