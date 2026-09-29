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

-- qs1 :

insert into Ville values (
    'Alger',
    T_MuseeS(
        T_Musee('Bardo', 'Monday')
    ),
    T_RestaurantS(
        T_Restaurant(
            'Le Gourmet',
            'Centre',
            T_MenuS(
                T_Menu('Menu1',10),T_Menu('Menu2',15),T_Menu('Menu3',20)
            )
        )
    )
);

select * from Ville;

-- qs2 :

select v.nom, m.nom from ville v, table(v.musees) m;

-- qs3 :

select v.nom, r.nom  from ville v, table(restaurants) r;

-- qs4 :

select v.nom, r.nom, m.nom  from ville v, table(restaurants) r, table(r.listmenu) m;

-- qs5 :

select v.nom, r.nom from ville v, table(restaurants) r
where r.nom like '%Le Gourmet%';

-- qs6 :

select m.nom  from ville v, table(v.restaurants) r, table(r.listmenu) m
where m.prix > 15;

-- qs7 : hard to update, insert inside varray, easy for nested table

-- only if listmenu was a nested table
update table(select r.listmenu from ville v, table(v.restaurants) r) m
set m.prix = 25
where m.nom like 'menu1';

-- qs8 :

insert into table(select v.musees from ville v where v.nom like 'Alger') m values(
    T_Musee('Louvre DZ', 'Thursday')
);
 
select m.* from ville v, table(musees) m;

-- test delete :

delete from table(select v.musees from ville v where v.nom like 'Alger') m 
where m.nom like 'Louvre DZ';

-- qs9 :

update table(select v.restaurants from ville v, table(v.restaurants) r where r.nom like 'Le Gourmet') r
set r.listmenu = T_menus(
                    T_menu('menu1', 10),T_menu('menu2', 15),T_menu('menu3', 20)
                 );
                 
-- qs10 :

delete from ville
where nom like 'Alger';

-- qs11 :

delete from table(select v.restaurants from ville v where v.nom like 'Alger') r
where r.nom like 'Le Gourmet';

-- qs12 :

delete from table(select r.listmenu from ville v, table(v.restaurants)) m
where m.prix < 12;

-- qs13 :

SELECT v.nom
FROM Ville v
WHERE NOT EXISTS (
    SELECT 1
    FROM TABLE(v.restaurants) r,
         TABLE(r.listmenu) m
    WHERE m.prix <= 10
);

----------------------------------------------

-- qs1 :

-- qs2 :

select v.nom, m.nom
from ville v, table(v.musees) m
where v.nom = 'Alger';

-- qs3 :

select v.nom, r.nom
from ville v, table(v.restaurants) r;

-- qs4 :

select m.nom
from ville v, table(v.restaurants) r, table(r.listmenu) m;

-- qs5 :

select v.nom
from ville v, table(v.restaurants) r
where r.nom = 'Le Gourmet';

-- qs6:

select m.nom
from ville v, table(v.restaurants) r, table(r.listmenu) m
where m.prix >= 15;

-- qs7 :

-- qs8 :

insert into table(select v.musees from ville v where v.nom = 'Alger') values(
    'Le Louvre', 'Thursday'
);

select m.* from ville v, table(v.musees) m;

-- qs9:

update table(select v.restaurants from ville v) r
set r.listmenu = T_menuS(
    T_menu('menu1', 5),T_menu('menu2', 10),T_menu('menu3', 15)
)
where r.nom = 'Le Gourmet';

select m.prix from ville v, table(v.restaurants) r, table(r.listmenu) m;

-- qs10:

delete from ville v
where v.nom = 'Alger';

-- qs11 :

delete from table(select v.restaurants from ville v where v.nom = 'Alger') r
where r.nom = 'Le Gourmet';

-- qs12 :

delete from table(select r.listmenu from ville v, table(v.restaurants)) m
where m.prix < 12;

-- qs13 :

-- qs14 :

-- qs15 :

select v.nom, r.nom nomRes, m.* from ville v, table(v.restaurants) r, table(r.listmenu) m


