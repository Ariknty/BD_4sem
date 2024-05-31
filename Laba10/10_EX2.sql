--ex1--
declare @list char(20), @l char(300) = '';
declare listSubject cursor for select Заказчик from Реклама where Вид_рекламы = 'Благотворительная'
open listSubject;
fetch listSubject into @list;
print 'заказчики'
while @@FETCH_STATUS=0
begin 
set @l=RTRIM(@list) + ',' + @l;
fetch listSubject into @list
end;
print @l;
close listSubject;

--ex2--
declare puplit_cursor cursor global for select Заказчик from Реклама where Вид_рекламы = 'Благотворительная'
declare @pupl char(50), @pupls char(100) ='';
open Puplit_cursor;
fetch  Puplit_cursor into @pupl;
	set @pupls ='1. ' + @pupl;	
	print @pupls;
go
close Puplit_cursor;

declare puplit_cursor cursor global for select Заказчик from Реклама where Вид_рекламы = 'Благотворительная'
declare @pupl char(50), @pupls char(100) ='';
open Puplit_cursor;
fetch  Puplit_cursor into @pupl;
	set @pupls ='2. ' + @pupl;	
	print @pupls;
go
close Puplit_cursor;
deallocate puplit_cursor_L;
go

--ex3--
declare cur_S cursor local static for (select з.Название_фирмы, з.Контактное_лицо, з.Банковкие_реквизиты from Заказчики з)
declare @name varchar(20),  @type varchar(20),  @cap int

open cur_S
print 'Кол-во строк: ' + cast(@@cursor_rows as char)
--update Заказчики set  Название_фирмы = 'Apple' where Банковские_реквизиты  = '1%'		
fetch cur_S into @name, @type, @cap
while @@FETCH_STATUS = 0
begin
	print @name + ': ' + @type + ' '  + cast(@cap as char) 
	fetch cur_S into @name, @type, @cap
end
close cur_S
go 

declare cur_D cursor local dynamic for (select з.Название_фирмы, з.Контактное_лицо, з.Банковкие_реквизиты from Заказчики з)
declare @name varchar(20), @type varchar(20), @cap int

open cur_D
print 'Кол-во строк: ' + cast(@@cursor_rows as char)
--update Заказчики set  Название_фирмы = 'Apple' where Банковские_реквизиты  = '1%'		
fetch cur_D into @name, @type, @cap
while @@FETCH_STATUS = 0
begin
	print @name + ' ' + @type + ' ' + cast(@cap as char) 
	fetch cur_D into @name, @type, @cap
end
close cur_D

--ex4--
declare cur cursor local dynamic scroll for 
	select row_number() over (order by з.Название_фирмы), з.Название_фирмы, з.Контактное_лицо, з.Банковкие_реквизиты from Заказчики з
declare @rn int, @id varchar(10), @sub varchar(15), @nt int
open cur

fetch cur into @rn, @id, @sub, @nt
print  @id + ': ' + rtrim(cast(@sub as varchar)) + ' Счёт= ' + cast(@nt as varchar) 
																										 
fetch next from cur into @rn, @id, @sub, @nt															 
print @id + ': ' + rtrim(cast(@sub as varchar)) + ' Счёт= ' + cast(@nt as varchar) 
																										 
fetch relative 8 from cur into @rn, @id, @sub, @nt														 
print @id + ': ' + rtrim(cast(@sub as varchar)) + ' Счёт= ' + cast(@nt as varchar)
																										 
fetch absolute -20 from cur into @rn, @id, @sub, @nt													 
print @id + ': ' + rtrim(cast(@sub as varchar)) + ' Счёт= ' + cast(@nt as varchar) 
																										 
fetch prior from cur into @rn, @id, @sub, @nt															 
print @id + ': ' + rtrim(cast(@sub as varchar)) + ' Счёт= ' + cast(@nt as varchar) 
																										 
fetch last from cur into @rn, @id, @sub, @nt															 
print @id + ': ' + rtrim(cast(@sub as varchar)) + ' Счёт= ' + cast(@nt as varchar) 

close cur

--ex5--
declare cur cursor local dynamic for 
	select з.Название_фирмы, з.Контактное_лицо, з.Банковкие_реквизиты from Заказчики з FOR UPDATE
declare @id varchar(10), @sub varchar(15), @nt int
open cur
fetch cur into @id, @sub, @nt
print @id  + rtrim(cast(@sub as varchar)) + 'оценка ' + cast(@nt as varchar)
delete Заказчики where CURRENT OF cur
fetch cur into @id, @sub, @nt
update Заказчики set Название_фирмы = Название_фирмы + 1 where CURRENT OF cur
print ''
print @id  + rtrim(cast(@sub as varchar)) + 'оценка ' + cast(@nt as varchar)
close cur

--ex6--
declare cur cursor local dynamic for 
	select .Название_фирмы, з.Контактное_лицо, з.Банковкие_реквизиты from Заказчики з
	join Реклама s on s.Заказчик = з.Название_фирмы
	where з.Название_фирмы = 'Цветочки'
		FOR UPDATE
declare @id varchar(20), @nm varchar(50), @nt int
open cur
fetch cur into @id, @nm, @nt
print @id + @nm + cast(@nt as varchar)
delete Заказчики where CURRENT OF cur	-- не запускать, все удалится
delete Реклама where CURRENT OF cur
close cur

declare cur cursor local dynamic for 
	select .Название_фирмы, з.Контактное_лицо, з.Банковкие_реквизиты from Заказчики з
	join Реклама s on s.Заказчик = з.Название_фирмы
	where з.Название_фирмы = 'Цветочки'
		FOR UPDATE
declare @id varchar(5), @nm varchar(50), @nt int
open cur
fetch cur into @id, @nm, @nt
update Заказчики set Телефон = Телефон + 1 where CURRENT OF cur
print @id + @nm + cast(@nt as varchar)	-- увеличится телефон на 1
close cur
