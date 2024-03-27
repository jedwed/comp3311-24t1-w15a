-- We want to enforce that the numStudents attribute for each course is equal to
-- the number of enrolments for that course
create assertion num_students_assertion check (
    -- there doesn't exist a course where number of students doesn't equal the number of enrollments for that course
    not exists (
        select * from Course as C where numStudents != (
            -- the number of students enrolled in that course
            select count(*) from Enrolment as E where E.course = C.code

        )
    )
)

