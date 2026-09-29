-- Active: 1775318044038@@localhost@1521@XE@SYSTEM

-- qs1 :
  -- create users :
  CREATE USER agent1 IDENTIFIED BY pwd1;
  CREATE USER agent2 IDENTIFIED BY pwd2;

  -- connect them to current connection :

  GRANT CREATE SESSION TO agent1;
  GRANT CREATE SESSION TO agent2;

  -- assign privileges :

  grant select on film to agent1;
  grant select, insert, update, delete on film to agent2;
  grant select, insert, update, delete on Personne to agent2;


-- qs2 :

create or replace function get_recent_film(num_person number) return number IS
  recent_year number;
begin
  select max(annee) into recent_year from Film where idrealisateur = num_person;
  return recent_year;
end;

-- test with id 4 :
SELECT get_recent_film(4) AS latest_film_year FROM dual;

-- qs3 :
  -- a
  create or replace trigger val_film
  before insert on genrefilm
  for each row
  declare
    nbr_genre_per_film number;
  begin
    select count(*) into nbr_genre_per_film from genrefilm where idfilm = :new.idfilm;
    if nbr_genre_per_film >= 5 then
    raise_application_error(-20001, 'a film cannot have more than 5 categories');
    end if;
  end;
  
  -- b :
  create or replace trigger val_role
  before insert on rolefilm
  for each row
  declare
    is_he_director number;
  begin
    select count(*) into is_he_director from film 
    where idfilm = :new.idfilm and
        idrealisateur = :new.idacteur;
    
    if is_he_director = 1 then
        raise_application_error(-20001, 'an actor cannot be a director in the same film');
    end if;
  end;
  
  -- testing :
  
  INSERT INTO RoleFilm (idacteur, idfilm, personnage) 
VALUES (4, 2, 'Protagonist');
  
  select * from film;
  
  
  -- c :
  create or replace trigger film_year_val
  before insert or update on film
  for each row
  declare
    year number;
  begin 
    year := :new.annee;
    if year > extract(year from SYSDATE) then 
        raise_application_error(-20001, 'a film year, cannot be bigger han current year');
    end if;
  end;
  
INSERT INTO Film (idfilm, titre, annee, description, idrealisateur)
VALUES (10, 'Future Movie', 2030, 'Sci-Fi epic', 1);  
