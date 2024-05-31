--ex1--
declare @i char(20)='Tom';
declare @i1 varchar(20) ='Привет';
declare @i2 datetime, @i3 time, @i4 int, @i5 smallint, @i6 tinyint, @i7 numeric(12, 5);

set @i2 = '2024-04-04';
set @i3 = '01:30:30';
set @i4 = 1;
set @i5 = 1;
set @i6 = 200;
set @i7 = 200.2;

select @i as i, @i1 as i1, @i2 as i2, @i3 as i3, @i5 as i5;

print @i4;
print @i6;
print @i7;
--ex2--

declare @количество int=(select COUNT (AUDITORIUM_CAPACITY) from AUDITORIUM)
print 'Количесво =' +cast(@количество as varchar(10))

declare @a int= (select CAST(sum(AUDITORIUM_CAPACITY) as int) from AUDITORIUM),
@a1 real, @a2 int, @a3 real
if @a > 200
begin
select @a1 = (select cast( count(*) as int) from AUDITORIUM),
       @a2 = (select cast( avg (AUDITORIUM_CAPACITY) as int) from AUDITORIUM)
set @a3 = (select cast(count(*) as int) from AUDITORIUM where AUDITORIUM_CAPACITY < @a3)
select @a 'Общая вместимость', @a1 'Количество аудиторий', @a2 'Средняя вместимость', @a3 'Меньше среднего'
end
else if @a < 200 print '' + cast(@a as int);

--ex3--
select @@ROWCOUNT as [@@ROWCOUNT],
    @@VERSION as [@@VERSION],
    @@SPID as [@@SPID],
    @@ERROR as [@@ERROR],
    @@SERVERNAME as [@@SERVERNAME],
    @@TRANCOUNT as [@@TRANCOUNT],
    @@FETCH_STATUS as [@@FETCH_STATUS],
    @@NESTLEVEL as [@@NESTLEVEL];

--ex4--
declare @z int=1, @t int, @x int = 2, @sin numeric(8, 3), @4tx numeric(8, 3), @1ex numeric(8, 3)

if (@t > @x) 
	set @z = sin(@t) * sin(@t)
else if (@t < @x)
	set @z = 4 * (@t + @x)
else 
	set @z = 1 - exp(@x - 2)

print 'z = ' + cast(@z as char)


declare @FIO varchar(100) = (select top 1 NAME from STUDENT where MONTH(BDAY) = MONTH(dateadd(m, 1, GETDATE())));
print 'Полное ФИО:' + @FIO

declare @group int = 2;
declare @weekDay int = (select top 1 day(PROGRESS.PDATE) from PROGRESS inner join STUDENT 
                                on STUDENT.IDSTUDENT=PROGRESS.IDSTUDENT 
                                where STUDENT.IDGROUP = @group and PROGRESS.SUBJECT='ОАиП')
print 'День:'+ cast(@weekDay as varchar(20));

--ex5--
select case
       when NOTE between 0 and 3 then 'Пересдача'
	   when NOTE between 4 and 6 then 'Неплохо'
	   when NOTE between 7 and 8 then 'Хорошо'
	   when NOTE between 9 and 10 then 'Отлично'
	   end результат, count (*) [Количество]
from dbo.PROGRESS where SUBJECT='СУБД'
group by case 
       when NOTE between 0 and 3 then 'Пересдача'
	   when NOTE between 4 and 6 then 'Неплохо'
	   when NOTE between 7 and 8 then 'Хорошо'
	   when NOTE between 9 and 10 then 'Отлично'
	   end

--ex6--

CREATE TABLE #Table (
    Номер INT,
    Строка VARCHAR(50),
    Вычисление DECIMAL(10, 2)
);

DECLARE @y INT = 1;
WHILE @y <= 10
BEGIN
    INSERT INTO #Table (Номер, Строка, Вычисление)
    VALUES (@y, ' Строка' + CAST(@y AS VARCHAR), @y * 1.5);
    SET @y = @y + 1;
END;
SELECT * FROM #Table;

--ex7--
declare @x int = 20
print @x+200
print @x+5
return
print @x+100
--ex8--

begin try
declare @r int = 9 set @r = @r / 0
end try

begin catch
   print ERROR_NUMBER()
   print ERROR_MESSAGE()
   print ERROR_LINE()
   print ERROR_PROCEDURE()
   print ERROR_SEVERITY()
   print ERROR_STATE()
end catch            