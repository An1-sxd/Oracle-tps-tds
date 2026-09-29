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

-- qs1 :

create view v1 as
select * from employes
where comm

-- qs2:

create or replace view v2 as
select enom, prof, sal from employes
order by prof , sal desc;

-- qs3 :

select avg(sal) from Employes_comm;

-- qs4 :

create or replace view v4 as
select avg(sal) from Employes e, Departements d
where d.DNO = e.DNO and
      d.dnom like 'production'

-- qs5 :

create view v5 as
select prof, max(sal) from employes
group by prof

-- qs6 :

create view v6 as
select prof, avg(sal) avg_sal from employes
group by prof
order by avg_sal
fetch first 1 rows only

-- or:

CREATE VIEW V_PROF_AVG AS
SELECT PROF, AVG(SAL) AS sal_moy
FROM Employes
GROUP BY PROF;

SELECT * FROM V_PROF_AVG
WHERE sal_moy = (
    SELECT MIN(sal_moy)
    FROM V_PROF_AVG
);

-- qs7 :


