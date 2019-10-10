-- Schema Personal erstellen und mit Tabellen befuellen
-- Achtung zuerst müssen Sie darauf achten, dass der Benutzer Personal momentan
-- nicht angemeldet ist 
-- danach führen Sie dieses Skript aus mit dem zweiten Ausführen Button
-- als user Sys as sysdba wird der vorhandene Benutzer
-- Personal gelöscht - danach wird er neu erstellt und es werden die Beispieltabellen
-- erstellt und mit Daten gefüllt

connect sys/oradmin as sysdba

-- Löschen
drop user personal cascade;

-- Neuerstellung
create user personal identified by personal
default tablespace personal
temporary tablespace temp
quota unlimited on personal;

-- Rechtevergabe
grant connect, resource, create view, unlimited tablespace to personal;

-- jetzt als Benutzer Personal anmelden
connect personal/personal

-- Tabellen erstellen und mit Daten füllen
create table abteilungen
(
abtnr varchar2(2) constraint pk_abteilungen primary key,
abtname varchar2(18),
abtleiter varchar2(30),
kostenstelle varchar2(5)
);


insert into abteilungen values ('co', 'controlling', 'meister', 42807);
insert into abteilungen values ('bu', 'buchhaltung', 'messner', 20230);
insert into abteilungen values ('ei', 'einkauf', 'werner', 42802);
insert into abteilungen values ('en', 'entwicklung', 'geiger', 37015);
insert into abteilungen values ('fe', 'fertigung', 'koenig', 33006);
insert into abteilungen values ('ge', 'geschaeftsfuehrung', 'kleinert', 21022);
insert into abteilungen values ('ko', 'konstruktion', 'mueller', 37016);
insert into abteilungen values ('ku', 'kundendienst', 'kanter', 42805);
insert into abteilungen values ('ve', 'vertrieb', 'schimmel', 43801);
commit;


CREATE table Mitarbeiter
(
personalnr integer constraint pk_mitarbeiter primary key,
vorname varchar2(30),
name varchar2(30),
str varchar2(35),
plz varchar2(5),
ort varchar2(40),
geburt date,
eintritt date,
fs char(4),
sex char(1),
abtnr varchar2(2),
constraint fk_mit_abt foreign key (abtnr) references abteilungen(abtnr)
);

