-- EXAMPLE QUESTIONS FOR THE ORACLE CERTIFICATION

-- EXAMPLE 01: Retrieving employee's last names using a BETWEEN 
select * from employees where last_name = 'Chung';

UPDATE employees SET last_name = 'C' WHERE last_name = 'Chung';

SELECT last_name, salary FROM employees
WHERE UPPER(last_name) BETWEEN 'A' AND 'C'
AND salary < 10000;

rollback;  -- just to remove the update

-- Alternatively using a REGEXP_LIKE
SELECT last_name, salary FROM employees
WHERE REGEXP_LIKE(last_name,'^a|^b|^c','i'); 


-- EXAMPLE 02: Dropping a table for which a foreign key exists
CREATE TABLE DEPT (DEPTNO NUMBER(2) PRIMARY KEY, DEPTNAME VARCHAR2(2));
CREATE TABLE EMP (EMPNO NUMBER(1) PRIMARY KEY, ENAME VARCHAR2(4), DEPTNO NUMBER(2) REFERENCES DEPT(DEPTNO));

-- Checking FK and PK on EMP table.  Also have a view at the indexes.
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'EMP';
SELECT * FROM USER_INDEXES WHERE TABLE_NAME IN('EMP','DEPT');

-- Inserting data into DEPT and EMP tables
INSERT INTO DEPT VALUES (10, 'IT');
INSERT INTO DEPT VALUES (20, 'HR');

INSERT INTO EMP VALUES (1, 'KING', 10);
INSERT INTO EMP VALUES (2, 'HARI', 20);

COMMIT;

-- Dropping the EMP table and then recovering it back using a flashback
DROP TABLE EMP;
FLASHBACK TABLE EMP TO BEFORE DROP;

-- Reading table EMP contents after the flashback
SELECT * FROM EMP;

-- Finding which constraints where recovered after the flashback operation (FK is gone)
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'EMP';

-- Attempting to insert data into EMP table
INSERT INTO EMP VALUES (2, 'COTT', 10); -- PK violation
INSERT INTO EMP VALUES (3, 'ING', 55);  -- should work because no FK constraint after flashback

-- Reading table EMP contents after the above insert operations
SELECT * FROM EMP;

-- Reading the indexes on EMP table
SELECT * FROM USER_INDEXES WHERE TABLE_NAME IN('EMP','DEPT');