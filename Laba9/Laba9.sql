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
    ����� INT,
    ������ VARCHAR(50),
    ���������� DECIMAL(10, 2)
);

DECLARE @y INT = 1;
WHILE @y <= 1500
BEGIN
    INSERT INTO #Table (�����, ������, ����������)
    VALUES (@y, ' ������' + CAST(@y AS VARCHAR), @y * 1.5);
    SET @y = @y + 1;
END;
SELECT * FROM #Table;

SELECT * FROM #Table where ����� between 1000 and 1400 order by �����;
checkpoint;
DBCC DROPCLEANBUFFERS;

create clustered index #Table_CL on #Table(����� asc)
drop table #Table

--ex2--

CREATE TABLE #Table_2 (
    ����� INT,
    ������ VARCHAR(50),
    ���������� DECIMAL(10, 2)
);

DECLARE @x INT = 1;
WHILE @x <= 1500
BEGIN
    INSERT INTO #Table_2 (�����, ������, ����������)
    VALUES (@x, ' ������' + CAST(@x AS VARCHAR), @x * 1.5);
    SET @x = @x + 1;
END;

select * from #Table_2
select COUNT(*)[���������� �����] from #Table_2
create index #Table_2_NONCLU on #Table_2(�����, ����������)
select * from #Table_2 where ����� > 500 and ���������� < 900;
select * from #Table_2 order by �����,����������;

--ex3--
CREATE TABLE #Table_4(
    ����� INT,
    CC int identity(1,1),
    TF varchar(100)
);
set nocount on;
DECLARE @y INT = 0;
WHILE @y <= 2000
BEGIN
    INSERT INTO #Table_4(�����,TF)
	VALUES (floor(3000*Rand()), REPLICATE('������',10));
    SET @y = @y + 1;
END;
create index #Table_4_Key_X on #Table_4(�����) include (CC)
select CC from #Table_4 where ����� > 1500;

--ex4--
CREATE TABLE #Table_5(
    ����� INT,
    CC int identity(1,1),
    TF varchar(100)
);
set nocount on;
DECLARE @y INT = 0;
WHILE @y <= 2000
BEGIN
    INSERT INTO #Table_5(�����,TF)
	VALUES (floor(3000*Rand()), REPLICATE('������',10));
    SET @y = @y + 1;
END;

select ����� from #Table_5 where ����� between 500 and 900;
select ����� from #Table_5 where �����>700 and �����<1500;
select ����� from #Table_5 where �����=2000

create index #Table_5_where on #Table_5(�����) where (�����>500 and �����<1500);

--ex5--
CREATE TABLE #Table_6(
    ����� INT,
    CC int identity(1,1),
    TF varchar(100)
);
set nocount on;
DECLARE @y INT = 0;
WHILE @y <= 10000
BEGIN
    INSERT INTO #Table_6(�����,TF)
	VALUES (floor(3000*Rand()), REPLICATE('������',10));
    SET @y = @y + 1;
END;

create index #Table_6_Key on #Table_6(�����);
select name [������], avg_fragmentation_in_percent [������������(%)]
from sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'),
OBJECT_ID(N'#Table_6'),NULL, NULL, NULL) ss join sys.indexes ii on ss.object_id=ii.object_id and ss.object_id = ii.object_id where name is not null;

insert top (10000) #Table_6(�����, TF) select �����, TF from #Table_6;
alter index #Table_6_Key on #Table_6 reorganize;
alter index #Table_6_Key on #Table_6 rebuild with (online = off);
drop table #Table_6

--ex6--
drop index #Table_6_Key on #Table_6
create index #Table_6_Key on #Table_6(�����) with (fillfactor = 65)

insert top(50) percent into #Table_6(�����,TF)
select �����, TF from #Table_6;
select name [������], avg_fragmentation_in_percent [������������(%)]
from sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'),
OBJECT_ID(N'#Table_6'),NULL, NULL, NULL) ss join sys.indexes ii on ss.object_id=ii.object_id and ss.object_id = ii.object_id where name is not null;
