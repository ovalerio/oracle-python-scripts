-- with user sys and sysdba profile
create tablespace personal
datafile 'C:\app\Oracle\oradata\orcl\personal01.dbf' size 20M
autoextend on;

create tablespace projekte
datafile 'C:\app\Oracle\oradata\orcl\projekte01.dbf' size 20M
autoextend on;

create user personal identified by personal
default tablespace personal
temporary tablespace temp
quota unlimited on personal;

create user projekte identified by projekte
default tablespace projekte
temporary tablespace temp
quota unlimited on projekte;

grant connect, resource, create view to personal, projekte;