--ex1--
create function COUNT_STUDENTS (@faculty varchar(20)) returns int
as begin declare @rc int =0;
set @rc = (select count(*) from STUDENT s
           join GROUPS g on s.IDGROUP=g.IDGROUP where g.FACULTY=@faculty)
return @rc
end;

declare @f int = dbo.COUNT_STUDENTS('ХТиТ');
print 'Количество студентов на выбранном факультете: ' + convert(varchar(4), @f);

select FACULTY, dbo.COUNT_STUDENTS(FACULTY) from FACULTY;
go

drop function COUNT_STUDENTS

alter function COUNT_STUDENTS (@faculty varchar(20), @prof varchar(20)=null) returns int
as begin declare @rc int =0;
set @rc = (select count(*) from STUDENT s
           join GROUPS g on s.IDGROUP=g.IDGROUP
		   join   FACULTY f on f.FACULTY = g.FACULTY
		   where g.FACULTY=@faculty
		   and    g.PROFESSION = isnull(@prof, g.PROFESSION))
return @rc
end;
 
select FACULTY, PROFESSION, dbo.COUNT_STUDENTS(FACULTY, PROFESSION) [Количество студентов] from GROUPS;
go

drop function COUNT_STUDENTS

--ex2--
create function FSUBJECTS (@p varchar (20)) returns char(300)
as begin 
declare @tv char(20);
declare @t varchar(300)='Дисциплины: ';
declare FCUR cursor local
for select SUBJECT from SUBJECT where PULPIT=@p;
open FCUR;
fetch FCUR into @tv;
while @@FETCH_STATUS=0
begin
set @t=@t + ',' + RTRIM(@tv);
fetch FCUR into @tv;
end;
return @t;
end;

select PULPIT, dbo.FSUBJECTS(PULPIT) from PULPIT
go
--ex3--
create function FFACPUL(@f varchar(10), @p varchar(10)) returns table
as return
select f.FACULTY, p.PULPIT from FACULTY f left outer join PULPIT p
on f.FACULTY=p.FACULTY
where f.FACULTY=ISNULL(@f, f.FACULTY) and p.PULPIT=ISNULL(@p, p.PULPIT);

	select * from dbo.FFACPUL(null, null)
	select * from dbo.FFACPUL('ЛХФ', null)
	select * from dbo.FFACPUL(null, 'ЛВ')
	select * from dbo.FFACPUL('ИТ', 'ИСиТ')

go
--ex4--
create function FCTEACHER (@p varchar(50)) returns int
as begin
declare @rc int=(select count(*) from TEACHER
where PULPIT=ISNULL(@p, PULPIT));
return @rc;
end;

select PULPIT, dbo.FCTEACHER(PULPIT) [количесвто преподавателей]
from PULPIT
