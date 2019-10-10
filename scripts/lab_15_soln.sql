SELECT * FROM NLS_SESSION_PARAMETERS;

-- Task 01
CREATE TABLE dept2
    (id NUMBER(7),
    name VARCHAR2(25));

DESCRIBE dept2;

-- Task 02: Populate dept2
INSERT INTO DEPT2
    SELECT department_id, department_name FROM departments;
    
-- Task 03: create emp2    
ALTER TABLE EMP2 RENAME TO EMP_COPY;
CREATE TABLE emp2
    (id NUMBER(7),
    last_name VARCHAR2(25),
    first_name VARCHAR2(25),
    dept_id NUMBER(7));

DESCRIBE emp2;

-- Task 04: add primary key
ALTER TABLE emp2
    ADD CONSTRAINT emp2_id_pk PRIMARY KEY (id);
    
-- Task 05: add primary key to dept2
ALTER TABLE dept2
    ADD CONSTRAINT dept2_id_pk PRIMARY KEY (id);
    
-- Task 06: add foreing key reference on the emp2 table
ALTER TABLE emp2
    ADD CONSTRAINT emp2_dept2_fk FOREIGN KEY (dept_id) REFERENCES dept2(id);
    
-- Task 07:  add commission
ALTER TABLE emp2
ADD commission NUMBER(2,2)
CONSTRAINT my_emp_comm_ck CHECK (commission > 0);

-- Task 08:  drop and purge the tables
drop table emp2 purge;
drop table dept2 purge;

-- Task 09:  Create an external table library_items_ext
CREATE OR REPLACE DIRECTORY emp_dir AS '/media/sf_virtual_maschine_transfer';

CREATE TABLE library_items_ext ( 
    category_id     number(12), 
    book_id         number(6), 
    book_price      number(8,2), 
    quantity        number(8)
    )
ORGANIZATION EXTERNAL
    (TYPE ORACLE_LOADER
    DEFAULT DIRECTORY emp_dir
    ACCESS PARAMETERS (RECORDS DELIMITED BY NEWLINE
    FIELDS TERMINATED BY ',')
    LOCATION ('library_items.dat')
)
REJECT LIMIT UNLIMITED;

SELECT * FROM library_items_ext;

-- Task 10: addresses of all the departments. (using oracle_datapump)
CREATE TABLE dept_add_ext (
    location_id,
    street_address, 
    city,
    state_province,
    country_name)
ORGANIZATION EXTERNAL(
    TYPE ORACLE_DATAPUMP
    DEFAULT DIRECTORY emp_dir
    LOCATION ('hr_emp4.exp','hr_emp5.exp'))  -- only the first file is created hr_emp4.exp
PARALLEL
AS
SELECT location_id, street_address, city, 
state_province, country_name
FROM locations 
NATURAL JOIN countries;

select * from dept_add_ext;

-- Task 11: Create the emp_books table and populate it with data.
DROP TABLE emp_books CASCADE CONSTRAINTS;
CREATE TABLE emp_books (
    book_id number,
    title varchar2(20), 
    CONSTRAINT emp_books_pk PRIMARY KEY (book_id));
    
INSERT INTO emp_books VALUES(300,'Organizations');
INSERT INTO emp_books VALUES(300,'Change Management');   

SET CONSTRAINT emp_books_pk DEFERRED; 
-- drop and create a deferrable one
ALTER TABLE emp_books DROP CONSTRAINT emp_books_pk;
-- create a deferrable one
ALTER TABLE emp_books ADD (CONSTRAINT emp_books_pk PRIMARY KEY (book_id) DEFERRABLE);
-- defer the constraint
SET CONSTRAINT emp_books_pk DEFERRED; 
-- adding rows
INSERT INTO emp_books VALUES(300,'Organizations');
INSERT INTO emp_books VALUES(300,'Change Management');   
INSERT INTO emp_books VALUES (350,'Creativity');
COMMIT;
