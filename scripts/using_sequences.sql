-- Chapter 12: Testing sequences with Oracle

-- Ich habe getest was für ein Fehlermeldung gibt wenn ein Sequenz Maximal Wert ist errreich.
CREATE SEQUENCE my_seq_2
  INCREMENT BY 1
  MINVALUE 1
  MAXVALUE 2
  NOCYCLE;
  
select my_seq_2.nextval from dual;
select my_seq_2.nextval from dual;
select my_seq_2.nextval from dual;

--drop sequence my_seq_2;

-- Using a sequence to default a column field
CREATE SEQUENCE ID_EMP_SEQ START WITH 1;
CREATE TABLE emp_test (
    id_emp NUMBER DEFAULT ID_EMP_SEQ.NEXTVAL NOT NULL,
    name VARCHAR2(10));
INSERT INTO emp_test (name) VALUES ('john');
INSERT INTO emp_test (name) VALUES ('mark');
SELECT * FROM emp_test;
-- dropping sequence
DROP SEQUENCE ID_EMP_SEQ;
-- error - sequence does not exist
INSERT INTO emp_test (name) VALUES ('mary');

-- describe sequences
desc user_sequences;