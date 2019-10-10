CREATE TABLE emp_history
  (employee_id    NUMBER(6) NOT NULL,
   resignation_date DATE)
   
/

insert into emp_history
  values(102, TO_DATE('13-AUG-2002', 'DD-MON-YYYY'));
insert into emp_history
  values(103,TO_DATE( '07-DEC-2007', 'DD-MON-YYYY'));
insert into emp_history
  values(106, TO_DATE( '27-NOV-2008', 'DD-MON-YYYY'));
insert into emp_history
  values(107, TO_DATE( '10-NOV-2006', 'DD-MON-YYYY'));
 
COMMIT;