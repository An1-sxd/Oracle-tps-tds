
-- qs1 :

-- create type T_agence;

create type T_Agence as Object(
    nom varchar2(15),
    ville varchar2(15)
);

create type T_Revision as Object(
    numRev number,
    dateRev date,
    commentaire varchar2(30)
);

create type T_RevisionS as table of ref T_Revision;

create type T_Vehicule as Object(
    numVeh number,
    tarif float,
    dateProchRev date,
    agence ref T_agence,
    revision T_RevisionS
) not final;

create type T_VehiculeImmatricule under T_Vehicule(
    plaqueNum number,
    puissance number,
    modele varchar2(20)
) not final;

create type T_Voiture under T_VehiculeImmatricule(
    kileometrage number,
    kileometrageDerniereRev number
);

-- qs2 :

create type T_Location as Object(
    numLoc number,
    dateDebut date,
    dateFin date,
    vehicule ref T_Vehicule
);

create type T_LocationS as table of ref T_Location;

create type T_Client as Object(
    numClient number,
    nomCl varchar2(20),
    location T_LocationS
);



-- qs3 :

select * from agences;

create table Agences of T_Agence;
create table Clients of T_Client nested table location store as tab_location;

-- qs4 :

create table vehicule of T_vehicule nested table revision store as tab_revision;
create table Location of T_location


-- client kayen deja !
insert into Clients values (
    T_Client(
        102, 
        'Ahmed MESSAOUDI', 
        T_LocationS()
    )
);
-- vehicule n°111 kayna deja !
INSERT INTO Vehicule VALUES (
    111,
    2500,
    TO_DATE('15/06/2026','DD/MM/YYYY'),
    (SELECT REF(a) FROM Agences a WHERE a.nom = 'Toyota Alger'),
    T_RevisionS()
);

-- this location must be existed also :
insert into location values(
    T_location(
        1058,
        TO_DATE('04/09/2024','DD/MM/YYYY'),
        TO_DATE('09/09/2024','DD/MM/YYYY'),
        ( select ref(v) from vehicule v where v.numveh = 111 )
    )
);
-- this if the qs4 :
insert into table(select c.location/*column name*/ from clients c where c.numClient = 102)
values(
    ( select ref(lo) from location/*table name*/ lo
    where lo.numLoc = 1058 )
);

-- qs5 :

-- must have a table of vehicule

select dref(v.agence).nom from vehicule v
where trait(value(v) as (T_VehiculeImmatricule)).modele like 'PEUGEOT NEW 208'

-- vehicule has a ref to agence ! (not an object of agence)
-- so use dref(), to convert it to an object, to be able to access its atts





-- fake data :
select * from agences

INSERT INTO Agences VALUES (T_Agence('Toyota Alger', 'Alger'));
INSERT INTO Agences VALUES (T_Agence('Renault Oran', 'Oran'));
INSERT INTO Agences VALUES (T_Agence('Peugeot Blida', 'Blida'));

select * from vehicule

INSERT INTO Vehicule VALUES (
    T_VehiculeImmatricule(
        112,
        3000,
        TO_DATE('20/06/2026','DD/MM/YYYY'),
        (SELECT REF(a) FROM Agences a WHERE a.nom = 'Renault Oran'),
        T_RevisionS(),
        67890,
        110,
        'Renault Clio'
    )
);
INSERT INTO Vehicule VALUES (
    T_Voiture(
        113,
        4000,
        TO_DATE('10/07/2026','DD/MM/YYYY'),
        (SELECT REF(a) FROM Agences a WHERE a.nom = 'Peugeot Blida'),
        T_RevisionS(),
        54321,
        130,
        'Peugeot 208',
        85000,
        80000
    )
);
INSERT INTO Vehicule VALUES (
    T_Voiture(
        114,
        3500,
        TO_DATE('01/08/2026','DD/MM/YYYY'),
        (SELECT REF(a) FROM Agences a WHERE a.nom = 'Toyota Alger'),
        T_RevisionS(),
        98765,
        95,
        'Toyota Corolla',
        120000,
        115000
    )
);


-- must have a table of revision : (of objects)
create table revision of T_revision;

insert into revision values(T_Revision(1, SYSDATE, 'Vidange'))

INSERT INTO TABLE(
    SELECT v.revision
    FROM Vehicule v
    WHERE v.numVeh = 111
)
VALUES (
    (SELECT REF(r)
     FROM Revision r
     WHERE r.numRev = 1)
);