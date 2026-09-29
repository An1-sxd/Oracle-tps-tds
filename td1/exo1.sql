/*
qs1+2+3+4+5+6
*/
-- qs1 :

create table biologiste(
    numB int primary key,
    nom varchar2(10),
    prenom varchar2(10),
    specialite varchar2(10),
    roleB varchar2(10)
)
create table patient(
    numP int primary key,
    nom varchar2(10),
    prenom varchar2(10),
    date_n date
)
create table prelevement(
    numPr int primary key,
    numP int,
    datePr date,
    typePr varchar2(10),
    foreign key (numP) references patient(numP)
)
create table EffectuePrelevement(
    numB int,
    numP int,
    numPr int,
    foreign key (numP) references patient(numP),
    foreign key (numB) references biologiste(numB),
    foreign key (numPr) references prelevement(numPr)
)
create table resultat(
    numR int primary key,
    foreign key (numPr) references prelevement(numPr),
    typePr varchar2(10),
    Resul varchar2(10),
    Norme varchar2(10),
    Conclusion varchar2(10)
)

-- not null
-- check (cond)
-- check in ('val1', 'val2', ..)
-- default
-- primary key
-- foreign key

-- qs2
alter table resultat
rename column typeRes to typeResultat
-- qs3
alter table resultat
modify conclusion varchar2(100)


-----

-- qs1 :
select * from bilogiste;

select numB, nom from biologiste
where numB = (
    select max(nbr_pr) max_nbr_pr from (
        select numB, count(*) nbr_pr from effectuePrelevement ef
        group by numB
    )
);

select numB, nom from biologiste
where numB = (
    select min(nbr_pr) max_nbr_pr from (
        select numB, count(*) nbr_pr from effectuePrelevement ef
        group by numB
    )
);

-- qs8 :

select r.numPr, r.typeResultat, r.conclusion, pr.typePr from resultat r, prelevement pr
where lower(typeResultat) like '%covid%' and
    lower(conclusion) like '%positif%' and
    r.numPr = pr.numPr;

-- qs9 :

select p.nom, pr.datePr, extract(year from sysdate) - extract(year from datenaissance) age from patient p, prelevement pr, resultat r
where p.nump = pr.nump and
    pr.numpr = r.numpr and
    lower(typeResultat) like '%covid%' and
    lower(conclusion) like '%positif%' and
    extract(month from pr.datePr) = 2;

-- qs10

select distinct typePr from prelevement











--qs7 : 

select * from effectueprelevement;
select * from biologiste;

select b.nom, b.prenom, b.numB from biologiste b, (
    select numB from effectueprelevement
        group by numB
        having count(*) = (
            select max(nbr_pr) from (
            select count(*) nbr_pr from effectueprelevement
            group by numB
            )
        ) 
) total
where b.numB = total.numB;


-- qs8 :
select * from prelevement;
select * from resultat;


select p.typePr, count(*) nbr_pos from prelevement p, resultat r
where p.numPr = r.numPr and
    r.conclusion like 'Positif' and
    r.typeResultat like 'Covid'
group by p.typePr;


-- qs9 :

select p.nom, pr.typePr, extract(year,pr.datePr) - extract(year,sysdate), r.conclusion from patient p, prelevement pr, resultat r
where p.numP = pr.numP and
    pr.numP = r.numR and
    r.typeResultat like 'Covid' and
    r.conclusion like 'Positif' and
    extract(month from pr.DATEPR ) like 'feb';
    
    
select * from prelevement;

-- qs10 :

select distinct typePr from prelevement




