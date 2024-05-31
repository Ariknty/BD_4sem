use UNIVER
go
create procedure PSUBJECT
as 
begin
declare @k int = (select COUNT(*) from SUBJECT);
select * from SUBJECT
return @k
end
go

exec PSUBJECT

drop procedure PSUBJECT

--ex2--
declare @k int = 0;
exec @k=PSUBJECT;
print 'количество строк: ' + cast (@k as varchar(10));
go

alter procedure PSUBJECT @p varchar(20), @c int output
as begin
declare @k int =(select count(*) from SUBJECT);
print 'Параметры @p= ' + @p + ' @c= ' + cast(@c as varchar(10));
select * from SUBJECT where SUBJECT=@p;
set @c=@@ROWCOUNT;
return @k;
end;

declare @k int=0, @r int=0, @p varchar(20) = 'БД';
exec @k=PSUBJECT @p, @c=@r output
print 'Общее количество дисциплин: ' + cast(@k as varchar(10));
print 'Кол-во дисциплин определённой кафедры ' + cast(@p as varchar(10)) + '=' + cast(@r as varchar);
go

--ex3--
alter procedure PSUBJECT @p varchar(20)
as begin
declare @k int = (select count(*) from SUBJECT);
select * from SUBJECT where SUBJECT=@p;
end;

create table #SUBJECT
(	Код_дисциплины varchar(20) primary key,
	Дисциплина nvarchar(20),
	Кафедра nvarchar(20)
)

insert #SUBJECT exec PSUBJECT @p='БД';
insert #SUBJECT exec PSUBJECT @p='МСОИ';

select * from #SUBJECT

drop table #SUBJECT
select * from SUBJECT
--ex4--
 
use UNIVER
go
create procedure PAUDITORIUM_INSERT
@a char(20), @n varchar(50) , @c int = null, @t char(10)
as declare @rc int = 1;
begin try
insert into AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_CAPACITY, AUDITORIUM_TYPE)
values (@a, @n, @c, @t)
return @rc;
end try
begin catch
print 'Номер ошибки: ' + convert(varchar(6), error_number());
	print 'Сообщение: ' + error_message();
	print 'Уровень: ' + convert(varchar(6), error_severity());
	print 'Метка: ' + convert(varchar(8), error_state());
	print 'Номер строки: ' + convert(varchar(8), error_line());
	if error_procedure() is not null
		print 'Имя процедуры: ' + error_procedure();
	return -1;
end catch;

declare @rc int;
exec @rc= PAUDITORIUM_INSERT @a = '216', @n = 'ЛК', @c = 80, @t = 'ЛК';
print 'Код ошибки: ' + convert(varchar(3), @rc);

select * from AUDITORIUM
go
--ex5--
create procedure SUBJECT_REPORT @p char(10)
as
declare @rc int = 0;
begin try
declare @tv char (20), @t char(300)='';
declare SUB cursor for
select SUBJECT from SUBJECT where PULPIT=@p;
if not exists (select SUBJECT from SUBJECT where PULPIT=@p)
raiserror ('Ошибка', 11,1)
else
open SUB;
fetch SUB into @tv;
print 'Список дисциплин: ';
while @@FETCH_STATUS=0
begin
set @t=RTRIM(@tv) + ',' + @t;
set @rc = @rc + 1;
fetch SUB into @tv;
end;
print @t;
close SUB;
return @rc;
end try
begin catch
print 'ошибка в параметрах'
if ERROR_PROCEDURE() is not null
print 'Имя процедуры: ' + ERROR_PROCEDURE();
return @rc;
end catch;


declare @rc int;
exec @rc=SUBJECT_REPORT @p = 'ИСиТ';
print 'Количество дисципин = ' + cast(@rc as varchar(3));

--ex6--
create procedure PAUDITORIUM_INSERTX
@a char(20), @n varchar(50) , @c int = null, @t char(10), @tn varchar(50)
as declare @rc int =1;
begin try
set transaction isolation level SERIALIZABLE;
begin tran
insert into AUDITORIUM_TYPE(AUDITORIUM_TYPE, AUDITORIUM_TYPENAME)
values (@t, @tn)
exec @rc = PAUDITORIUM_INSERT @a, @n, @c, @t;  
commit tran;
return @rc; 
end try
begin catch
    print 'Номер ошибки: ' + convert(varchar(6), error_number());
	print 'Сообщение: ' + error_message();
	print 'Уровень: ' + convert(varchar(6), error_severity());
	print 'Метка: ' + convert(varchar(8), error_state());
	print 'Номер строки: ' + convert(varchar(8), error_line());
	if error_procedure() is not null
    print 'Имя процедуры: ' + error_procedure();
if @@TRANCOUNT>0 rollback tran;
return -1;
end catch;

declare @rc int;
exec @rc=PAUDITORIUM_INSERTX @a = '500', @n = '700', @c = 78, @t = 'ЛК', @tn = 'Лекционная_Б';  
print 'Код ошибки = ' + convert(varchar(3), @rc); 
