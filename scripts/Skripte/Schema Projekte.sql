-- als der Benutzer sys führen Sie bitte dieses Skript aus
-- achten Sie darauf, der Benutzer Projekte darf nicht angemeldet sein

connect sys/oradmin as sysdba

drop user projekte cascade;

create user projekte identified by projekte
default tablespace projekte
quota unlimited on projekte
temporary tablespace temp;

grant connect, resource, unlimited tablespace to projekte;

connect projekte/projekte

create table projekte.abteilungen
(
abtnr char(2) constraint pk_abteilungen primary key,
abtname varchar2(15),
stadt varchar2(15)
);


create table projekte.projekte
(
prnr char(2) constraint pk_projekte primary key,
prname varchar2(15),
budget number(9,3)
);

create table projekte.mitarbeiter
(
mnr number(6) constraint pk_mitarbeiter primary key,
mname varchar2(15),
mvorname varchar2(15),
abtnr char(2),
constraint fk_mit_abt foreign key(abtnr) references abteilungen(abtnr)
);

create table projekte.arbeiten
(
mnr numeric(6),
prnr char(2),
aufgabe varchar2(20),
einstiegsdatum date,
constraint pk_arbeiten primary key(mnr, prnr),
constraint  fk_arb_mit foreign key(mnr) references mitarbeiter(mnr),
constraint fk_arb_pro foreign key(prnr) references projekte(prnr)
);

insert into projekte.abteilungen values ('a1', 'Beratung', 'München');
insert into projekte.abteilungen values ('a2', 'Diagnose', 'München');
insert into projekte.abteilungen values ('a3', 'Freigabe', 'Stuttgart');
commit;

insert into projekte.mitarbeiter values (25348,'Keller','Hans','a3');
insert into projekte.mitarbeiter values (10102,'Huber','Petra','a3');
insert into projekte.mitarbeiter values (18316,'Müller','Gabriele','a1');
insert into projekte.mitarbeiter values (29346,'Probst','Andreas','a2');
insert into projekte.mitarbeiter values (9031,'Meier','Rainer','a2');
insert into projekte.mitarbeiter values (2581,'Kaufmann','Brigitte','a2');
insert into projekte.mitarbeiter values (28559,'Mozer','Sibille','a1');
commit;

insert into projekte.projekte values ('p1','Apollo',120000.000);
insert into projekte.projekte values ('p2','Gemini',95000.000);
insert into projekte.projekte values ('p3','Merkur',186500.000);
commit;

insert into projekte.arbeiten values (10102,'p1','Projektleiter','01.10.1988');
insert into projekte.arbeiten values (10102,'p3','Gruppenleiter','01.01.1989');
insert into projekte.arbeiten values (25348,'p3','Sachbearbeiter','15.02.1988');
insert into projekte.arbeiten values (18316,'p2',null,'01.06.1989');
insert into projekte.arbeiten values (29346,'p2',null,'15.12.1987');
insert into projekte.arbeiten values (2581,'p3','Projektleiter','15.10.1989');
insert into projekte.arbeiten values (9031,'p1','Gruppenleiter','15.03.1989');
insert into projekte.arbeiten values (28559,'p1',null,'01.08.1988');
insert into projekte.arbeiten values (28559,'p2','Sachbearbeiter','01.02.1989');
insert into projekte.arbeiten values (9031,'p3','Sachbearbeiter','15.11.1988');
insert into projekte.arbeiten values (29346,'p1','Sachbearbeiter','1.04.1989');
commit
/







