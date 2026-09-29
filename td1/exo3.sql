
-- qs1 : 

select personne from emprunt
where livre like ' Recueil d’examen BD';

-- qs2 :

select personne from emprunt 
where personne not in (
    select personne from retard
);

-- qs3 :

select personne, count(distinct livre) nbr_livre from emprunt
group by personne
having nbr_livre = (
    select count(distinct livre) nbr_total_livre from emprunt
);

-- qs4 :

select livre, count(distinct personne) nbr_personne from emprunt
group by livre
having nbr_personne = (
    select count(distinct personne) nbr_total_personne from emprunt
);

-- qs5 :

select e.ersonne from emprunt e
group by e.personne
having count(*) = (
    select count(*) from retard r
    where e.personne = r.personne
)





















-- qs1 :

select personne from EMPRUNT
where livre like 'Recueil d’examen BD';


-- qs2 :

select personne from Emprunt
where Personne not in (
    select personne from Retard
);

-- qs3 :

-- WRONG
select personne from Emprunt
where livre in (
    select distinct livre from Emprunt
);

-- CORRECT :
SELECT personne
FROM Emprunt
GROUP BY personne
HAVING COUNT(DISTINCT livre) = (
    SELECT COUNT(DISTINCT livre)
    FROM Emprunt
);

-- qs4 :

-- WRONG :
select distinct livre from Emprunt;

-- CORRECT :
SELECT livre
FROM Emprunt
GROUP BY livre
HAVING COUNT(DISTINCT personne) = (
    SELECT COUNT(DISTINCT personne)
    FROM Emprunt
);


-- qs5 :









