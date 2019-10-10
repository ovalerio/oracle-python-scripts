-- Performing natural join between tables with different datatypes in Oracle DB.
-- NOTE: Oracle requires for the natural join that the tables we want to join
-- have at least one column with a common name and implicitly convertible datatypes.

-- TABLE_ONE is composed of a DATE field and a NUMBER field
CREATE TABLE TABLE_ONE  (
    COMMON_NAME DATE,
    NUM_FIELD   NUMBER);
    
INSERT INTO TABLE_ONE VALUES ('22-01-1995', 10);
INSERT INTO TABLE_ONE VALUES ('13-02-1997', 20);
INSERT INTO TABLE_ONE VALUES ('04-05-2008', 30);
INSERT INTO TABLE_ONE VALUES ('15-06-2019', 40);

SELECT * FROM TABLE_ONE; -- Show TABLE_ONE contents.

-- TABLE_TWO is composed of two VARCHAR2 fields
CREATE TABLE TABLE_TWO (
    COMMON_NAME VARCHAR2(10),
    CHAR_FIELD  CHAR(10));

INSERT INTO TABLE_TWO VALUES ('22.01.1995', 'JANUAR');
INSERT INTO TABLE_TWO VALUES ('13.02.1997', 'FEBRUAR');
INSERT INTO TABLE_TWO VALUES ('04.05.2008', 'MAI');
INSERT INTO TABLE_TWO VALUES ('17.09.1999', 'SEPTEMBER');

SELECT * FROM TABLE_TWO; -- Show TABLE_TWO contents.

-- Performing a NATURAL JOIN between TABLE_ONE and TABLE_TWO with implicit type conversion.
-- The natural join is based on the field COMMON_NAME
SELECT * FROM TABLE_ONE NATURAL JOIN TABLE_TWO;

