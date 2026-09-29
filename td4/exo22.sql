-- qs1 :
   create type T_nom as object(
       nom_de_famille varchar2(30),
       prenom varchar2(30)
   )
   
   
   create type T_adresse as object(
        rue varchar2(30),
        numero varchar2(10),
        ville varchar2(30),
        pays varchar2(30),
        code_postal varchar2(10)
   )
   
   create type T_telephoneS as varray(6) of varchar2(10)
   
    CREATE TYPE T_person AS OBJECT (
        nss VARCHAR2(10),
        nom T_nom,
        date_naiss DATE,
        adresse T_adresse,
        telephone T_telephoneS
    ) NOT FINAL;
       
    CREATE TABLE person OF T_person
           
    select * from person;
    
    
-- qs2 :
    -- etudiant :
    CREATE TYPE T_diplome AS OBJECT (
        nom VARCHAR2(50),
        annee NUMBER(4)
    );

    CREATE TYPE T_diplomeS AS TABLE OF T_diplome;
    
    CREATE TYPE T_Etudiant UNDER T_person (
        n_etudiant VARCHAR2(10),
        departement VARCHAR2(50),
        diplome T_diplomeS
    );
    
    create type T_compte as object (
        numero varchar2(20),
        banque varchar2(10)
    );

drop type T_Enseignant force

    CREATE TYPE T_Enseignant UNDER T_person (
        n_enseignant VARCHAR2(10),
        compte T_compte
    );

    
-- qs 3 :

INSERT INTO person VALUES (
    T_etudiant(
        '123123123',
        T_nom('MERABETI','Adam'),
        TO_DATE('1985-05-01','YYYY-MM-DD'),
        T_adresse('Didouche Mourad', NULL, 'Alger', 'Algerie', NULL),
        T_telephoneS(),   -- pas de téléphone
        '999',
        'Informatique',
        T_diplomeS()      -- sans diplômes
    )
);

select p.nom.prenom from person p;

-- qs 4 :

INSERT INTO person VALUES (
    T_Enseignant(
        '666999666',
        T_nom('LAMARI','Meriem'),
        TO_DATE('1975-06-04','YYYY-MM-DD'),
        T_adresse('Boulevard Colonel Amirouche','99','Alger','Algerie',NULL),
        T_telephoneS(),   -- pas de téléphone
        '777',
        T_compte('310123456789','BDA')
    )
);

select p.nom.prenom from person p;

-- qs5 :

INSERT INTO person VALUES (
    T_Enseignant(
        '556978566',
        T_nom('SALEMI','Ahmed'),
        TO_DATE('1965-06-04','YYYY-MM-DD'),
        T_adresse('Ismail Yafsah','99','Alger','Algerie',NULL),
        T_telephoneS(),   -- pas de téléphone
        '787',
        T_compte('330123489756','BEA')
    )
);

-- qs6 :

update person
set telephone = T_telephoneS('022342222', '066543333')
where nom = T_nom('MERABETI', 'Adam');

select p.telephone from person p;

-- qs7 :

update person
set telephone = (select telephone from person where p.nom = T_nom('MERABETI', 'Adam'))
where nom = T_nom('LAMARI', 'Meriem');


-- qs8 :

-- get only students : using value() is of (type)
select p.nom.nom_de_famille, p.nom.prenom from person p
where value(p) is of (T_etudiant);

-- access to students atts ! using trait(value() as type).att
select p.nom.prenom, p.nom.nom_de_famille, treat(value(p) as T_etudiant).n_etudiant from person p;

-- both : only students + access to there atts
select p.nom.nom_de_famille, p.nom.prenom, treat(value(p) as T_etudiant).n_etudiant from person p
where value(p) is of (T_etudiant);

-- qs9 :

select p1.nom.nom_de_famille, p.nom.prenom from person p1, persoon p2,
        table(p1.telephone) t1, table(p2.telephone) t2
where p1.nss > p2.nss and
    t1.column_value = t2.column_value

-- column_value : compares rows of tables with each other !! (must be tables not collection)
-- so we convert it to table using table()

-----------------------------------

-- qs1 :





























