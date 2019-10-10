-- Using correlated queries.

-- All employees earning more than the average salary in their department.
SELECT last_name, salary, department_id
FROM employees outer_table
WHERE salary > ( SELECT AVG(salary)  avg_sal
                FROM employees inner_table
                WHERE inner_table.department_id =
                outer_table.department_id);
  

WITH SUB_AVG AS
( SELECT AVG(salary)  avg_sal
  FROM employees inner_table
  WHERE inner_table.department_id = outer_table.department_id)
SELECT department_id, employee_id, SUB_AVG.avg_sal
FROM EMPLOYEES outer_table
WHERE salary = SUB_AVG;


select department_id, employee_id, salary
FROM EMPLOYEES 
WHERE (department_id, salary) IN (
    select e.department_id, max(distinct e.salary)
    from employees e
    group by e.department_id) ;

              
-- Using the EXISTS operator
SELECT employee_id, last_name, job_id, department_id
FROM employees outer_emp 
WHERE EXISTS (  SELECT NULL
                FROM employees
                WHERE manager_id = outer_emp.employee_id);
                
-- Departments with no employees                
SELECT department_id, department_name
FROM departments d
WHERE NOT EXISTS (SELECT NULL
                FROM employees
                WHERE  department_id = d.department_id); 
                
-- NOTICE it does not work because there are employees with no department_id
select department_id, department_name
FROM departments
WHERE department_id NOT IN ( select department_id from employees);

-- WITH CLAUSE
WITH CNT_DEPT AS
(
SELECT department_id,
COUNT(*) NUM_EMP
FROM EMPLOYEES
GROUP BY department_id
)
SELECT employee_id,
SALARY/NUM_EMP
FROM EMPLOYEES E
JOIN CNT_DEPT C
ON (e.department_id = c.department_id);

  
-- WITH AGGREGATED
CREATE TABLE FLIGHTS
(SRC_CITY VARCHAR(20),
DST_CITY VARCHAR(20),
FLIGHT_TIME  NUMBER(4,2));

INSERT INTO FLIGHTS VALUES ('San Jose', 'Los Angeles', 1.3);
INSERT INTO FLIGHTS VALUES ('New York', 'Boston', 1.1);
INSERT INTO FLIGHTS VALUES ('Los Angeles', 'New York', 5.8);

SELECT src_city, CONNECT_BY_ISCYCLE "Cycle", LEVEL, SYS_CONNECT_BY_PATH(src_city, '/') "Path"
FROM FLIGHTS
CONNECT BY NOCYCLE PRIOR src_city = dst_city;

SELECT src_city, dst_city,  
NVL(PRIOR flight_time, 0) + flight_time AS "Total Flight Time",
SYS_CONNECT_BY_PATH(src_city, '/') "Path"
FROM FLIGHTS
CONNECT BY NOCYCLE PRIOR src_city = dst_city;



SELECT last_name "Employee", CONNECT_BY_ISCYCLE "Cycle",
   LEVEL, SYS_CONNECT_BY_PATH(last_name, '/') "Path"
   FROM employees
   WHERE level <= 3 AND department_id = 80
   START WITH last_name = 'King'
   CONNECT BY NOCYCLE PRIOR employee_id = manager_id AND LEVEL <= 4;