
-- exo1 :

create table test (
    cleanum numeric,
    name varchar2(10)
);

set serveroutput on

create or replace trigger auto_increment
before insert on test
for each row
declare
    num_cle numeric;
begin
    select count(*) into num_cle from test;
    if num_cle = 0 then
        :new.cleanum := 1;
    else
        :new.cleanum := num_cle + 1;
    end if;
end;

insert into test (name) values('abdo');

select * from test;


-- other solution also gooooooood

--------------------------
-- exo1 : 

create or replace trigger incr
after insert on TableQQ
for each row
declare
    size number;
begin
    select count(*) into size from TableQQ;
    if size = 0 then
        :new.clenum := 1;
    else 
        :new.clenum := :new.clenum + 1;
    end if;
end;