insert into mitarbeiter values (1,'Maria', 'Anders', 'Obere Str. 57', '12209', 'Berlin', '5-JAN-1945', '14-JAN-1967', 'ja', 'w', 'co');
insert into mitarbeiter values (2, 'Hanna', 'Moos', 'Forsterstr. 57', '68306', 'Mannheim','30-MÄRZ-1952', '22-MÄRZ-1980', 'ja','w','ku');
insert into mitarbeiter values (3,'Sven', 'Ottlieb', 'Walserweg 21', '52520', 'Aachen', '17-NOV-1964', '14-JUN-1983', 'ja', 'm','bu');
insert into mitarbeiter values (4,'Peter', 'Franken', 'Berliner Platz 43', '80805', 'Muenchen', '13-JUL-1933', '17-SEP-1952','nein','m','en');
insert into mitarbeiter values (5,'Philip', 'Cramer', 'Maubelstr. 90', '14776', 'Brandenburg', '12-DEZ-1943', '1-SEP-1972', 'nein', 'm','co');
insert into mitarbeiter values (6,'Renate', 'Messner', 'Magazinweg 7', '60528', 'Frankfurt a. M.', '21-APR-1962', '14-OKT-1985','ja','w','bu');
insert into mitarbeiter values (7,'Alexander', 'Feuer', 'Heerstr 22', '04179', 'Leipzig', '3-NOV-1972', '1-JAN-1995','nein', 'm', 'co');
insert into mitarbeiter values (8,'Henriette', 'Pfalzheim', 'Mehrheimerstr. 369', '50739', 'Koeln', '15-OKT-1955', '12-MÄRZ-1997', 'nein', 'w', 'bu');
insert into mitarbeiter values (9,'Horst','Kloos','Taucherstraße 10','01307','Cunewalde','23-AUG-1959','15-APR-1987','ja','m','ge');
insert into mitarbeiter values (10,'Karin','Josephs','Luisenstr. 48','44087','Muenster','1-MAI-1971','1-MÄRZ-1994','ja','w','ku');
insert into mitarbeiter values (11,'Rita','Mueller','Adenauerallee 900','70563','Stuttgart','17-SEP-1924','1-JUN-1954','ja','w','ko');
insert into mitarbeiter values (12,'Herbert','Mueller','Kraehenweg 4','81347','Muenchen','16-FEB-1918','1-JAN-1945','ja','m','en');
insert into mitarbeiter values (13,'Karl','Friesen','Rennweg 23a','70934','Lauben','22-DEZ-1966','15-DEZ-1983','ja','m','en');
insert into mitarbeiter values (14,'Helmut','Werner','Primelstr. 34','23873','Meitingen','8-APR-1968','18-JUL-1996','nein','m','ei');
insert into mitarbeiter values (15,'Renate','Sauer','Maubeerstr. 245','32870','Kleineich','30-JUL-1951','1-APR-1988','nein','w','fe');
insert into mitarbeiter values (16,'Josef','Mueller','Westlicher Weg 14','80510','Muenchen','27-OKT-1969','19-FEB-1992','ja','m','ko');
insert into mitarbeiter values (17,'Vanessa','Geiger','Amselweg 4','81309','Muenchen','25-SEP-1954','14-OKT-1988','ja','w','en');
insert into mitarbeiter values (18,'Sigrid','Kanter','Forellenstr. 17','60351','Frankfurt a.M.','12-FEB-1977','1-JAN-1996','ja','w','ku');
insert into mitarbeiter values (19,'Franz','Maler','Hauptstr. 53','93041','Hof','23-NOV-1938','22-AUG-1945','nein','m','en');
insert into mitarbeiter values (20,'Gerhard','Reiter','Braunstr. 14','82561','Großmanching','7-APR-1963','1-MAI-1996','ja','m','ko');
insert into mitarbeiter values (21,'Karl','Fischer','Strandweg 2','20034','Hamburg','3-SEP-1953','2-FEB-1980','ja','m','fe');
insert into mitarbeiter values (22,'Maria','Kleinert','Weizenstr. 67','11452','Berlin','24-JAN-1962','9-APR-1985','ja','w','ge');
insert into mitarbeiter values (23,'Karl','Jaeger','Alsterstr. 89','20851','Hamburg','13-NOV-1917','1-JAN-1950','ja','m','ei');
insert into mitarbeiter values (24,'Siegfried','Meister','Auenstr. 145','11743','Berlin','22-MAI-1969','9-JUN-1989','ja','m','co');
insert into mitarbeiter values (25,'Adalbert','Koenig','Weiherweg 3','21409','Hamburg','13-OKT-1932','10-OKT-1967','ja','m','fe');
insert into mitarbeiter values (26,'Rudolf','Plattner','Baerenstr. 67','61308','Frankfurt a.M.','16-JUN-1973','1-SEP-1996','nein','m','bu');
insert into mitarbeiter values (27,'Herbert','Frenzen','Obermuehle 4','93481','Merten','9-MAI-1949','1-JAN-1992','nein','m','en');
insert into mitarbeiter values (28,'Heinz','Hansen','Hochstr. 35','60411','Frankfurt a.M.','23-NOV-1964','4-MAI-1988','ja','m','ve');
insert into mitarbeiter values (29,'Renate','Schnell','Gaensestr. 23','61423','Melsen','1-APR-1965','1-OKT-1989','nein','w','ve');
insert into mitarbeiter values (30,'Reinhard','Schimmel','Hammelweg 14','60432','Frankfurt a.M.','16-JUL-1958','14-DEZ-1983','nein','m','ve');
insert into mitarbeiter values (31,'Lieschen','Mueller','Neue Gasse','79990','Stuttgart','24-SEP-1965','27-NOV-1986','ja','w','co');
insert into mitarbeiter values (32,'Rudi','Siegel','Allee 9','70467','Stuttgart','14-SEP-1970','18-JAN-1994','ja','m','co');
commit;


create table Gehalt
(
personalnr integer constraint pk_gehalt primary key,
gehalt number(9,2),
provision char(4),
constraint fk_geh_mit foreign key (personalnr) references mitarbeiter(personalnr)
)
;


