
-- qs1 :
create or replace trigger new_prel
after insert on Prelevement
for each row
begin
  DBMS_OUTPUT.PUT_LINE('un nouveau prelevement est ajouté');
end;


INSERT INTO Prelevement (NumPr, NumP, DatePr, TypePr)
VALUES (14, 1, TO_DATE('07/02/2022','DD/MM/YYYY'), 'Sanguin');

select * from Prelevement


-- qs2 :

create or replace trigger new_effec_prel
after insert on EffectuePrelevement
for each row
begin
  DBMS_OUTPUT.PUT_LINE('le biologiste vient d''effectuer un prelevement');
end;


SET SERVEROUTPUT ON;

INSERT INTO EffectuePrelevement (NumB, NumP, NumPr)
VALUES (3, 1, 1);


-- qs3 :

create or replace trigger test_prel
before insert on Prelevement
for each row
declare 
    is_there number;
begin
  select count(*) into is_there from patient where nump = :new.nump;
  if is_there = 0 then
    raise_application_error(-20001, 'on ne peut pas insere');
  end if;
end;

INSERT INTO Prelevement (NumPr, NumP, DatePr, TypePr)
VALUES (14, 999, TO_DATE('07/02/2022','DD/MM/YYYY'), 'Sanguin');

-- qs 4 :

ALTER TABLE Biologiste
ADD total_prelevements NUMBER DEFAULT 0;

alter table biologiste
drop column total_prelevements

select * from Biologiste


update Biologiste b
set total_prelevements = (
    select count(*) from effectueprelevement ep where b.numB = ep.numB
);

create or replace trigger qs4
after insert on effectueprelevement
for each row
begin
    update Biologiste 
      set total_prelevements = total_prelevements + 1
      where numb = :new.numb;
end;

select * from EffectuePrelevement
select * from biologiste

INSERT INTO EffectuePrelevement (NumB, NumP, NumPr)
VALUES (6, 6, 9);


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

create or replace trigger qs5
after insert on resultat
for each row
begin
    insert into Historique_Analyses (DateEnregistrement, NumPr, NumB, Conclusion)
    select sysdate, :new.NumPr, e.NumB, :new.Conclusion
    from EffectuePrelevement e
    where e.NumPr = :new.NumPr;
end;

INSERT INTO Resultat (NumR, NumPr, TypeResultat, Resul, Norme, Conclusion)
VALUES (15, 7, 'CRP', '12', '0 à 6', 'Inflammation');