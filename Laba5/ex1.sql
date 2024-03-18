--ex1--
select PULPIT.PULPIT_NAME
from FACULTY, PULPIT
where FACULTY.FACULTY = PULPIT.FACULTY
and FACULTY.FACULTY in (select PROFESSION.FACULTY from PROFESSION 
where (PROFESSION_NAME like '%технология%') or (PROFESSION_NAME like '%технологии%'));

--ex2--
select PULPIT.PULPIT_NAME
from FACULTY inner join PULPIT
on FACULTY.FACULTY = PULPIT.FACULTY
Where FACULTY.FACULTY in (select PROFESSION.FACULTY from PROFESSION 
where (PROFESSION_NAME like '%технология%') or (PROFESSION_NAME like '%технологии%'));

--ex3--
select AUDITORIUM_NAME, AUDITORIUM_CAPACITY, AUDITORIUM_TYPE
from AUDITORIUM a
where AUDITORIUM_CAPACITY = (select top(1) AUDITORIUM_CAPACITY from AUDITORIUM aa
where AUDITORIUM_TYPE=AUDITORIUM_TYPE
order by AUDITORIUM_CAPACITY desc)
ORDER BY a.AUDITORIUM_CAPACITY DESC;

--ex4--
select FACULTY_NAME from FACULTY
where not exists (select * from PULPIT
where FACULTY.FACULTY=PULPIT.FACULTY);

--ex5--
select top 1
(select avg(NOTE) from PROGRESS where SUBJECT like 'ОАиП') [ОАиП],
(select avg(NOTE) from PROGRESS where SUBJECT like 'БД') [БД],
(select avg(NOTE) from PROGRESS where SUBJECT like 'СУБД') [СУБД]
from PROGRESS

--ex6--
select NAME, BDAY from STUDENT
where BDAY >=all (select BDAY from STUDENT where BDAY like '1994-06%');

--ex7--
select NAME, BDAY from STUDENT
where BDAY >any (select BDAY from STUDENT where BDAY like '1994-06%');
