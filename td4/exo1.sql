-- exo1: 

CREATE or replace TYPE T_Musee AS OBJECT (
    Nom VARCHAR2(20),
    JourFermeture VARCHAR2(15)
);


CREATE or replace TYPE T_Menu AS OBJECT (
    Nom VARCHAR2(20),
    Prix NUMBER(2)
);

-- qs1 :
CREATE or replace TYPE T_MenuS AS VARRAY(3) OF T_Menu;

CREATE or replace TYPE T_Restaurant AS OBJECT (
    Nom VARCHAR2(30),
    Adresse VARCHAR2(50),
    ListMenu T_MenuS
);

-- qs2 :
CREATE or replace TYPE T_RestaurantS AS table OF T_Restaurant;
CREATE or replace TYPE T_MuseeS AS table OF T_Musee;

CREATE or replace TYPE T_Ville AS OBJECT (
    Nom VARCHAR2(30),
    Musees T_MuseeS,
    Restaurants T_RestaurantS
);


-- qs3 :
CREATE TABLE Ville OF T_Ville
NESTED TABLE Restaurants STORE AS tab_Restaurants,
NESTED TABLE Musees STORE AS tab_Musees;
    
-- qs from gpt : 

select column_value from ville v, table(v.musees)

-- qs1 : 

insert into Ville values (
    'Alger', T_MuseeS(T_Musee('Bardo','Monday')) , 
    T_RestaurantS(T_Restaurant('Le Gourmet','Centre',T_menuS( T_menu('Menu1', 10), T_menu('Menu2', 15), T_menu('Menu3', 20) ) ) ) 
);
-- note : use 👉 constructors for : object types / collection types (as varray + as table of)

-- qs2 : 

select v.nom, m.nom  from ville v, table(musees) m;

-- note : access to inside collection ! using // ; 👉 table() //

-- qs3 :

select v.nom, r.nom  from ville v, table(v.restaurants) r;

-- qs4 :

select v.nom, r.nom, me.nom  from ville v, table(v.restaurants) r, table(r.listmenu) me;

-- qs5 :

select v.nom, r.nom
from ville v, table(v.restaurants) r
where r.nom like 'Le Gourmet';

-- qs6 :

select v.nom, me.nom 
from ville v, table(v.restaurants) r, table(r.listmenu) me
where me.prix > 15;

-- qs7 : updating inside varray

-- update table(select r.listmenu from ville v, table(v.restaurants) r)
-- set price = 25
-- where nom like 'menu1';
---- would work if menus was a nested table !!!!!!

-- tricky : updating inside varray is hard / but inside nested table is possible
-- updating them themselves is easy ! exo2 qs7-qs8

select * from ville;

-- qs8 : 

insert into the(select v.musees from ville v where v.nom = 'Alger')
values (T_musee('Louvre DZ', 'friday'));

INSERT INTO TABLE(
    SELECT v.musees
    FROM Ville v
    WHERE v.nom = 'Alger'
)
VALUES (Musee('Louvre DZ', 'Friday'));

-- test delete :
delete from table(
    SELECT v.musees
    FROM Ville v
    WHERE v.nom = 'Alger'
    )
where nom = 'Louvre DZ';

-- table() == the()   ???? with nested tables only ? or also varrays

-- qs9 :

update table(select v.restaurants from ville v where v.nom like 'Alger')
set listmenu = T_menus(T_menu('menu11', 11),T_menu('menu22', 22),T_menu('menu33', 33));

-- verify :
select me.nom, me.prix from table(select v.restaurants from ville v where v.nom = 'Alger') r, table(r.listmenu) me;


-- qs10 :

delete from ville where nom = 'Alger';

select * from ville;

-- get it back

-- qs11 :

delete from table(select restaurants from ville where nom like 'Alger') r
where r.nom = 'Le Gourmet';

select r.nom from table(select restaurants from ville where nom like 'Alger') r;

-- qs12 :

-- delete from table(select listmenu from ville v, table(v.restaurants) r) me
-- where me.price < 12

-- qs13 :

SELECT v.nom
FROM Villes v
WHERE NOT EXISTS (
    SELECT 1
    FROM TABLE(v.restaurants) r,
         TABLE(r.menus) m
    WHERE m.prix <= 10
);

-- qs14 :

-- didn't work .. idk

-- qs15 :

select v.nom, m.nom, m.jourfermeture, r.nom, me.nom, me.prix 
from ville v, table(v.restaurants) r, table(v.musees) m, table(r.listmenu) me

--- group by is important when working with many villes ..