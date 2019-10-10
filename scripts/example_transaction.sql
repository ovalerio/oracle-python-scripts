select index_name, tablespace_name from user_indexes;

select * from user_synonyms;

select distinct object_type, namespace
from all_objects
order by namespace;

select * from user_constraints;

select * from all_objects WHERE OBJECT_TYPE = 'CONSTRAINT';

create table example ( a number check (a > 0), b char(2) NOT NULL, c number default 1);

create table copy_example as select * from example;

select constraint_name, constraint_type, table_name, search_condition 
from user_constraints where table_name IN ( 'EXAMPLE', 'COPY_EXAMPLE');

insert into example (a,b) values (4, 'b');
insert into example (a,b) values (3, 'a');
insert into example (a,b) values (5, 'c');
select * from example;
update example set c = a + c;
update example set a = a - 3;
select * from example;


select * from session_privs;

grant select on employees to marcovm;

grant update (department_name, location_id)
on departments
to marcovm;
