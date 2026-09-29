create database tp1;
use tp1;

CREATE TABLE Biologiste (
    NumB INT PRIMARY KEY,
    Nom VARCHAR(50),
    Prenom VARCHAR(50),
    Specialite VARCHAR(50),
    RoleB VARCHAR(50)
);
CREATE TABLE Patient (
    NumP INT PRIMARY KEY,
    Nom VARCHAR(50),
    Prenom VARCHAR(50),
    DateNaissance DATE
);

CREATE TABLE Prelevement (
    NumPr INT PRIMARY KEY,
    NumP INT,
    DatePr DATE,
    TypePr VARCHAR(50),
    FOREIGN KEY (NumP) REFERENCES Patient(NumP)
);

CREATE TABLE EffectuePrelevement (
    NumB INT,
    NumP INT,
    NumPr INT,
    PRIMARY KEY (NumB, NumPr),
    FOREIGN KEY (NumB) REFERENCES Biologiste(NumB),
    FOREIGN KEY (NumP) REFERENCES Patient(NumP),
    FOREIGN KEY (NumPr) REFERENCES Prelevement(NumPr)
);

CREATE TABLE Resultat (
    NumR INT PRIMARY KEY,
    NumPr INT,
    TypeRes VARCHAR(50),
    Resul VARCHAR(100),
    Norme VARCHAR(100),
    Conclusion VARCHAR(100),
    FOREIGN KEY (NumPr) REFERENCES Prelevement(NumPr)
);

INSERT INTO Biologiste (NumB, Nom, Prenom, Specialite, RoleB) VALUES
(1, 'BADI', 'Salim', 'Microbio', 'Biologiste-Responsable'),
(2, 'AMRAN', 'Zineb', 'Bio-Med', 'Biologist-Médical'),
(3, 'SAHLI', 'Lamia', 'Ingénieur', 'Ing-Qualité'),
(4, 'NADIR', 'Ahmed', 'Biologie', 'Aide-laboratoire'),
(5, 'BENMIHOUB', 'Djamila', 'Ingénieur', 'Secrétaire'),
(6, 'CHERGUI', 'Selma', 'Technicien', 'Technicien'),
(7, 'BOUSALEM', 'Ziad', 'Biologie', 'Aide-laboratoire'),
(8, 'KADI', 'Nadia', 'Ingénieur', 'Ing-Informatique'),
(9, 'SMATI', 'Radia', 'Bio-Med', 'Biologist-Médical'),
(10, 'NAILI', 'Mourad', 'Bio-Med', 'Biologist-Médical');

INSERT INTO Patient (NumP, Nom, Prenom, DateNaissance) VALUES
(1, 'SAIDI', 'Ryad', '1970-02-10'),
(2, 'BELHADJ', 'Selma', '1976-03-21'),
(3, 'DIB', 'Ahmed', '2000-08-03'),
(4, 'BRAHIMI', 'Djalil', '2002-06-22'),
(5, 'SYAD', 'Hadjer', '1999-09-14'),
(6, 'NAIM', 'Fouad', '1998-07-23'),
(7, 'KADRI', 'Amine', '1970-05-28'),
(8, 'SEDDIKI', 'Wail', '1986-10-20'),
(9, 'AITALI', 'Bahia', '1950-10-08'),
(10, 'SENDJAK', 'Raouf', '1968-04-02');

INSERT INTO Prelevement (NumPr, NumP, DatePr, TypePr) VALUES
(1, 1, '2022-02-04', 'Sanguin'),
(2, 1, '2022-02-04', 'Nasopharyngé'),
(3, 2, '2022-02-04', 'Sanguin'),
(4, 3, '2022-02-04', 'Cutanéo-Muqueux'),
(5, 3, '2022-02-04', 'Sanguin'),
(6, 4, '2022-02-04', 'Nasopharyngé'),
(7, 5, '2022-02-05', 'Sanguin'),
(8, 6, '2022-02-05', 'Sanguin'),
(9, 7, '2022-02-05', 'Nasopharyngé'),
(10, 8, '2022-02-05', 'Cutanéo-Muqueux'),
(11, 8, '2022-02-05', 'Sanguin'),
(12, 9, '2022-02-05', 'Sanguin'),
(13, 10, '2022-02-06', 'Sanguin');

INSERT INTO EffectuePrelevement (NumB, NumP, NumPr) VALUES
(7, 1, 1),
(1, 1, 2),
(2, 2, 3),
(10, 3, 4),
(4, 3, 4),
(9, 3, 5),
(2, 4, 6),
(9, 5, 7),
(4, 5, 7),
(7, 6, 8),
(1, 7, 9),
(10, 8, 10),
(1, 8, 11),
(2, 9, 12),
(7, 10, 13);

INSERT INTO Resultat (NumR, NumPr, TypeRes, Resul, Norme, Conclusion) VALUES
(1, 1, 'Hémoglobine', '10.2', '12 à 16 g/dL', 'Anémie'),
(2, 1, 'Plaquettes', '155k', '150k à 400k/mm3', 'Sans Particularité'),
(3, 1, 'Leucocytes', '6.2', '4k à 10k/mm3', 'Sans Particularité'),
(4, 1, 'Lymphocytes', '4.8', '1.5k à 4k/mm3', 'Poss. Infection'),
(5, 2, 'Antig-Covid', '0.2', '>0.5', 'Négatif'),
(6, 3, 'Groupage', 'A R+', 'A, B, AB, O -+', 'A+'),
(7, 4, 'Culture', 'Staphyl.', '-', 'Infection au Staphylococcus'),
(8, 4, 'Sens. Antibiotique', '+Amoxicilline', '-', 'Sensible à l\'Amoxicilline'),
(9, 5, 'Hémoglobine', '13.2', '12 à 16 g/dL', 'Sans Particularité'),
(10, 5, 'Plaquettes', '235k', '150k à 400k/mm3', 'Sans Particularité'),
(11, 5, 'Leucocytes', '8.1', '4k à 10k/mm3', 'Sans Particularité'),
(12, 5, 'Lymphocytes', '2.8', '1.5k à 4k/mm3', 'Sans Particularité'),
(13, 6, 'Antig-Covid', '12.6', '>0.5', 'Positif'),
(14, 7, 'PCR Covid', '8.2', '>0.5', 'Positif');

# 8)
select p.TypePr , count(*) as nbr_covid_positif
from prelevement as p, resultat as r
where p.NumPr = r.NumPr and lower(r.TypeRes) like "%covid%" and r.conclusion = "Positif"
group by p.TypePr