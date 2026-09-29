-- qs2 :

create or replace function get_recent_film(id_p number)
return number is
    recent_year number;
begin
    select max(annee) into recent_year from personne p, film f
    where p.idpersonne = f.idrealisateur and
        p.idpersonne = id_p;
    return recent_year;
end;

select get_recent_film(4) from dual;


-- qs3 :

-- a:

create or replace trigger val_film
before insert on genrefilm
for each row
declare
    nbr_genre number;
begin
    select count(*) into nbr_genre from genrefilm
    where idfilm = :new.idfilm;
    
    if nbr_genre >= 5 then
        raise_application_error(-20001, 'this film already has a genre');
    end if;
end;

-- b :

create or replace trigger val_role
before insert on rolefilm
for each row
declare
    estRealisateur number;
begin
    select count(*) into estRealisateur from film
    where idRealisateur = :new.idacteur and
           idfilm = :new.idfilm;
           
    if estRealisateur > 0 then
        raise_application_error(-20001, 'this actor is already a realisater');
    end if;
end;

-- c :

create or replace trigger val_film_2
before insert or update on film
for each row
begin 
    if :new.annee > extract(year from sysdate) then
        raise_application_error(-20001, 'oo hold on a sec, are you leaving in the future ?');
    end if;
end;

INSERT INTO Film (idfilm, titre, annee, description, idrealisateur)
VALUES (10, 'Future Movie', 2030, 'Sci-Fi epic', 1);  


----------------------------------

-- qs1 :

create user agent1 identified by pw1;
create user agent2 identified by pw2;

grant select on film to agent1;
grant select, insert, update, delete on film to agent2 with grant option;
grant select, insert, update, delete on personne to agent2 with grant option;

-- qs2 :

create or replace function annee_recent(id int) return int
is
    annee int;
begin
    select max(f.annee) into annee from personne p, film f
    where p.idpersonne = f.idrealisateur and
        p.idpersonne = id;
    return annee;
end;

-- qs3 :

-- a:
create or replace trigger val_genre
before insert on genrefilm
for each row
declare
    nbr_genre int;
begin
    select count(distinct genre) into nbr_genre from genrefilm
    where idfilm = :new.idfilm;
    if nbr_genre >= 5 then
        raise_application_error(-20001, 'a film cannot have more than 5 diff genres !');
end;

-- b:

create or replace trigger val_role
before insert on rolefilm
for each row
declare
    exist int;
begin
    select count(*) into exist from film
    where idfilm = :new.idfilm
        idrealisateur = :new.idacteur;
    if exist > 0 then
        raise_application_error(-20001, 'this actor, is already the producer of this film !');
    end if;
end;

-- c:

create or replace trigger val_film
before insert on film
for each row
begin
    if :new.annee > extract(year from sysdate) then
        raise_application_error('ooo, hold on a sec, are you leaving in the future ??')
end;





















