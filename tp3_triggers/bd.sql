

-- 1) BIOLOGISTE
CREATE TABLE Biologiste (
  NumB        NUMBER(10)     NOT NULL,
  Nom         VARCHAR2(30)   NOT NULL,
  Prenom      VARCHAR2(30)   NOT NULL,
  Specialite  VARCHAR2(30),
  RoleB       VARCHAR2(40),
  CONSTRAINT PK_BIOLOGISTE PRIMARY KEY (NumB)
);

-- 2) PATIENT
CREATE TABLE Patient (
  NumP           NUMBER(10)    NOT NULL,
  Nom            VARCHAR2(30)  NOT NULL,
  Prenom         VARCHAR2(30)  NOT NULL,
  DateNaissance  DATE          NOT NULL,
  CONSTRAINT PK_PATIENT PRIMARY KEY (NumP)
);

-- 3) PRELEVEMENT
CREATE TABLE Prelevement (
  NumPr   NUMBER(10)    NOT NULL,
  NumP    NUMBER(10)    NOT NULL,
  DatePr  DATE          NOT NULL,
  TypePr  VARCHAR2(30)  NOT NULL,
  CONSTRAINT PK_PRELEVEMENT PRIMARY KEY (NumPr),
  CONSTRAINT FK_PREL_PATIENT FOREIGN KEY (NumP)
    REFERENCES Patient(NumP)
);

-- 4) EFFECTUEPRELEVEMENT (association)
CREATE TABLE EffectuePrelevement (
  NumB  NUMBER(10) NOT NULL,
  NumP  NUMBER(10) NOT NULL,
  NumPr NUMBER(10) NOT NULL,
  CONSTRAINT PK_EFFPREL PRIMARY KEY (NumB, NumPr),

  CONSTRAINT FK_EFF_BIO FOREIGN KEY (NumB)
    REFERENCES Biologiste(NumB),

  CONSTRAINT FK_EFF_PAT FOREIGN KEY (NumP)
    REFERENCES Patient(NumP),

  CONSTRAINT FK_EFF_PREL FOREIGN KEY (NumPr)
    REFERENCES Prelevement(NumPr)
);

-- 5) RESULTAT
CREATE TABLE Resultat (
  NumR       NUMBER(10)     NOT NULL,
  NumPr      NUMBER(10)     NOT NULL,
  TypeRes    VARCHAR2(30)   NOT NULL,
  Resul      VARCHAR2(30),
  Norme      VARCHAR2(40),
  Conclusion VARCHAR2(50),
  CONSTRAINT PK_RESULTAT PRIMARY KEY (NumR),
  CONSTRAINT FK_RES_PREL FOREIGN KEY (NumPr)
    REFERENCES Prelevement(NumPr)
);  

INSERT INTO Biologiste VALUES (1,'BADI','Salim','Microbio','Biologiste-Responsable');
INSERT INTO Biologiste VALUES (2,'AMRAN','Zineb','Bio-Med','Biologist-Médical');
INSERT INTO Biologiste VALUES (3,'SAHLI','Lamia','Ingénieur','Ing-Qualité');
INSERT INTO Biologiste VALUES (4,'NADIR','Ahmed','Biologie','Aide-laboratoire');
INSERT INTO Biologiste VALUES (5,'BENMIHOUB','Djamila','Ingénieur','Secrétaire');
INSERT INTO Biologiste VALUES (6,'CHERGUI','Selma','Technicien','Technicien');
INSERT INTO Biologiste VALUES (7,'BOUSALEM','Ziad','Biologie','Aide-laboratoire');
INSERT INTO Biologiste VALUES (8,'KADI','Nadia','Ingénieur','Ing-Informatique');
INSERT INTO Biologiste VALUES (9,'SMATI','Radia','Bio-Med','Biologist-Médical');
INSERT INTO Biologiste VALUES (10,'NAILI','Mourad','Bio-Med','Biologist-Médical');

