create table Teacher (
    staffNo integer,
    nameFirst varchar(50),
    nameLast varchar(50),
    primary key (staffNo)
);

create table Subject (
    subjectCode char(8),
    name varchar(50),
    primary key (subjectCode)
);

create table Teaches (
    staffNo integer,
    subjectCode char(8),
    semester char(4),
    primary key (staffNo, subjectCode, semester),
    foreign key (staffNo) references Teacher(staffNo),
    foreign key (subjectCode) references Subject(subjectCode)
);

