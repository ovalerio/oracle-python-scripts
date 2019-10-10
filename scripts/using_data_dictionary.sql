-- Obtaining tables names that are not either USER, ALL  or DBA tables
select * from dictionary where table_name not like 'USER%' and table_name not like 'ALL%' and table_name not like 'DBA%';

-- Selecting those object own by the USER
select * from dictionary where table_name like 'USER%';

-- Selecting objects own by ALL
select * from dictionary where table_name like 'ALL%';

-- Selecting object own by DBA
select * from dictionary where table_name like 'DBA%';

select * from dictionary where table_name = 'USER_OBJECTS';

-- Search the comments column for a comment
SELECT table_name
FROM dictionary
WHERE LOWER(comments) LIKE '%columns%';

-- Reading all comments in the data dictionary
SELECT TABLE_NAME, COMMENTS FROM DICTIONARY WHERE COMMENTS IS NOT NULL;

-- Retrieving information about the user objects
SELECT object_name, object_type, created, status, last_ddl_time, generated 
FROM user_objects ORDER BY object_type;

-- Simplified view of user objects 
SELECT * from CAT; -- CAT is a synonym for USER_CATALOG

-- Catalog of USER_TABLES
SELECT table_name FROM TABS; -- TABS view is a synonym for USER_CATALOG

-- Column Information found in USER_TAB_COLUMNS
DESCRIBE user_tab_columns;

-- Column information from the EMPLOYEES table
SELECT column_name, data_type, data_length, data_precision, data_scale, nullable
FROM user_tab_columns WHERE table_name = 'EMPLOYEES';

-- Unused columns information
select * from user_unused_col_tabs;

-- Constraints information
SELECT * FROM user_constraints WHERE table_name = 'EMPLOYEES';

-- Comments for all columns
SELECT * FROM ALL_COL_COMMENTS;

-- Comments for all tables
SELECT * FROM ALL_TAB_COMMENTS;