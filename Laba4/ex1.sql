--ex1--
select AUDITORIUM.AUDITORIUM_NAME, AUDITORIUM_TYPE.AUDITORIUM_TYPENAME
	from AUDITORIUM_TYPE inner join AUDITORIUM
	on AUDITORIUM_TYPE.AUDITORIUM_TYPE = AUDITORIUM.AUDITORIUM_TYPE;

--ex2--
select AUDITORIUM_TYPE.AUDITORIUM_TYPENAME, AUDITORIUM.AUDITORIUM_NAME
	from AUDITORIUM_TYPE inner join AUDITORIUM
	on AUDITORIUM_TYPE.AUDITORIUM_TYPE = AUDITORIUM.AUDITORIUM_TYPE AND AUDITORIUM_TYPE.AUDITORIUM_TYPENAME like '%���������%';

--ex3--
SELECT FACULTY.FACULTY, PULPIT.PULPIT, PROFESSION.PROFESSION, SUBJECT.SUBJECT, STUDENT.NAME,
    CASE
        WHEN PROGRESS.NOTE = 6 THEN '�����'
        WHEN PROGRESS.NOTE = 7 THEN '����'
        WHEN PROGRESS.NOTE = 8 THEN '������'
        ELSE '������'
    END AS ������
FROM PROGRESS
INNER JOIN STUDENT ON PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
INNER JOIN GROUPS ON STUDENT.IDGROUP = GROUPS.IDGROUP
INNER JOIN PROFESSION ON GROUPS.PROFESSION = PROFESSION.PROFESSION
INNER JOIN SUBJECT ON PROGRESS.SUBJECT = SUBJECT.SUBJECT
INNER JOIN PULPIT ON SUBJECT.PULPIT = PULPIT.PULPIT
INNER JOIN FACULTY ON PULPIT.FACULTY = FACULTY.FACULTY
WHERE PROGRESS.NOTE BETWEEN 6 AND 8
ORDER BY PROGRESS.NOTE;

--ex4--
select PULPIT.PULPIT, isnull (TEACHER.TEACHER_NAME, '***') [�������������]
from PULPIT LEFT JOIN TEACHER
on PULPIT.PULPIT=TEACHER.PULPIT

--ex5--

CREATE TABLE Students (
    ID INT,
    Name VARCHAR(50)
);

INSERT INTO Students (ID, Name) VALUES
    (1, 'Alice'),
    (2, 'Bob'),
    (3, 'Charlie');


CREATE TABLE Grades (
    ID INT,
    Subject VARCHAR(50),
    Grade VARCHAR(50)
);


INSERT INTO Grades (ID, Subject, Grade) VALUES
    (1, 'Math', 85),
    (2, 'Science', 92),
    (4, 'History', 78);


SELECT *
FROM Students
FULL OUTER JOIN Grades ON Students.ID = Grades.ID
WHERE Grades.ID IS NULL;


SELECT *
FROM Students
FULL OUTER JOIN Grades ON Students.ID = Grades.ID
WHERE Students.ID IS NULL;


SELECT *
FROM Students
FULL OUTER JOIN Grades ON Students.ID = Grades.ID
WHERE Students.ID IS NOT NULL AND Grades.ID IS NOT NULL;


--ex6--
select AUDITORIUM.AUDITORIUM_NAME, AUDITORIUM_TYPE.AUDITORIUM_TYPENAME
	from AUDITORIUM_TYPE cross join AUDITORIUM
	where AUDITORIUM_TYPE.AUDITORIUM_TYPE = AUDITORIUM.AUDITORIUM_TYPE;