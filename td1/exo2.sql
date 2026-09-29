select * from EMP;

create table REG(
    noReg varchar2(10) primary key,
    nom varchar2(10),
    vill varchar2(10)
)

create table DEPT(
    noDept varchar2(10) primary key,
    nom varchar2(10),
    noReg varchar2(10),
    foreign key noReg refrences REG(noReg)
)

create table EMP(
    noEmp varchar2(10) primary key,
    nom varchar2(10),
    prenom varchar2(10),
    titre varchar2(10),
    noDept varchar2(10),
    salaire Number,
    
    foreign key noDep refrences DEPT(noDept)    
)

-- part1 :

-- qs1 : 

select p.nom, p.prenom, r.nom from emp e, dept d, reg r
where p.nodept = d.nodept and
    d.noregion = r.noreg

-- qs2 :

select d.nodept, d.nom, e.nom from dept d, emp e
where e.nodept = d.nodept
order by nodept

-- qs4 :

select nom, prenom, salaire from emp
where salaire > (
    select min(salaire) from emp
    where nodept = 31
)

-- qs5 :

select nom, prenom, salaire from emp
where salaire > (
    select min(salaire) from emp
    where nodept = 31
)
order by nodept, salaire

-- qs6 :

select e1.nom, e1.nodept, e1.salaire from emp e1
where e1.salaire > (
    select avg(e2.salaire) from emp e2
    where e1.nodept = e2.nodept
)
order by nodept
















-- qs1 :

select e.nom, e.prenom, r.nom from EMP e, DEPT d, REG r
where e.noDept = d.noDept and
      d.noRegion = r.noReg



-- qs2 :

select d.noDept, d.nom, e.nom from EMP e, DEPT d
where e.noDept = d.noDept
order by d.noDept

-- qs3 :

select nom, salaire from EMP
where salaire > (
    select salaire from EMP
    where nom like 'patron'
)

-- qs4 :

select nom, salaire from EMP
where salaire > (
    select max(salaire) max_sal from EMP
    where noDept = 31
)


-- qs5:

select nom, salaire from EMP
where salaire > (
    select min(salaire) min_sal from EMP
    where noDept = 31
)
order by numDept, salaire;


-- qs6 :

-- WRONG
select e.noDept, e.nom, e.salaire from EMP e
where e.salaire > (
    select avg(salaire) avg_sal_per_dept from EMP em
    group by noDept
    having em.noDept = e.noDept
)
order by noDept

-- CORRECT

select e.noDept, e.nom, e.salaire from EMP e
where e.salaire > (
    select avg(salaire) avg_salaire_per_dept from EMP em
    where em.noDept = e.noDept
)
order by noDept;



-- part2 :

-- b:

alter table reg
add column (nd, int);

-- fill it :

update table reg r
set nd = (
    select count(*) nbr_dept_par_reg from dept d
    where r.noreg = d.noreg
)

-- c:

alter table reg
rename column ville to wilaya;

-- d:

insert into dept values(
    05, 'logitique', 31
)























-- qs2 :

alter table REG
add column (ND, number)

-- WRONG
update REG r
set ND = (
    select count(*) nbr_dept_par_reg from DEPT d
    group by d.noReg
    having d.noReg = r.noReg
)

-- CORRECT
update REG r
set ND = (
    select count(*) nbr_dept_par_reg from DEPT d
    where d.noReg = r.noReg
)


-- qs3 :

alter table REG
rename column ville to wilaya

-- qs4 :

insert into dept values(
    '05', 'logistique', '31'
)








