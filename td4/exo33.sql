

-- qs4 :

-- must have table vehicule // insert vehicule 111
-- must have table locations // insert location 1058
-- table clients already there // insert client

insert into table(select c.location/*column name*/ from clients c where c.numClient = 102)
values (
        select ref(loc) from locations loc/*table name*/ where loc.numLcoc = 1058
);


-- qs5 :

select deref(v.agence).nom from vehicule v
where treat(value(v) as T_VehiculeImmatricule).modele like 'PEUGEOT NEW 208'

