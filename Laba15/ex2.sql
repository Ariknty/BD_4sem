--ex1--
select t.Вид_рекламы, t.Заказчик, t.Длительность_в_минутах, t.Передача
from Реклама t where t.Вид_рекламы = 'Благотворительная' for xml RAW ('Реклама'),
root ('Список'), elements;
--ex2--
select tpe.Название_фирмы, a.Дата, a.Вид_рекламы 
		from Реклама a inner join Заказчики tpe on a.Заказчик = tpe.Название_фирмы
		where tpe.Название_фирмы = 'Цветочки'
		order by tpe.Название_фирмы for xml auto, root('Список'),elements;

--ex3--
declare @h int = 0,
	@x varchar(2000)='<?xml version="1.0" encoding="windows-1251" ?>
	<передачи>
					   	<передача название_передачи="кгиг" рейтинг= "7" />
					    <передача название_передачи="кгиг_1" рейтинг= "10" />
					    <передача название_передачи="кгиг_2" рейтинг= "10" />
	</передачи>';
	   exec sp_xml_preparedocument @h output, @x; --подготовка документа

insert into Передача select[Название_передачи], [Рейтинг] from openxml(@h, '/передачи/передача', 0)
    with([Название_передачи] varchar(50), [Рейтинг] char(10));
	select * from Передача
delete from Передача where Передача.Название_передачи='кгиг' or Передача.Рейтинг=7

--ex4--

insert Заказчики( Название_фирмы, Банковкие_реквизиты, Контактное_лицо, Телефон ) values
 ('Самсунг_1', 22221111, 'Катя Иришина', '+375295635869', 
'<STUDENT>
	<PASSPORT SERIES="МР" NUMBER="1111111" DATE="01.01.2016" />
	<PHONE>442184582</PHONE>
	<ADRESS>
		<COUNTRY>Беларусь</COUNTRY>
		<CITY>Минск</CITY>
		<STREET>Сырокомли</STREET>
		<HOUSE>38</HOUSE>
		<APPARTEMENT>13</APPARTEMENT>
	</ADRESS>
</STUDENT>')


update Заказчики set Телефон = 
'<STUDENT>
	<PASSPORT SERIES="МР" NUMBER="1111111" DATE="01.01.2016" />
	<PHONE>1111111</PHONE>
	<ADRESS>
		<COUNTRY>Беларусь_1</COUNTRY>
		<CITY>Солигорск</CITY>
		<STREET>Сырокомли</STREET>
		<HOUSE>38</HOUSE>
		<APPARTEMENT>6412</APPARTEMENT>
	</ADRESS>
</STUDENT>'
where Телефон.value('(/STUDENT/ADRESS/APPARTEMENT)[1]', 'varchar(10)') = cast(13 as varchar(10))


select  NAME [ФИО],
		INFO.value('(/STUDENT/PASSPORT/@SERIES)[1]', 'varchar(10)') Серия,
		INFO.value('(/STUDENT/PASSPORT/@NUMBER)[1]', 'varchar(10)') Номер,
		INFO.query('/STUDENT/ADRESS') Адрес
from STUDENT
where NAME = 'Юдина Арина Евгеньевна '

delete from STUDENT where NAME = 'Юдина Арина Евгеньевна'

select * from Передача