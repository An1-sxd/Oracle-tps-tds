use tp1;

select * from biologiste;

# 1)
create view ListeBiologistes as
select NumB, Nom, Prenom from biologiste;

select * from ListeBiologistes;

# 2)
insert into Biologiste (NumB, Nom, Prenom, Specialite, RoleB) values
(11,'Saadi','Amine', 'Biologie', 'Aide-laboratoire');

select * from Biologiste;
select * from ListeBiologistes;

# comment : modifying the table, will also modify its view (depends on view definition)

# 3)
create view ListeNomsBiologistes as 
select Nom, Prenom from biologiste;

select * from ListeNomsBiologistes;

# 4)
create view PreBiologiste as 
select NumPr, count(NumB) as NbBio from effectueprelevement
group by NumPr;

select * from PreBiologiste;

# 5)
insert into EffectuePrelevement (NumB, NumPr, NumP) values
(11, 4, 3),
(11, 12, 9);

select * from effectueprelevement;
select * from PreBiologiste;

# comment : same thing, view changed also

# 6) prelevements that have minimum number of biologistes ??
select NumPr, NbBio from PreBiologiste
where NbBio = (
	select min(NbBio) from PreBiologiste
);

# 6) biologists that have minimum number of prelevements ??

create view v6 as
select numB, count(numP) as NbPre from effectueprelevement
group by numB;

select b.numB, b.nom from v6 v, biologiste b
where b.numB = v.numB and
	  nbpre = (
		  select min(nbpre) from v6
	  );
        
select * from v6;
select * from biologiste;

# 7)


DELETE FROM EffectuePrelevement
WHERE numB = 11;

DELETE FROM Biologiste
WHERE numB = 11;


# ________________________________________________

# 8)
insert into ListeBiologistes values
(12, 'Rabhi', 'Smail');

select * from listebiologistes;
select * from biologiste;

# comment : yes, the row is added, with null value in columns that were not in listeBiologistes view

# 9)
# modification :
update ListeBiologistes
set Nom = 'Rabhi2'
where NumB = 12;

select * from listebiologistes;
select * from biologiste;

# suppression :
delete from ListeBiologistes
where NumB = 12;

# 10)
insert into ListeBiologistes (Nom, Prenom) values
('Boukhari', 'Ryma');

# error !!!!!!
# we must include primary key ! since it's a ((constraint)) in ((biologiste)) table

# 11)
create table EffectuePrelevement2 (
    NumB INT,
    NumP INT,
    NumPr INT,
    # PRIMARY KEY (NumB, NumPr),
    FOREIGN KEY (NumB) REFERENCES Biologiste(NumB) ON DELETE CASCADE,
    FOREIGN KEY (NumP) REFERENCES Patient(NumP),
    FOREIGN KEY (NumPr) REFERENCES Prelevement(NumPr)
);

# 12)
insert into EffectuePrelevement2
select NumB, NumP, NumPr
from EffectuePrelevement;

select * from EffectuePrelevement2;

# 13)
Create View VBiologiste as
select NumB from EffectuePrelevement2
group by NumB;

select * from VBiologiste;

# 14)
insert into VBiologiste values
(13),(09);

# error !!
# grouped view are read-only : no delete / modify / insert

# 15)
Create Or Replace view VBiologiste as
select NumB, count(*)
from EffectuePrelevement2
group by NumB;

select * from VBiologiste;
select * from EffectuePrelevement2;
# groups EffectuePrelevement2 by numB , and counts number of prelevements per biologiste
# yes, the count is true, but it's better to name the count column

Create Or Replace view VBiologiste as
select NumB, count(*) as NbPre
from EffectuePrelevement2
group by NumB;

# 16)
insert into vbiologiste values
(18, 3),
(10, 2);

# error !! views that uses group by / aggregation are not updatable

# 17)
insert into PreBiologiste values
(13,2);

# same here ! we got error !! because views that uses group by / aggregation are not updatable

# 18)
create or replace view testJoin as
select r.TypeRes, pr.NumPr, pr.typePr from Resultat as r, Prelevement as pr
where r.NumPr = pr.NumPr;

select * from testJoin;

insert into testJoin (TypeRes, NumPr, typePr) values
("Covid",14,15)

# a view created using join (referenced by 2 tables !!) is not updatable !