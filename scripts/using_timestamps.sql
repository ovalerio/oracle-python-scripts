-- USING TIMESTAMP WITH TIMEZONE

ALTER SESSION SET TIME_ZONE = 'Europe/Helsinki'; -- GMT+3
SELECT SESSIONTIMEZONE, CURRENT_DATE, CURRENT_TIMESTAMP FROM DUAL;

-- FIND OUT THE TIME STAMP FORMAT IN USE
SELECT VALUE FROM NLS_SESSION_PARAMETERS WHERE PARAMETER = 'NLS_TIME_TZ_FORMAT';

-- Auch wicthig is das timezone nicht zu vergessen wenn Feld ist mit TZ
CREATE TABLE test_time(date_tz  TIMESTAMP WITH TIME ZONE);
INSERT INTO test_time 
VALUES (TO_TIMESTAMP_TZ( CURRENT_TIMESTAMP, 'DD.MM.RR HH24:MI:SSXFF TZR'));

SELECT * FROM TEST_TIME;

-- Find out the correct definition of NLS_TIMESTAMP_FORMAT
SELECT * FROM NLS_SESSION_PARAMETERS;

INSERT INTO test_time
VALUES (TO_TIMESTAMP_TZ( CURRENT_TIMESTAMP)); 

-- Creating table with date time zone and local time zone
CREATE TABLE test_local_time( date_tz TIMESTAMP WITH TIME ZONE,
                            date_ltz TIMESTAMP WITH LOCAL TIME ZONE);
                            
INSERT INTO test_local_time (date_tz, date_ltz)
VALUES (SYSTIMESTAMP, CURRENT_TIMESTAMP);

INSERT INTO test_local_time (date_tz, date_ltz)
VALUES (CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

select * from test_local_time;

select numtoyminterval(11, 'month'), numtoyminterval(12, 'month') from dual;
select numtoyminterval(12, 'month') from dual;


select (interval '4-2' year to month) from dual;

select instr('test', 's') from dual;