--ex1--
use UNIVER
exec sp_helpindex 'AUDITORIUM_TYPE'
exec sp_helpindex 'SUBJECT'
exec sp_helpindex 'AUDITORIUM'
exec sp_helpindex 'FACULTY'
exec sp_helpindex 'PROFESSION'
exec sp_helpindex 'PULPIT'
exec sp_helpindex 'TEACHER'
exec sp_helpindex 'GROUPS'
exec sp_helpindex 'STUDENT'
exec sp_helpindex 'PROGRESS';

CREATE TABLE #Table (
    Номер INT,
    Строка VARCHAR(50),
    Вычисление DECIMAL(10, 2)
);

DECLARE @y INT = 1;
WHILE @y <= 1500
BEGIN
    INSERT INTO #Table (Номер, Строка, Вычисление)
    VALUES (@y, ' Строка' + CAST(@y AS VARCHAR), @y * 1.5);
    SET @y = @y + 1;
END;
SELECT * FROM #Table;

SELECT * FROM #Table where Номер between 1000 and 1400 order by Номер;
checkpoint;
DBCC DROPCLEANBUFFERS;

create clustered index #Table_CL on #Table(Номер asc)
drop table #Table

--ex2--

CREATE TABLE #Table_2 (
    Номер INT,
    Строка VARCHAR(50),
    Вычисление DECIMAL(10, 2)
);

DECLARE @x INT = 1;
WHILE @x <= 1500
BEGIN
    INSERT INTO #Table_2 (Номер, Строка, Вычисление)
    VALUES (@x, ' Строка' + CAST(@x AS VARCHAR), @x * 1.5);
    SET @x = @x + 1;
END;

select * from #Table_2
select COUNT(*)[Количество строк] from #Table_2
create index #Table_2_NONCLU on #Table_2(Номер, Вычисление)
select * from #Table_2 where Номер > 500 and Вычисление < 900;
select * from #Table_2 order by Номер,Вычисление;

--ex3--
CREATE TABLE #Table_4(
    Номер INT,
    CC int identity(1,1),
    TF varchar(100)
);
set nocount on;
DECLARE @y INT = 0;
WHILE @y <= 2000
BEGIN
    INSERT INTO #Table_4(Номер,TF)
	VALUES (floor(3000*Rand()), REPLICATE('Строка',10));
    SET @y = @y + 1;
END;
create index #Table_4_Key_X on #Table_4(Номер) include (CC)
select CC from #Table_4 where Номер > 1500;

--ex4--
CREATE TABLE #Table_5(
    Номер INT,
    CC int identity(1,1),
    TF varchar(100)
);
set nocount on;
DECLARE @y INT = 0;
WHILE @y <= 2000
BEGIN
    INSERT INTO #Table_5(Номер,TF)
	VALUES (floor(3000*Rand()), REPLICATE('Строка',10));
    SET @y = @y + 1;
END;

select Номер from #Table_5 where Номер between 500 and 900;
select Номер from #Table_5 where Номер>700 and Номер<1500;
select Номер from #Table_5 where Номер=2000

create index #Table_5_where on #Table_5(Номер) where (Номер>500 and Номер<1500);

--ex5--
CREATE TABLE #Table_6(
    Номер INT,
    CC int identity(1,1),
    TF varchar(100)
);
set nocount on;
DECLARE @y INT = 0;
WHILE @y <= 10000
BEGIN
    INSERT INTO #Table_6(Номер,TF)
	VALUES (floor(3000*Rand()), REPLICATE('Строка',10));
    SET @y = @y + 1;
END;

create index #Table_6_Key on #Table_6(Номер);
select name [индекс], avg_fragmentation_in_percent [Фрагментация(%)]
from sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'),
OBJECT_ID(N'#Table_6'),NULL, NULL, NULL) ss join sys.indexes ii on ss.object_id=ii.object_id and ss.object_id = ii.object_id where name is not null;

insert top (10000) #Table_6(Номер, TF) select Номер, TF from #Table_6;
alter index #Table_6_Key on #Table_6 reorganize;
alter index #Table_6_Key on #Table_6 rebuild with (online = off);
drop table #Table_6

--ex6--
drop index #Table_6_Key on #Table_6
create index #Table_6_Key on #Table_6(Номер) with (fillfactor = 65)

insert top(50) percent into #Table_6(Номер,TF)
select Номер, TF from #Table_6;
select name [индекс], avg_fragmentation_in_percent [Фрагментация(%)]
from sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'),
OBJECT_ID(N'#Table_6'),NULL, NULL, NULL) ss join sys.indexes ii on ss.object_id=ii.object_id and ss.object_id = ii.object_id where name is not null;
