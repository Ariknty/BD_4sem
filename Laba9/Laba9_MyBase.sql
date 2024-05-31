use Юдина_MyBase
exec sp_helpindex 'Заказчики'
exec sp_helpindex 'Передача'
exec sp_helpindex 'Реклама'

CREATE TABLE #Table(
    Number INT,
    CC int identity(1,1),
    TF varchar(100)
);
set nocount on;
DECLARE @y INT = 0;
WHILE @y <= 2000
BEGIN
    INSERT INTO #Table(Number,TF)
	VALUES (floor(3000*Rand()), REPLICATE('Строка',10));
    SET @y = @y + 1;
END;

select Number from #Table where Number between 500 and 900;
select Number from #Table where Number>700 and Number<1500;
select Number from #Table where Number=1000

create index #Table_where on #Table(Number) where (Number>500 and Number<1500);
