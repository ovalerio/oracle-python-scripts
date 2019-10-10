--TABELLEN MIT wechselseitiger Schlüsselzuweisung:

CREATE TABLE cross_key_a
    (id NUMBER(3) PRIMARY KEY, fkey NUMBER(3) , spalte1 CHAR(5));

CREATE TABLE cross_key_b
    (id NUMBER(3) PRIMARY KEY, fkey NUMBER(3) , spalte1 CHAR(5));
    
ALTER TABLE cross_key_a
ADD CONSTRAINT   fkeya_fk FOREIGN KEY(fkey) REFERENCES cross_key_b(id);

ALTER TABLE cross_key_b
ADD CONSTRAINT   fkeyb_fk FOREIGN KEY(fkey) REFERENCES cross_key_a(id);

INSERT INTO cross_key_a VALUES(5,3,'abc');
INSERT INTO cross_key_b VALUES(3,5,'def');

--Funktioniert nicht:
DROP TABLE cross_key_a;
DROP TABLE cross_key_b;

--Funktioniert

DROP TABLE cross_key_a CASCADE CONSTRAINTS;
DROP TABLE cross_key_b CASCADE CONSTRAINTS;

-- Erzeugung der Tabellen mit verschiebbaren referentiellen Integritäten

CREATE TABLE cross_key_a
    (id NUMBER(3) PRIMARY KEY, fkey NUMBER(3) , spalte1 CHAR(5));

CREATE TABLE cross_key_b
    (id NUMBER(3) PRIMARY KEY, fkey NUMBER(3) , spalte1 CHAR(5));
    
ALTER TABLE cross_key_a
ADD CONSTRAINT   fkeya_fk FOREIGN KEY(fkey) REFERENCES cross_key_b(id)
DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE cross_key_b
ADD CONSTRAINT   fkeyb_fk FOREIGN KEY(fkey) REFERENCES cross_key_a(id)
DEFERRABLE INITIALLY DEFERRED;

INSERT INTO cross_key_a VALUES(5,3,'abc');
INSERT INTO cross_key_b VALUES(3,5,'def');
INSERT INTO cross_key_a VALUES(8,4,'ghi');
INSERT INTO cross_key_b VALUES(4,8,'jkl');

COMMIT;

DELETE FROM cross_key_a WHERE id=5;
DELETE FROM cross_key_b WHERE id=4;

COMMIT;

--Beschränkungen ausschalten:

ALTER TABLE cross_key_a DISABLE CONSTRAINT fkeya_fk;
ALTER TABLE cross_key_b DISABLE CONSTRAINT fkeyb_fk;
--Löschvorgang nun möglich:
DELETE FROM cross_key_a WHERE id=5;
DELETE FROM cross_key_b WHERE id=4;

COMMIT;




