
--ex1--
create view [Информация_о_рекламе]
as select Вид_рекламы, Заказчик, Дата
from Реклама;

select * from Информация_о_рекламе

--ex2--
create view [Виды_рекламы]
as select Вид_рекламы, count (*) [Количество]
from Реклама join Заказчики
on Реклама.Заказчик = Заказчики.Название_фирмы
group by Реклама.Вид_рекламы;

select * from Виды_рекламы;

--ex3--
create view Вид_передачи (Заказчик, Вид_рекламы)
as select Заказчик, Вид_рекламы
from Реклама where Передача like 'Шоу'

select * from Вид_передачи

--ex4--
create view Вид_передачи_1 (Заказчик, Вид_рекламы)
as select Заказчик, Вид_рекламы
from Реклама where Передача like 'Шоу' with check option;

select * from Вид_передачи_1

--ex5--
create view Информация_о_заказчике (Кто, Номер, Представитель)
as select top 3 Название_фирмы, Телефон, Контактное_лицо
from Заказчики order by Название_фирмы

select * from Информация_о_заказчике

--ex6--
alter view [Виды_рекламы] with schemabinding
as select Вид_рекламы, count (*) [Количество]
from dbo.Реклама join dbo.Заказчики
on Реклама.Заказчик = Заказчики.Название_фирмы
group by Реклама.Вид_рекламы;

select * from Виды_рекламы

