-- CREATING USER
create USER marcovm identified by marcovm; 

-- Status: Nicht erfolgreich -Test nicht erfolgreich: ORA-01045: user DEMO lacks CREATE SESSION privilege; logon denied
-- GRANTING SYSTEM PRIVILEGES TO THE USER
GRANT 
create session, create table,
create sequence, create view
TO marcovm;

--- Looking up session privileges 
select * from session_privs;

GRANT create synonym TO marcovm;


