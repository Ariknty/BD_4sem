--ex1--
create view [Преподаватель]
as select TEACHER [код], TEACHER_NAME [Имя], GENDER[Пол], PULPIT[Кафедра]
from TEACHER;

select * from [Преподаватель]


--ex2--
create view [Количество кафедр]
as select FACULTY.FACULTY_NAME [Факультет], count (*) [Количество]
from FACULTY join PULPIT
on FACULTY.FACULTY = PULPIT.FACULTY
group by FACULTY.FACULTY_NAME

Select * from [Количество кафедр]

--ex3--
create view Аудитории (Код, Наименование)
as select AUDITORIUM, AUDITORIUM_TYPE
from AUDITORIUM where AUDITORIUM_TYPE like 'ЛК%'
go 
select * from Аудитории

--ex4--
create view Лекционные_Аудитории (Код, Наименование)
as select AUDITORIUM, AUDITORIUM_TYPE
from AUDITORIUM where AUDITORIUM_TYPE like 'ЛК%' with check option;
go 

insert Лекционные_Аудитории values ('123','ЛБ')
select * from Лекционные_аудитории

--ex5--
create view Дисциплины (Код, Нименование, Кафедра)
as select top 30 SUBJECT, SUBJECT_NAME, PULPIT
from SUBJECT order by SUBJECT

select * from Дисциплины
--ex6-

alter view [Количество кафедр] with schemabinding
as select FACULTY.FACULTY_NAME [Факультет], count (*) [Количество]
from dbo.FACULTY join dbo.PULPIT
on FACULTY.FACULTY = PULPIT.FACULTY
group by FACULTY.FACULTY_NAME

Select * from [Количество кафедр]
