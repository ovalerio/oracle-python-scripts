-- Identify tables using in-memory column caching performance enhacement
select segment_name, bytes, bytes_not_populated, populate_status from v$im_segments;

-- Perform a query on sales data to force the table columns to be cached
select count(*) from sales_data;

-- SQL inmemory optimization advisor requires Oracle >= 12.2.0.3 in order to run the advisor
-- NOTE:  You need an Oracle support account in order to download the advisor.
-- METALINK ID:  1965343.1
-- http://www.oracle.com/technetwork/database/manageability/in-memory-advisor-usecases-3044094.pdf

-- Explain plan for a query using inmemory column optimization
explain plan for select avg(quantity) from sales_data;
select plan_table_output from table(dbms_xplan.display('plan_table',null,'basic'));
