-- TESTING THE RESULT OF MARKING A TABLE FIELD AS UNUSED IN ORACLE DATABASE

-- CREATING A TABLE 
create table test_unused 
( field_one number,
  field_two number,
  field_three varchar(1));

-- POPULATING WITH DATA
insert into test_unused values ( 1, 10, 'a');
insert into test_unused values ( 2, 20, 'b');
insert into test_unused values ( 3, 30, 'c');

-- CREATING AN INDEX ON FIELD ONE
create index field_one_ndx on test_unused(field_one);

select index_name, table_name, status 
from user_indexes where table_name = 'TEST_UNUSED';

-- CREATING A SYNONYM OF THE TABLE
create synonym tu for test_unused;

-- CREATING A VIEW OF THE TABLE  
create view tu_view as 
    select field_one, field_three from test_unused;

select object_name, status from user_objects 
where object_type = 'VIEW' and object_name = 'TU_VIEW';

-- QUERYING TABLE CONTENTS USING VIEW AND SYNONYM
select * from test_unused;
select * from tu_view;
select * from tu;

-- SETTING FIELD ONE AS UNUSED
alter table test_unused set unused(field_one);

-- PROOFING STATUS OF THE TABLE VIEW
select object_name, status from user_objects 
where object_type = 'VIEW' and object_name = 'TU_VIEW';

-- FIND OUT IF THERE IS STILL AN INDEX 
select index_name, table_name, status 
from user_indexes where table_name = 'TEST_UNUSED';

-- SYNONYM SHOULD BE WORKING FINE
select * from tu;

-- VIEW WILL STATE IT IS INVALID AND ASK TO BE RECOMPILED
select * from tu_view;