
select * from biologiste;
select * from patient;
select * from effectueprelevement;
select * from prelevement;

-- qs1 :

create view ListeBiologistes as
select NumB,Nom, Prenom from biologiste

select * from ListeBiologistes;

-- qs2 :

insert into biologiste values (
    11, 'Saadi', 'Amine', 'Biologie','Aide-laboratoire'
)




