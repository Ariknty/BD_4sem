use master;
CREATE database Юдина_MyBase on primary
(name='Laba_mdf', filename='C:\Арина\4семестр\бд\Юдина_MyBase_mdf.mdf',
size = 10240Kb,maxsize=UNLIMITED, filegrowth=1024Kb),
( name = N'UNIVER_ndf', filename = N'C:\Арина\4семестр\бд\Юдина_MyBase_ndf.ndf', 
   size = 10240KB, maxsize=1Gb, filegrowth=25%),
filegroup FG1
( name = N'UNIVER_fg1_1', filename = N'C:\Арина\4семестр\бд\Юдина_MyBase_fg1_1.ndf', 
   size = 10240Kb, maxsize=1Gb, filegrowth=25%),
( name = N'UNIVER_fg1_2', filename = N'C:\Арина\4семестр\бд\Юдина_MyBase_fg1_2.ndf', 
   size = 10240Kb, maxsize=1Gb, filegrowth=25%)
log on
( name = N'UNIVER_log', filename=N'C:\Арина\4семестр\бд\Юдина_MyBase_log.ldf',       
   size=10240Kb,  maxsize=2048Gb, filegrowth=10%);

use Юдина_MyBase;

CREATE table Передача
(
  Название_передачи nvarchar(50) primary key,
  Рейтинг int
) on FG1;

CREATE table Заказчики
(
  Название_фирмы nvarchar(50) primary key,
  Банковкие_реквизиты int not null,
  Контактное_лицо nvarchar(50),
  Телефон nvarchar(15),
) on FG1;

CREATE table Реклама 
(
  id int primary key,
  Вид_рекламы nvarchar(50),
  Дата date,
  Заказчик nvarchar(50) foreign key  references Заказчики(Название_фирмы),
  Передача nvarchar(50) foreign key  references Передача(Название_передачи),
  Стоимость_минуты money not null,
  Длительность_в_минутах time not null
) on FG1;

ALTER Table Заказчики ADD Доп_информация nvarchar(50);
ALTER TABLE Заказчики DROP COLUMN Доп_информация;
			
ALTER Table Заказчики ADD Пол nvarchar(1) default 'м' check (ПОЛ in('м', 'ж'));
			
ALTER TABLE Заказчики DROP CONSTRAINT DF_Данные_клиента_Пол;
ALTER TABLE Заказчики DROP COLUMN Пол;


INSERT into Передача (Название_передачи, Рейтинг)
       Values ('Шоу', 5),
	          ('Конкурс', 4);

INSERT into Заказчики (Название_фирмы, Банковкие_реквизиты, Контактное_лицо, Телефон)
       Values ('Цветочки', 11111111, 'Ира Васильева', '+375445635869'),
	   ('Самсунг', 22221111, 'Катя Иришина', '+375295635869'),
	   ('Горизонт', 33331111, 'Лиза игнатьева', '+375175635869'),
	   ('Атлант', 44441111, 'Елена Григорьева', '+375295635844');

INSERT into Реклама (id, Вид_рекламы, Дата, Заказчик, Передача, Стоимость_минуты, Длительность_в_минутах)
       Values (1, 'Благотворительная', '2024-01-01', 'Цветочки', 'Шоу', 1500, '00:02:00'),
	   (2, 'Информационная', '2024-02-02', 'Горизонт', 'Шоу', 2500, '00:01:00'),
	   (3, 'Благотворительная', '2024-03-03', 'Атлант', 'Конкурс', 3500, '00:03:00'),
	   (4, 'Развлекательная', '2024-04-04', 'Самсунг', 'Конкурс', 1500, '00:04:00');

SELECT * From Реклама;
SELECT Вид_рекламы, Заказчик  From Реклама;
SELECT count(*) From Реклама; 
UPDATE Реклама set Стоимость_минуты = 5000 where Передача='Шоу';
SELECT * From Реклама;





