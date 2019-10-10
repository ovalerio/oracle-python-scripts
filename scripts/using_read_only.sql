DROP TABLE ro_tab PURGE;

CREATE TABLE ro_tab (
    id NUMBER
    );
    
INSERT INTO ro_tab VALUES (1); 
ALTER TABLE ro_tab READ ONLY;

select * from ro_tab; -- should work

INSERT INTO ro_tab VALUES (2); -- DML should fail
UPDATE ro_tab SET id = 2; -- Update should also fail
DELETE FROM ro_tab; -- DML should fail

-- DDL Statements should also be restricted
TRUNCATE table ro_tab;
ALTER TABLE ro_tab ADD (description VARCHAR2(50));

-- Restore the table to read write mode.
ALTER TABLE ro_tab READ WRITE;

-- Delete the table contents
DELETE FROM ro_tab;