INSERT INTO Patient VALUES (1,'SAIDI','Ryad',   TO_DATE('10/02/1970','DD/MM/YYYY'));
INSERT INTO Patient VALUES (2,'BELHADJ','Selma',TO_DATE('21/03/1976','DD/MM/YYYY'));
INSERT INTO Patient VALUES (3,'DIB','Ahmed',    TO_DATE('03/08/2000','DD/MM/YYYY'));
INSERT INTO Patient VALUES (4,'BRAHIMI','Djalil',TO_DATE('22/06/2002','DD/MM/YYYY'));
INSERT INTO Patient VALUES (5,'SYAD','Hadjer',  TO_DATE('14/09/1999','DD/MM/YYYY'));
INSERT INTO Patient VALUES (6,'NAIM','Fouad',   TO_DATE('23/07/1998','DD/MM/YYYY'));
INSERT INTO Patient VALUES (7,'KADRI','Amine',  TO_DATE('28/05/1970','DD/MM/YYYY'));
INSERT INTO Patient VALUES (8,'SEDDIKI','Wail', TO_DATE('20/10/1986','DD/MM/YYYY'));
INSERT INTO Patient VALUES (9,'AITALI','Bahia', TO_DATE('08/10/1950','DD/MM/YYYY'));
INSERT INTO Patient VALUES (10,'SENDJAK','Raouf',TO_DATE('02/04/1968','DD/MM/YYYY'));

INSERT INTO Prelevement VALUES (1, 1, TO_DATE('04/02/2022','DD/MM/YYYY'), 'Sanguin');
INSERT INTO Prelevement VALUES (2, 1, TO_DATE('04/02/2022','DD/MM/YYYY'), 'Nasopharyngé');
INSERT INTO Prelevement VALUES (3, 2, TO_DATE('04/02/2022','DD/MM/YYYY'), 'Sanguin');
INSERT INTO Prelevement VALUES (4, 3, TO_DATE('04/02/2022','DD/MM/YYYY'), 'Cutanéo-Muqueux');
INSERT INTO Prelevement VALUES (5, 3, TO_DATE('04/02/2022','DD/MM/YYYY'), 'Sanguin');
INSERT INTO Prelevement VALUES (6, 4, TO_DATE('04/02/2022','DD/MM/YYYY'), 'Nasopharyngé');
INSERT INTO Prelevement VALUES (7, 5, TO_DATE('05/02/2022','DD/MM/YYYY'), 'Sanguin');
INSERT INTO Prelevement VALUES (8, 6, TO_DATE('05/02/2022','DD/MM/YYYY'), 'Sanguin');
INSERT INTO Prelevement VALUES (9, 7, TO_DATE('05/02/2022','DD/MM/YYYY'), 'Nasopharyngé');
INSERT INTO Prelevement VALUES (10,8, TO_DATE('05/02/2022','DD/MM/YYYY'), 'Cutanéo-Muqueux');
INSERT INTO Prelevement VALUES (11,8, TO_DATE('05/02/2022','DD/MM/YYYY'), 'Sanguin');
INSERT INTO Prelevement VALUES (12,9, TO_DATE('05/02/2022','DD/MM/YYYY'), 'Sanguin');
INSERT INTO Prelevement VALUES (13,10,TO_DATE('06/02/2022','DD/MM/YYYY'), 'Sanguin');

INSERT INTO EffectuePrelevement VALUES (7, 1, 1);
INSERT INTO EffectuePrelevement VALUES (1, 1, 2);
INSERT INTO EffectuePrelevement VALUES (2, 2, 3);
INSERT INTO EffectuePrelevement VALUES (10,3, 4);
INSERT INTO EffectuePrelevement VALUES (4, 3, 4);
INSERT INTO EffectuePrelevement VALUES (9, 3, 5);
INSERT INTO EffectuePrelevement VALUES (2, 4, 6);
INSERT INTO EffectuePrelevement VALUES (9, 5, 7);
INSERT INTO EffectuePrelevement VALUES (4, 5, 7);
INSERT INTO EffectuePrelevement VALUES (7, 6, 8);
INSERT INTO EffectuePrelevement VALUES (1, 7, 9);
INSERT INTO EffectuePrelevement VALUES (10,8, 10);
INSERT INTO EffectuePrelevement VALUES (1, 8, 11);
INSERT INTO EffectuePrelevement VALUES (2, 9, 12);
INSERT INTO EffectuePrelevement VALUES (7, 10, 13);

