create table Student (
    sid integer,
    name text,
    primary key (sid)
);

create table Course (
    code char(8),
    lic text,
    quota integer,
    numStudents integer default 0,
    primary key (code)
);

create table Enrolment (
    course char(8),
    sid integer,
    primary key (course, sid),
    foreign key (course) references Course(code),
    foreign key (sid) references Student(sid)
);

create or replace function update_num_students_insert() returns trigger
as $$
begin
    -- Increment num students by one for that course
    update Course set numStudents = numStudents + 1 where code = new.course;
    return new;
end
$$ language plpgsql;



-- Things I messed up:
-- Forgot to include `for each row`
-- `execute procedure update_num_students_insert()`
create trigger update_num_students_insert after insert on Enrolment 
    for each row execute procedure update_num_students_insert();


create or replace function update_num_students_update() returns trigger
as $$
begin
    -- Increment num students by one for that course
    update Course set numStudents = numStudents - 1 where code = old.course;
    update Course set numStudents = numStudents + 1 where code = new.course;
    return new;
end
$$ language plpgsql;

create trigger update_num_students_update after update on Enrolment 
    for each row execute procedure update_num_students_update();



insert into Course values ('COMP1511', 'Jake Renzella', 1000);
insert into Course values ('COMP1531', 'Hayden Smith' , 1000);
insert into Course values ('COMP3311', 'Yuekang Li'   , 1000);

insert into Student values (0, 'John Smith'   );
insert into Student values (1, 'John Doe'     );
insert into Student values (2, 'Daniel Jacobs');



