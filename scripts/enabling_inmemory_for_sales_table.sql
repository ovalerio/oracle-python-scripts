-- Describe the structure and number of rows in sales_data
desc sales_data;
select count(*) from sales_data;

-- Enable inmemory column store for sales_data table
alter table sales_data inmemory;

-- Disable inmemory column store option for sales_data
alter table sales_data no inmemory;

-- Disable a particular field from being placed in memory
alter table sales_data inmemory no inmemory (sale_id);

-- Create a sales table partitioned using the sale_date
CREATE TABLE sales_data_part
(
sale_id int,
sale_date date,
customer_id varchar(40),
product_id varchar(10),
quantity int
) PARTITION BY RANGE (sale_date)
(	PARTITION sales_h1_2016 VALUES LESS THAN (TO_DATE('01-JUN-2016','dd-MON-yyyy')) 		NO INMEMORY,
	PARTITION sales_h2_2016 VALUES LESS THAN (TO_DATE('01-JAN-2017','dd-MON-yyyy')) 		INMEMORY
);
