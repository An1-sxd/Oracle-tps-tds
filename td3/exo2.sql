-- exo2 :

create or replace trigger student_validation
before insert on student
for each row
declare
  counter number;
begin
  select count(*) into counter from student
  where first_name = :new.first_name and last_name = :new.last_name;

  if counter > 0 then
  RAISE_APPLICATION_ERROR(
      -20001,'Student with same first name and last name already exists'
    );
  end if;
end;