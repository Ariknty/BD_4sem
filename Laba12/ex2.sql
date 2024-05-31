use Юдина_MyBase
go
create procedure М_РЕКЛАМА
as 
begin
declare @k int = (select COUNT(*) from Реклама);
select * from Реклама
return @k
end
go

exec М_РЕКЛАМА

drop procedure М_РЕКЛАМА

--ex2--
declare @k int = 0;
exec М_РЕКЛАМА;
print 'количество строк: ' + cast (@k as varchar(10));
go

alter procedure М_РЕКЛАМА @p varchar(20), @c int output
as begin
declare @k int =(select count(*) from Реклама);
print 'Параметры @p= ' + @p + ' @c= ' + cast(@c as varchar(10));
select * from Реклама where Вид_рекламы=@p;
set @c=@@ROWCOUNT;
return @k;
end;

declare @k int=0, @r int=0, @p varchar(20);
exec @k=М_РЕКЛАМА @p='Благотворительная', @c=@r output
print 'Общее количество: ' + cast(@k as varchar(10));
print 'Кол-во строк определённой рекламы' + cast(@p as varchar(10)) + '=' + cast(@r as varchar);
go

--ex3--
alter procedure М_РЕКЛАМА @p varchar(20)
as begin
declare @k int = (select count(*) from Реклама);
select * from Реклама where Вид_рекламы=@p;
end;

CREATE table #Реклама 
(
  id int primary key,
  Вид_рекламы nvarchar(50),
  Дата date,
  Заказчик nvarchar(50),
  Передача nvarchar(50),
  Стоимость_минуты money not null,
  Длительность_в_минутах time not null
)

insert #Реклама exec М_РЕКЛАМА @p='Благотворительная';
insert #Реклама exec М_РЕКЛАМА @p='Информационная';

select * from #Реклама
go
--ex4--


create procedure Заказчики_INSERT
@a nvarchar(50), @n int, @c nvarchar(50) = null, @t nvarchar(15)
as declare @rc int = 1;
begin try
insert into Заказчики (Название_фирмы, Банковкие_реквизиты, Контактное_лицо, Телефон)
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
exec @rc= Заказчики_INSERT @a = 'ККККЛ', @n = 12121213, @c = 'Кто--то', @t = '+33344';
print 'Код ошибки: ' + convert(varchar(3), @rc);

go
--ex5--
drop procedure Передача_REPORT

create procedure Передача_REPORT @p int
as
declare @rc int = 0;
begin try
declare @tv nvarchar(50), @t int;
declare SUB cursor for
select Название_передачи from Передача where Рейтинг=@p;
if not exists (select Название_передачи from Передача where Рейтинг=@p)
raiserror ('Ошибка', 11,1)
else
open REPORT;
fetch REPORT into @tv;
print 'Список дисциплин: ';
while @@FETCH_STATUS=0
begin
set @t=RTRIM(@tv) + ',' + @t;
set @rc = @rc + 1;
fetch REPORT into @tv;
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
exec @rc=Передача_REPORT @p = 3;
print 'Количество передач = ' + cast(@rc as varchar(3));

--ex6--
create procedure Заказчики_INSERTEX
@a nvarchar(50), @n int, @c nvarchar(50) = null, @t nvarchar(15)
as declare @rc int = 1;
begin try
set transaction isolation level SERIALIZABLE;
begin tran
insert into Заказчики (Название_фирмы, Банковкие_реквизиты, Контактное_лицо, Телефон)
values (@a, @n, @c, @t)
exec @rc = Заказчики_INSERTEX @a, @n, @c, @t;  
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
exec @rc= Заказчики_INSERT @a = 'TпTT', @n = 929279292, @c = 'Кто-то_19', @t = '+332222';
print 'Код ошибки = ' + convert(varchar(3), @rc); 
