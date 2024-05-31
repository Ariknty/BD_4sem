--ex1--
create table TR_ПЕРЕДАЧА
(
  ID int identity,
  STMT varchar(20) check (STMT in ('INS', 'DEL','UPD')),
  Название_передачи varchar(50),
  Рейтинг int
)

drop table TR_ПЕРЕДАЧА
select * from TR_ПЕРЕДАЧА
select * from Передача

create trigger TR_ПЕРЕДАЧА_INS on Передача after INSERT
as declare @a1 varchar(50), @a2 int, @in varchar(300);
print 'Операция вставки';
set @a1 = (select [Название_передачи] from inserted);
set @a2 = (select [Рейтинг] from inserted);
set @in =@a1 + '' + cast(@a2 as varchar(50));
insert into TR_ПЕРЕДАЧА(STMT, Название_передачи, Рейтинг) values ('INS', @a1, @a2);
return;

drop trigger TR_ПЕРЕДАЧА_DEl
insert into Передача(Название_передачи, Рейтинг)
values ('Шоу_1', 6)

create trigger TR_ПЕРЕДАЧА_DEL on Передача after delete
as declare @a1 varchar(50), @a2 int, @in varchar(300);
print 'Операция удаления';
set @a1 = (select [Название_передачи] from deleted);
set @a2 = (select [Рейтинг] from deleted);
set @in =@a1 + '' + cast(@a2 as varchar(50));
insert into TR_ПЕРЕДАЧА(STMT, Название_передачи, Рейтинг) values ('DEL', @a1, @a2);
return;

delete from Передача where Название_передачи='Шоу_1';
drop trigger TR_ПЕРЕДАЧА_DEL

create trigger TR_ПЕРЕДАЧА_UPD on Передача after update
as declare @a1 varchar(50), @a2 int, @in varchar(300);
print 'Операция обновнения';
set @a1 = (select [Название_передачи] from inserted);
set @a2 = (select [Рейтинг] from inserted);
set @in =@a1 + '' + cast(@a2 as varchar(50));
insert into TR_ПЕРЕДАЧА(STMT, Название_передачи, Рейтинг) values ('UPD', @a1, @a2);
return;

update Передача set Рейтинг = 10 where Название_передачи = 'Шоу'

--ex4--
alter trigger TR_ПЕРЕДАЧА_INS on Передача after INSERT, delete, update
as declare @a1 varchar(50), @a2 int, @in varchar(300);
declare @ins int = (select COUNT(*) from inserted),
        @del int = (select COUNT(*) from deleted);
if @ins > 0 and @del = 0
begin
print 'Операция вставки';
set @a1 = (select [Название_передачи] from inserted);
set @a2 = (select [Рейтинг] from inserted);
set @in =@a1 + '' + cast(@a2 as varchar(50));
insert into TR_ПЕРЕДАЧА(STMT, Название_передачи, Рейтинг) values ('INS', @a1, @a2);
end;
else
if @ins = 0 and @del > 0
begin
print 'Операция удаления';
set @a1 = (select [Название_передачи] from deleted);
set @a2 = (select [Рейтинг] from deleted);
set @in =@a1 + '' + cast(@a2 as varchar(50));
insert into TR_ПЕРЕДАЧА(STMT, Название_передачи, Рейтинг) values ('DEL', @a1, @a2);
end;
else
if @ins>0 and @del>0
begin
print 'Операция обновления';
set @a1 = (select [Название_передачи] from inserted);
set @a2 = (select [Рейтинг] from inserted);
set @in =@a1 + '' + cast(@a2 as varchar(50));
set @a1 = (select [Название_передачи] from deleted);
set @a2 = (select [Рейтинг] from deleted);
set @in =@a1 + '' + cast(@a2 as varchar(50));
insert into TR_ПЕРЕДАЧА(STMT, Название_передачи, Рейтинг) values ('UPD', @a1, @a2);
end;
return;

