-- qs1 : a
create type T_Biologiste;

create type T_Patient;

create type T_Prelevement;

create type T_Resultat;

-- create type T_EffectuePrelevement;

-- qs1 : b

CREATE OR REPLACE TYPE T_Biologiste AS OBJECT (
    NumB        NUMBER,
    Nom         VARCHAR2(30),
    Prenom      VARCHAR2(30),
    Specialite  VARCHAR2(50),
    RoleB       VARCHAR2(30)
);

CREATE OR REPLACE TYPE T_Patient AS OBJECT (
    NumP            NUMBER,
    Nom             VARCHAR2(30),
    Prenom          VARCHAR2(30),
    DateNaissance   DATE
);

create or replace type T_BiologisteS as table of ref T_Biologiste

CREATE OR REPLACE TYPE T_Prelevement AS OBJECT (
    NumPr           NUMBER,
    DatePr          DATE,
    TypePr          VARCHAR2(30),
    Patient         REF T_Patient,
    ListBiologistes     T_BiologisteS
);

CREATE OR REPLACE TYPE T_Resultat AS OBJECT (
    NumR            NUMBER,
    TypePr          VARCHAR2(30),
    Resul           VARCHAR2(100),
    Norme           VARCHAR2(100),
    Conclusion      VARCHAR2(200),
    RefPrelevement  REF T_Prelevement
);
drop table Resultats force

CREATE TABLE Biologistes OF T_Biologiste (
    CONSTRAINT PK_Biologistes PRIMARY KEY (NumB)
)
CREATE TABLE Patients OF T_Patient (
    CONSTRAINT PK_Patients PRIMARY KEY (NumP)
)
CREATE TABLE Prelevements OF T_Prelevement (
    CONSTRAINT PK_Prelevements PRIMARY KEY (NumPr)
)
nested table listbiologistes store as tab_listbiologistes

CREATE TABLE Resultats OF T_Resultat (
    CONSTRAINT PK_Resultats PRIMARY KEY (NumR)
)

select * from Patients

-- qs3 :
insert into Biologistes values(1, 'Ait', 'Karim', 'Hématologie', 'Analyste');
insert into Biologistes values(2, 'Madi', 'Sara', 'Biochimie', 'Responsable');
insert into Patients values(10, 'Bensaid', 'Mohamed', to_date('15/03/1980','dd/mm/yyyy'));

insert into prelevements values(
    501,
    to_date('20/04/2026 ','dd/mm/yyyy'),
    'Sanguin',
    (select ref(p) from patients p where nom = 'Bensaid'),
    T_BiologisteS((select ref(b) from biologistes b where nom ='Ait'),(select ref(b) from biologistes b where nom ='Madi'))
);


-- qs4 :
create type T_ntelephone as object (
    Libelle varchar2(10),
    numero varchar2(10)
)
create type T_ntelephoneS as table of T_ntelephone;

alter type T_Biologiste add attribute (listTelephones T_ntelephoneS) cascade; -- modify table which is using this type

--ALTER TABLE Biologistes
--MODIFY NESTED TABLE listTelephones STORE AS tab_listTelephones;

insert into Biologistes values(
    3,
    'Samer',
    'Anis',
    'Hématologie',
    'Analyste',
    T_ntelephoneS(T_ntelephone('domicile','0661234567'))
);

select * from Biologistes
    
update Biologistes 
set listTelephones = T_ntelephoneS(T_ntelephone('bureau','0661234567'))
where nom = 'Samer'

-- qs5 :
create type T_PrelevementRefs as table of ref t_prelevement

alter type T_Biologiste
add member function MesPrelevements
return T_PrelevementRefs

alter type T_Biologiste
add member function MesPrelevements
return T_PrelevementRefs
is 
 --
begin
 --
end
 

-- qs6 / a :

select pr.numpr, deref(b.column_value).nom as nom, deref(b.column_value).prenom as prenom
from prelevements pr,table(pr.listbiologistes) b
where cardinality(pr.listbiologistes) >= 2


-- qs6 / b :

create or replace view patientsView as
select nump from patients

select * from patientsView

select * from prelevements

select * from biologistes

SELECT b.nom, b.nom
FROM Biologistes b
WHERE NOT EXISTS (
    SELECT 1
    FROM Patients p
    WHERE NOT EXISTS (
        SELECT 1
        FROM Prelevements pr, table(pr.ListBiologistes) lb
        WHERE pr.patient = ref(p)
          and lb.COLUMN_VALUE = ref(b)
    )
);
