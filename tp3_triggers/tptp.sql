-- qs1 :

set serveroutput on

create or replace trigger verify_pre
after insert on prelevement
for each row
begin
    dbms_output.put_line('Un nouveau prélèvement est ajouté');
end;

-- qs2 :

create or replace trigger verify_pre
after insert on effecuteprelevement
for each row
begin
    dbms_output.put_line('Un biologiste vient d effectuer un prélèvement');
end;

-- qs3 :

create or replace trigger val_pre
before insert on prelevement
for each row
declare
    exist int;
begin
    select count(*) into exist from patient
    where numP = :new.numP;
    if exist = 0 then
        raise_application_error(-20001, 'this patient does not exist');
    end if;
end;

-- qs4 :

-- a :
alter table biologiste
add column (total_prelevement, int);

update table biologiste b
set total_prelevement = (
    select count(*) nbr_pre from effectueprelevement ef
    where ef.numb = b.numb
)

-- b :

create or replace trigger update_on_insert
after insert on biologiste
for each row
begin
    update table biologiste
    set total_prelevement := total_prelevement + 1
    where numb = :new.numb;
end;

-- c :

create or replace trigger update_on_delete
after delete on biologiste
for each row
begin
    update table biologiste
    set total_prelevement := total_prelevement - 1
    where numb = :new.numb;
end;

-- qs5 :

CREATE TABLE Historique_Analyses (
    DateEnregistrement DATE,
    NumPr NUMBER(10),
    NumB NUMBER(10),
    Conclusion VARCHAR2(100),
    CONSTRAINT FK_HIST_PREL FOREIGN KEY (NumPr) REFERENCES Prelevement(NumPr),
    CONSTRAINT FK_HIST_BIO FOREIGN KEY (NumB) REFERENCES Biologiste(NumB)
);

select * from Historique_Analyses


-- go:

create or replace trigger historique_insert
after insert on resultat
for each row
begin
    insert into Historique_Analyses 
        select sysdate, :new.numPr, ef.numB, :new.conclusion from effectueprelevement ef
        where ef.numPr = :new.numPr;
end;