INSERT INTO Resultat VALUES (1, 1, 'Hémoglobine', '10.2', '12 à 16g/dL', 'Anémie');
INSERT INTO Resultat VALUES (2, 1, 'Plaquettes',  '155k', '150k à 400k/mm3', 'Sans Particularité.');
INSERT INTO Resultat VALUES (3, 1, 'Leucocytes',  '6.2',  '4k à 10k/mm3', 'Sans Particularité.');
INSERT INTO Resultat VALUES (4, 1, 'Lymphocytes','4.8',  '1.5k à 4k/mm3', 'Poss. Infection');
INSERT INTO Resultat VALUES (5, 2, 'Antig-Covid','0.2',  '>0.5', 'Négatif');
INSERT INTO Resultat VALUES (6, 3, 'Groupage',   'A R+', 'A, B, AB, O -+', 'A+');
INSERT INTO Resultat VALUES (7, 4, 'Culture',    'Staphyl.', '-', 'Infection au Staphylococcus');
INSERT INTO Resultat VALUES (8, 4, 'Sens. Antibiotique', '+Amoxicilline', '-', 'Sensible à l''Amoxicilline');
INSERT INTO Resultat VALUES (9, 5, 'Hémoglobine', '13.2', '12 à 16g/dL', 'Sans Particularité.');
INSERT INTO Resultat VALUES (10,5, 'Plaquettes',  '235k', '150k à 400k/mm3', 'Sans Particularité.');
INSERT INTO Resultat VALUES (11,5, 'Leucocytes',  '8.1',  '4k à 10k/mm3', 'Sans Particularité.');
INSERT INTO Resultat VALUES (12,5, 'Lymphocytes','2.8',  '1.5k à 4k/mm3', 'Sans Particularité.');
INSERT INTO Resultat VALUES (13,6, 'Antig-Covid','12.6', '>0.5', 'Positif');
INSERT INTO Resultat VALUES (14,7, 'PCR Covid',  '8.2',  '>0.5', 'Positif');

COMMIT;




ALTER TABLE Resultat RENAME COLUMN TypeRes TO TypeResultat;
ALTER TABLE Resultat MODIFY (Conclusion VARCHAR2(100));



-- Biologiste(s) avec le MAX de prélèvements
SELECT b.NumB, b.Nom, b.Prenom, COUNT(*) AS nb_prelevements
FROM Biologiste b
JOIN EffectuePrelevement e ON e.NumB = b.NumB
GROUP BY b.NumB, b.Nom, b.Prenom
HAVING COUNT(*) = (
  SELECT MAX(cnt)
  FROM (
    SELECT COUNT(*) cnt
    FROM EffectuePrelevement
    GROUP BY NumB
  )
);

-- Biologiste(s) avec le MIN de prélèvements
SELECT b.NumB, b.Nom, b.Prenom, COUNT(*) AS nb_prelevements
FROM Biologiste b
JOIN EffectuePrelevement e ON e.NumB = b.NumB
GROUP BY b.NumB, b.Nom, b.Prenom
HAVING COUNT(*) = (
  SELECT MIN(cnt)
  FROM (
    SELECT COUNT(*) cnt
    FROM EffectuePrelevement
    GROUP BY NumB
  )
);

-- Nombre de Covid positifs par type de prélèvement
SELECT p.TypePr, COUNT(*) AS nb_covid_positifs
FROM Resultat r
JOIN Prelevement p ON r.NumPr = p.NumPr
WHERE UPPER(r.TypeResultat) LIKE '%COVID%'
  AND UPPER(r.Conclusion) = 'POSITIF'
GROUP BY p.TypePr;

-- Liste des types de prélèvement
SELECT DISTINCT TypePr
FROM Prelevement
ORDER BY TypePr;
COMMIT ;

SELECT P.Nom,
       P.Prenom,
       EXTRACT(YEAR FROM (SYSDATE)) - EXTRACT(YEAR FROM (P.DateNaissance)) AS age
FROM Patient P, Prelevement Pr, Resultat R
WHERE P.NumP = Pr.NumP
  AND Pr.NumPr = R.NumPr
  AND upper(R.TypeResultat) LIKE '%COVID%'
  AND R.Conclusion = 'Positif'
  AND EXTRACT(MONTH FROM Pr.DatePr) = 2;
