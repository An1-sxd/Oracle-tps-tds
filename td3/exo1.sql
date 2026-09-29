-- exo1 :
create or replace trigger num_auto
before insert on TABLE
for each row
declare
  nb_id number;
begin
  select count(cleanum) into nb_id from TABLE;
  if nb_id = 0 then
    :new.cleanum := 1;
  else
    :new.cleanum := nb_id + 1;
  end if;
end;

-- another solution :

create sequence seq_cleanum
start with 1
increment by 1
-- minvalue 1
-- maxvalue 999
-- nocycle
-- nocache;

create or replace trigger num_auto
before insert on TABLE
for each row
begin
  :new.cleanum := seq_cleanum.nextval;
end;

-- learned :
  -- :new : a reference to the new row being inserted in the trigger.
  -- :old : a reference to the old row being updated or deleted in the trigger.

  -- create sequence : a database object that generates a sequence of unique numbers, often used for auto-incrementing primary keys.
  -- seq_name.nextval : a function that retrieves the next value from a sequence.
  -- seq_name.currval : a function that retrieves the current value of a sequence without incrementing it.
  -- minvalue : the minimum value that a sequence can generate.
  -- maxvalue : the maximum value that a sequence can generate.
  -- nocycle : specifies that the sequence should not cycle back to the start value after reaching the maximum value.
  -- nocache : specifies that the sequence should not cache any values, meaning each call to