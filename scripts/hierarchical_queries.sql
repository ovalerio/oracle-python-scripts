DROP TABLE FLIGHTS;

-- CREATING TABLE FLIHTS
-- CREATE TABLE FLIGHTS ( SOURCE VARCHAR(20), DESTIN VARCHAR(20), FLIGHT_TIME  NUMBER(3,1));
CREATE TABLE FLIGHTS ( SOURCE VARCHAR(20), DESTIN VARCHAR(20), FLIGHT_TIME  NUMBER(2));

-- POPULATING TABLE FLIGHTS
-- INSERT INTO FLIGHTS VALUES ('San Jose', 'Los Angeles', 1.3);
-- INSERT INTO FLIGHTS VALUES ('New York', 'Boston', 1.1);
-- INSERT INTO FLIGHTS VALUES ('Los Angeles', 'New York', 5.8);
INSERT INTO FLIGHTS VALUES ('San Jose', 'Los Angeles', 1);
INSERT INTO FLIGHTS VALUES ('New York', 'Boston', 3);
INSERT INTO FLIGHTS VALUES ('Los Angeles', 'New York', 5);


-- USING RECURSIVE QUERY
WITH Reachable_From (Source, Destin, TotalFlightTime) AS
(
SELECT Source, Destin, Flight_time
FROM Flights
UNION ALL
SELECT incoming.Source, outgoing.Destin,
incoming.TotalFlightTime+outgoing.Flight_time
FROM Reachable_From incoming, Flights outgoing
WHERE incoming.Destin = outgoing.Source
)
SELECT Source, Destin, TotalFlightTime
FROM Reachable_From;

-- USING CONNECT BY
SELECT CONNECT_BY_ROOT source, destin,  
NVL(PRIOR flight_time, 0) + flight_time AS "Total Flight Time"
FROM FLIGHTS
CONNECT BY NOCYCLE source = PRIOR destin;

-- NOT WORKING BECAUSE THE FLIGHT TIME IS NOT BEING ACCUMULATED
SELECT CONNECT_BY_ROOT source, destin,  LEVEL, 
NVL(PRIOR flight_time, 0) + flight_time AS "Total Flight Time",
SYS_CONNECT_BY_PATH(destin, '/') "Path"
FROM FLIGHTS
START WITH source IN (select source from flights)
CONNECT BY PRIOR destin = source
ORDER BY LEVEL;

-- HACK MAKING USE OF THE PATH AS A REPRESENTATION OF WHAT NEEDS TO BE DONE
-- REF. https://databaseline.bitbucket.io/how-to-multiply-across-a-hierarchy-in-oracle-part-1/
CREATE OR REPLACE FUNCTION eval_expr (expr_in IN VARCHAR2)
  RETURN NUMBER
  AUTHID CURRENT_USER
  DETERMINISTIC
  RESULT_CACHE
IS
  PRAGMA UDF;
  v_res NUMBER;
BEGIN   -- STORE PROCEDURE WAS MODIFIED TO AVOID THE SELECT CLAUSE
  EXECUTE IMMEDIATE 'BEGIN :out := ' || expr_in || '; end;' using out v_res;
  --EXECUTE IMMEDIATE 'SELECT ' || expr_in || ' FROM DUAL' INTO v_res;
  RETURN v_res;
END eval_expr;
/

-- TESTING ABOVE FUNCTION
select eval_expr('1+2+3') from dual;

-- USING SYS_CONNECT_BY_PATH TO CREATE THE ACCUMULATED FLIGHT TIME AND REMOVING LEADING + SIGN
SELECT CONNECT_BY_ROOT source, destin,  
EVAL_EXPR(SUBSTR(SYS_CONNECT_BY_PATH(TO_CHAR(flight_time), '+'),2)) AS "Total Flight Time",
SYS_CONNECT_BY_PATH(destin, '/') "Path", LEVEL
FROM FLIGHTS
START WITH source IN (SELECT source FROM flights)
CONNECT BY PRIOR destin = source
ORDER BY LEVEL;


SELECT CONNECT_BY_ROOT source, destin,
EVAL_EXPR(SUBSTR(SYS_CONNECT_BY_PATH(TO_CHAR(flight_time), '+'),2)) AS "Total Flight Time",
SYS_CONNECT_BY_PATH(destin, '/') "Path", LEVEL
FROM FLIGHTS
START WITH source IN (SELECT source FROM flights)
CONNECT BY PRIOR destin = source
ORDER BY LEVEL;