insert into gehalt values  (1,6480,'ja');
insert into gehalt values  (2,3420,'nein');
insert into gehalt values  (3,3490,'nein');
insert into gehalt values  (4,5890,'nein');
insert into gehalt values  (5,5580,'nein');
insert into gehalt values  (6,5850,'nein');
insert into gehalt values  (7,7320,'ja');
insert into gehalt values  (8,4870,'nein');
insert into gehalt values  (9,14860,'ja');
insert into gehalt values  (10,3780,'nein');
insert into gehalt values  (11,4780,'nein');
insert into gehalt values  (12,8050,'nein');
insert into gehalt values  (13,7340,'nein');
insert into gehalt values  (14,7450,'nein');
insert into gehalt values  (15,5780,'nein');
insert into gehalt values  (16,5835,'nein');
insert into gehalt values  (17,9670,'ja');
insert into gehalt values  (18,5640,'nein');
insert into gehalt values  (19,4580,'nein');
insert into gehalt values  (20,5500,'nein');
insert into gehalt values  (21,4530,'nein');
insert into gehalt values  (22,17830,'ja');
insert into gehalt values  (23,6840,'nein');
insert into gehalt values  (24,8900,'ja');
insert into gehalt values  (25,6780,'ja');
insert into gehalt values  (26,5350,'nein');
insert into gehalt values  (27,5630,'nein');
insert into gehalt values  (28,7890,'ja');
insert into gehalt values  (29,6740,'ja');
insert into gehalt values  (30,6970,'ja');
insert into gehalt values  (31,3750,'nein');
insert into gehalt values  (32,5840,'ja');
commit;


create table fuhrpark
(
wagennr number(2) constraint pk_fuhrpark primary key,
kennzeichen varchar2(15),
hersteller varchar2(30),
modell varchar2(20),
tuev date,
inspektion date
)
;


insert into fuhrpark values (1,'PS - PP 86', 'Alfa Romeo', '146', '15-MAI-2013','1-JUL-2013');
insert into fuhrpark values (2, 'ES - MB 88', 'Mercedes', '190', '1-MAI-2014','1-JUN-2014');
insert into fuhrpark values (3,'PF - DV 158', 'Volkswagen', 'Vento', '15-AUG-2012','1-APR-2012');
insert into fuhrpark values (4,'WT - DV 96', 'Honda', 'Accord', '15-SEP-2013','1-AUG-2013');
insert into fuhrpark values (5,'ES - P 3525', 'Audi', 'S3', '15-APR-2013','1-OKT-2013');
insert into fuhrpark values (6,'S - EX 666', 'Porsche', '911', '15-DEZ-2013','1-NOV-2012');
commit;


create table wagenverleih
(
verleihnr number(4) constraint pk_wagenverleih primary key,
wagennr number(2),
personalnr integer,
km number(4),
datum date,
constraint fk_wag_mit foreign key (Personalnr) references mitarbeiter(personalnr),
constraint fk_wag_fuh foreign key (wagennr) references fuhrpark(wagennr)
)
;


insert into wagenverleih values (1,4, 17, 75, '23-APR-2011');
insert into wagenverleih values (2,3, 22, 35, '17-MAI-2012');
insert into wagenverleih values (3,1, 4, 77, '1-MÄRZ-2011');
insert into wagenverleih values (4,2, 4, 102, '31-JAN-2011');
insert into wagenverleih values (5,3, 4, 79, '21-FEB-2011');
insert into wagenverleih values (6,2, 10, 87, '15-JAN-2011');
insert into wagenverleih values (7,1, 8, 97, '17-JAN-2011');
insert into wagenverleih values (8,1, 4, 22, '24-JAN-2011');
insert into wagenverleih values (9,4, 4, 11, '19-MÄRZ-2011');
insert into wagenverleih values (10,3, 11, 7, '14-DEZ-2012');
insert into wagenverleih values (11,1, 4, 17, '16-NOV-2012');
insert into wagenverleih values (12,2, 4, 57, '21-OKT-2012');
insert into wagenverleih values (13,2, 20, 77, '21-APR-2011');
insert into wagenverleih values (14,2, 4, 74, '31-DEZ-2012');
insert into wagenverleih values (15,1, 31, 70, '14-FEB-2011');
insert into wagenverleih values (16,5, 4, 67, '17-DEZ-2012');
insert into wagenverleih values (17,1, 27, 55, '14-JAN-2011');
commit
/