insert into Передача(Название_передачи, Рейтинг)
values ('Шоу_2', 7)
delete from Передача where Название_передачи='Шоу_2';
update Передача set Рейтинг = 10 where Название_передачи = 'Шоу_2'

create trigger TR_ПЕРЕДАЧА_DEL1 on Передача after delete
as declare @a1 varchar(50), @a2 int, @in varchar(300);
print 'Операция удаления';
set @a1 = (select [Название_передачи] from deleted);
set @a2 = (select [Рейтинг] from deleted);
set @in =@a1 + '' + cast(@a2 as varchar(50));
insert into TR_ПЕРЕДАЧА(STMT, Название_передачи, Рейтинг) values ('DEL', @a1, @a2);
return;

create trigger TR_ПЕРЕДАЧА_DEL2 on Передача after delete
as declare @a1 varchar(50), @a2 int, @in varchar(300);
print 'Операция удаления';
set @a1 = (select [Название_передачи] from deleted);
set @a2 = (select [Рейтинг] from deleted);
set @in =@a1 + '' + cast(@a2 as varchar(50));
insert into TR_ПЕРЕДАЧА(STMT, Название_передачи, Рейтинг) values ('DEL', @a1, @a2);
return;

create trigger TR_ПЕРЕДАЧА_DEL3 on Передача after delete
as declare @a1 varchar(50), @a2 int, @in varchar(300);
print 'Операция удаления';
set @a1 = (select [Название_передачи] from deleted);
set @a2 = (select [Рейтинг] from deleted);
set @in =@a1 + '' + cast(@a2 as varchar(50));
insert into TR_ПЕРЕДАЧА(STMT, Название_передачи, Рейтинг) values ('DEL', @a1, @a2);
return;

select t.name, e.type_desc from sys.triggers t join sys.trigger_events e
on t.object_id=e.object_id
where OBJECT_NAME(t.parent_id) = 'ПЕРЕДАЧА' and e.type_desc='DELETE';

exec SP_SETTRIGGERORDER @triggername = 'TR_ПЕРЕДАЧА_DEL3', 
	                        @order = 'First', @stmttype = 'DELETE';

exec SP_settriggerorder @triggername = 'TR_ПЕРЕДАЧА_DEL2', 
	                        @order = 'Last', @stmttype = 'DELETE';


create trigger TR_TEACHER_EX6 on TEACHER after insert, delete, update
as declare @c int =(select count(TEACHER) from TEACHER);
if (@c >10)
begin raiserror ('Кол-во преподавателей не можеть быть >10', 10, 1);
rollback;
end;
return;

update TEACHER set PULPIT = 'ЛВ' where PULPIT='ИСиТ' 
select * from TEACHER

--ex7--
create trigger TR_ПЕРЕДАЧА_OF on Передача instead of delete
as raiserror (N'Удаление запрещено', 10, 1);
return;

delete from Передача where Название_передачи = 'Конкурс'


--ex8--
create  trigger DDL_MyBase on database for DDL_DATABASE_LEVEL_EVENTS  
as   
declare @t varchar(50) =  EVENTDATA().value('(/EVENT_INS-TANCE/EventType)[1]', 'varchar(50)');
declare @t1 varchar(50) = EVENTDATA().value('(/EVENT_INS-TANCE/ObjectName)[1]', 'varchar(50)');
declare @t2 varchar(50) = EVENTDATA().value('(/EVENT_INS-TANCE/ObjectType)[1]', 'varchar(50)');
       print 'Тип события: '+@t;
       print 'Имя объекта: '+@t1;
       print 'Тип объекта: '+@t2;
       raiserror( N'Операции с таблицами запрещены ', 16, 1);  
rollback; 


create TABLE Persons (
    PersonID int,
    LastName varchar(255),
    FirstName varchar(255),
    Address varchar(255),
    City varchar(255)
);

DROP TABLE Persons
