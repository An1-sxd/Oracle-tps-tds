
-- exo2 :

create or replace trigger val_student
before insert on students
for each row
declare
    counter numeric;
begin
    select count(*) into counter from students
    where nomE = :new.nomE and prenomE = :new.prenomE;
    
    if counter != 0 then
        raise_application_error(-20001, 'this student already exists');
    end if;
end;

--------------------------
-- exo2 :

create or replace trigger student_val
before insert on Students
for each row
declare
    exist int;
begin
    select count(*) into exist from Students
    where nom = :new.nom and prenom = :new.prenom;
    if exist > 0 then
        raise_application_error(-20001, 'this student already exists');
    end if;
end;



select * from students


create table students(
    nom varchar2(10),
    prenom varchar2(10)
)

insert into students values (
    'samer', 'anis'
)
insert into students values (
    'samer2', 'anis2'
)

select * from students















