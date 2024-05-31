--ex1--
create function COUNT_Заказчиков (@zk varchar(20)) returns int
as begin declare @rc int =0;
set @rc = (select count(*) from Заказчики з
           join Реклама р on з.Название_фирмы=р.Заказчик where з.Название_фирмы=@zk)
return @rc
end;

declare @f int = dbo.COUNT_Заказчиков('Цветочки');
print 'Количество заказчиков: ' + convert(varchar(4), @f);

select Название_фирмы, dbo.COUNT_Заказчиков(Название_фирмы) from Заказчики;
go
--ex2--

create function F_Заказчики (@p varchar (20)) returns char(300)
as begin 
declare @tv char(20);
declare @t varchar(300)='Вид рекламы: ';
declare FCUR cursor local
for select Вид_рекламы from Реклама where Заказчик=@p;
open FCUR;
fetch FCUR into @tv;
while @@FETCH_STATUS=0
begin
set @t=@t + ',' + RTRIM(@tv);
fetch FCUR into @tv;
end;
return @t;
end;

select Название_фирмы, dbo. F_Заказчики(Название_фирмы) from Заказчики
go
--ex3--
create function F_Заказ(@f varchar(10), @p varchar(10)) returns table
as return
select f.Название_фирмы, p.Вид_рекламы from Заказчики f left outer join Реклама p
on f.Название_фирмы=p.Заказчик
where f.Название_фирмы=ISNULL(@f, f.Название_фирмы) and p.Вид_рекламы=ISNULL(@p, p.Вид_рекламы);

select * from dbo.F_Заказ(null, null)
select * from dbo.F_Заказ('Цветочки', null)
select * from dbo.F_Заказ(null, 'Информацонная')
select * from dbo.F_Заказ('Атлант', 'Информацонная')
go
--ex4--
create function FC_Реклама (@p varchar(50)) returns int
as begin
declare @rc int=(select count(*) from Реклама
where Вид_рекламы=ISNULL(@p, Вид_рекламы));
return @rc;
end;

select Вид_рекламы, dbo.FC_Реклама(Вид_рекламы) [количесвто]
from Реклама


