CREATE DATABASE Entreprise;
USE Entreprise;

CREATE TABLE Departements (
    DNO INT PRIMARY KEY,
    DNOM VARCHAR(50),
    DIR VARCHAR(50),
    VILLE VARCHAR(50)
);

CREATE TABLE Employes (
    ENO INT PRIMARY KEY,
    ENOM VARCHAR(50),
    PROF VARCHAR(50),
    DATEEMB DATE,
    SAL DECIMAL(10,2),
    COMM DECIMAL(10,2),
    DNO INT,
    FOREIGN KEY (DNO) REFERENCES Departements(DNO)
);

# Fake Data : 
INSERT INTO Departements (DNO, DNOM, DIR, VILLE) VALUES
(1, 'Production', 'KARIM', 'Alger'),
(2, 'Finance', 'NADIA', 'Oran'),
(3, 'Informatique', 'SAMIR', 'Constantine'),
(4, 'RH', 'AMEL', 'Alger'),
(5, 'Marketing', 'YACINE', 'Oran'),
(6, 'Logistique', 'FARID', 'Annaba'),
(7, 'Ventes', 'LAMIA', 'Blida'),
(8, 'Qualité', 'HOCINE', 'Setif'),
(9, 'Maintenance', 'RACHID', 'Tlemcen'),
(10, 'Recherche', 'SOUAD', 'Bejaia');

INSERT INTO Employes (ENO, ENOM, PROF, DATEEMB, SAL, COMM, DNO) VALUES
(1, 'BENSALAH', 'Technicien', '2015-03-10', 45000, NULL, 1),
(2, 'AMRANI', 'Comptable', '2018-06-22', 60000, 5000, 2),
(3, 'KHELIFI', 'Developpeur', '2020-01-15', 75000, NULL, 3),
(4, 'ZAIDI', 'Manager', '2012-09-05', 90000, 10000, 5),
(5, 'BOUAZIZ', 'RH', '2019-11-30', 55000, NULL, 4),
(6, 'MERABET', 'Commercial', '2017-04-18', 50000, 8000, 7),
(7, 'TOUMI', 'Ingenieur', '2016-12-01', 85000, NULL, 10),
(8, 'GHERBI', 'Technicien', '2021-02-14', 40000, NULL, 9),
(9, 'BOUTERAA', 'Comptable', '2014-07-19', 62000, 4000, 2),
(10, 'HADDAD', 'Developpeur', '2022-05-09', 70000, NULL, 3);

#1)
create view Employes_comm as
select * from Employes
where comm;

#2) 
create view employes_emploie_sal as
select enom, prof, sal from employes
order by prof , sal desc;

#3)
select avg(sal) from Employes_comm;

#4)
# create view or not ?
select avg(e.sal) as avg_production
from employes as e, departements as d
where e.dno = d.dno and
    dnom = "production";

#5)
# create view or not ?
select PROF, max(sal) from employes
group by PROF;

#6)
# create view or not ?
select prof, avg(sal) as sal_moy from employes
group by prof
order by avg(sal)
limit 1;

#7)
-- WRONG : name the employees !!
# sans view :
select prof, avg(sal) as sal_moy from employes
group by prof
order by avg(sal)
limit 1;
-- WRONG : name the employees !!
#avec view :
select prof, avg(sal) as sal_moy from employes_emploie_sal
group by prof
order by avg(sal)
limit 1;