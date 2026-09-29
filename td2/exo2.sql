CREATE DATABASE Gastronomie;
USE Gastronomie;

CREATE TABLE Chef (
    NumC INT PRIMARY KEY,
    NomC VARCHAR(50),
    Age INT,
    Pays VARCHAR(50),
    SpecialiteCulinaire VARCHAR(50),
    etoilesC INT
);

CREATE TABLE Restaurant (
    NumR INT PRIMARY KEY,
    NomR VARCHAR(50),
    Adresse VARCHAR(100),
    etoilesR INT
);

CREATE TABLE Service (
    NumC INT,
    NumR INT,
    Date DATE,
    PRIMARY KEY (NumC, NumR),
    FOREIGN KEY (NumC) REFERENCES Chef(NumC),
    FOREIGN KEY (NumR) REFERENCES Restaurant(NumR)
);

INSERT INTO Chef (NumC, NomC, Age, Pays, SpecialiteCulinaire, etoilesC) VALUES
(1, 'MERABET', 45, 'Algeria', 'Italienne', 3),
(2, 'BOUTERAA', 38, 'France', 'Française', 4),
(3, 'ZAIDI', 50, 'Maroc', 'Orientale', 5),
(4, 'HADDAD', 33, 'Algeria', 'Japonaise', 2),
(5, 'KHELIFI', 41, 'Tunisie', 'Française', 3),
(6, 'GHERBI', 29, 'Algeria', 'Orientale', 1),
(7, 'AMRANI', 36, 'France', 'Italienne', 4),
(8, 'BENSALAH', 55, 'Algeria', 'Française', 5),
(9, 'NAIM', 47, 'Maroc', 'Japonaise', 2),
(10, 'BOUAZIZ', 39, 'Algeria', 'Italienne', 3);

INSERT INTO Restaurant (NumR, NomR, Adresse, etoilesR) VALUES
(1, 'Le Gourmet', '1 Rue d\'Alger', 3),
(2, 'Chez Nadia', '12 Rue Oran', 4),
(3, 'Oriental Palace', '5 Rue Oran', 5),
(4, 'Sushi World', '10 Rue Constantine', 3),
(5, 'La Belle France', '3 Rue Alger', 4),
(6, 'Italiana', '7 Rue Bejaia', 3),
(7, 'Casa Marocaine', '2 Rue Oran', 4),
(8, 'La Table', '8 Rue Blida', 2),
(9, 'Zen Cuisine', '15 Rue Oran', 3),
(10, 'Le Délice', '20 Rue Annaba', 4);

INSERT INTO Service (NumC, NumR, Date) VALUES
(1, 1, '2026-01-05'),
(2, 2, '2026-01-06'),
(3, 2, '2026-01-06'),
(4, 3, '2026-01-07'),
(5, 3, '2026-01-08'),
(6, 4, '2026-01-09'),
(7, 5, '2026-01-10'),
(8, 6, '2026-01-11'),
(9, 7, '2026-01-12'),
(10, 9, '2026-01-13'),
(1, 2, '2026-01-14'),  -- Chef 1 also works in Oran
(1, 3, '2026-01-15'),  -- Chef 1 works in all Oran restaurants (2,3,7,9)
(1, 7, '2026-01-16'),
(1, 9, '2026-01-17'),
(2, 9, '2026-01-18');  -- Chef 2 works in some Oran restaurants

#1)
select c.numc, c.nomc, r.adresse from Chef as c, Restaurant as r, Service as s
where c.numc = s.numc and
    s.numr = r.numr and
        lower(r.adresse) like "%oran%";

#2)
create view v1 as
select c.numc, count(*) as chef_max_res from Chef as c, Service as s 
where c.numc = s.numc
group by c.numc ; # nomc didn't work

#3) yes, because chefs can change restaurants they're working for

#4) 
select c.numc, c.nomc, r.adresse from Chef as c, Restaurant as r, Service as s
where c.numc = s.numc and s.numr = r.numr and lower(r.adresse) like "%oran%";

