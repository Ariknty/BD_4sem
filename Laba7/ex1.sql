--ex1--
create view [�������������]
as select TEACHER [���], TEACHER_NAME [���], GENDER[���], PULPIT[�������]
from TEACHER;

select * from [�������������]


--ex2--
create view [���������� ������]
as select FACULTY.FACULTY_NAME [���������], count (*) [����������]
from FACULTY join PULPIT
on FACULTY.FACULTY = PULPIT.FACULTY
group by FACULTY.FACULTY_NAME

Select * from [���������� ������]

--ex3--
create view ��������� (���, ������������)
as select AUDITORIUM, AUDITORIUM_TYPE
from AUDITORIUM where AUDITORIUM_TYPE like '��%'
go 
select * from ���������

--ex4--
create view ����������_��������� (���, ������������)
as select AUDITORIUM, AUDITORIUM_TYPE
from AUDITORIUM where AUDITORIUM_TYPE like '��%' with check option;
go 

insert ����������_��������� values ('123','��')
select * from ����������_���������

--ex5--
create view ���������� (���, �����������, �������)
as select top 30 SUBJECT, SUBJECT_NAME, PULPIT
from SUBJECT order by SUBJECT

select * from ����������
--ex6-

alter view [���������� ������] with schemabinding
as select FACULTY.FACULTY_NAME [���������], count (*) [����������]
from dbo.FACULTY join dbo.PULPIT
on FACULTY.FACULTY = PULPIT.FACULTY
group by FACULTY.FACULTY_NAME

Select * from [���������� ������]
