-- qs1 :

select c.NomC from Chef c, Restaurant r, Service s
where c.numc = s.numc and
      s.numr = r.numr and
      r.adresse like '%oran%';

-- qs2 :
create view nbr_serv_per_chef as 
select numC, count(*) nbr_ser from service
group by numC

create view max_nbr_serv as
select max(nbr_ser) max_serv from nbr_serv_per_chef

select nomC from chef
where numC = (
    select numC, count(*) nbr_ser from service
    group by c.numC
    having nbr_ser = ( select max_serv from max_nbr_serv )
);
-- OR :

select nomC from chef c, nbr_serv_per_chef v
where c.numC = v.numC and 
      v.nbr_ser = (
         select max(nbr_ser) max_serv from nbr_serv_per_chef
      );



-- qs3 :

-- no, the view was created using group by, and aggregation functions

-- qs4 :

create view v1 as
select * from Chef c, Restaurant r, Service s
where c.numc = s.numc and
      s.numr = r.numr and
      r.adresse like '%oran%';

select numC, nomC from v1