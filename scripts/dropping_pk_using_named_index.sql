-- CREATING A TABLE WITH A PK CONSTRAINT THAT USES A NAMED UNIQUE INDEX
create table dummy_table (a int, b char);
create unique index dummy_ndx on dummy_table(a);
alter table dummy_table add constraint dummy_pk primary key (a) using index dummy_ndx; 

-- POPULATING THE TABLE WITH VALUES
insert into dummy_table values (1, 'a');
insert into dummy_table values (2, 'b');
insert into dummy_table values (3, 'c');

-- ALTERING THE TABLE BY DROPPING THE PRIMARY KEY CONSTRAINT
alter table dummy_table drop constraint dummy_pk;

-- ATTEMPTING TO INSERT RECORDS AFTER THE PK HAS BEEN DROPPED
insert into dummy_table values (4, 'd'); -- this should work
insert into dummy_table values (2, 'm'); -- this triggers a unique constraint error
