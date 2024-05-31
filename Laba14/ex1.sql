--ex1--
create table TR_AUDIT
(
  ID int identity,
  STMT varchar(20) check (STMT in ('INS', 'DEL','UPD')),
  TRNAME varchar (50),
  CC varchar (3000)
)

select * from TR_AUDIT
drop table TR_AUDIT

create trigger TR_TEACHER_INS on TEACHER after INSERT
as declare @a1 char(10), @a2 varchar(100), @a3 char(20), @in varchar(300);
print 'Операция вставки';
set @a1 = (select [TEACHER] from inserted);
set @a2 = (select [TEACHER_NAME] from inserted);
set @a3 = (select [PULPIT] from inserted);
set @in = @a1 + '' + @a2 + '' + @a3;
insert into TR_AUDIT(STMT, TRNAME, CC) values ('INS', 'TR_TEACHER_INS', @in);
return;

select * from TEACHER

insert into TEACHER(TEACHER, TEACHER_NAME, PULPIT)
values ('НОА', 'Новасельская Ольга Александровна', 'ИСиТ')


select * from TR_AUDIT

--ex2--

create trigger TR_TEACHER_DEL  on TEACHER after delete
as declare @a1 char(10), @a2 varchar(100), @a3 char(20), @in varchar(300);
print 'Операция удаления';
set @a1 = (select [TEACHER] from deleted);
set @a2 = (select [TEACHER_NAME] from deleted );
set @a3 = (select [PULPIT] from deleted);
set @in = @a1 + '' + @a2 + '' + @a3;
insert into TR_AUDIT(STMT, TRNAME, CC) values ('DEL', 'TR_TEACHER_DEL', @in);
return;

delete from TEACHER where TEACHER='НОА';
drop trigger TR_TACHER_DEL
select * from TR_AUDIT

--ex3--
create trigger TR_TEACHER_UPD  on TEACHER after update
as declare @a1 char(10), @a2 varchar(100), @a3 char(20), @in varchar(300);
print 'Операция обновления';
set @a1 = (select [TEACHER] from inserted);
set @a2 = (select [TEACHER_NAME] from inserted);
set @a3 = (select [PULPIT] from inserted);
set @in = @a1 + '' + @a2 + '' + @a3;
insert into TR_AUDIT(STMT, TRNAME, CC) values ('UPD', 'TR_TEACHER_UPD', @in);
return;

update TEACHER set TEACHER = 'ОХ' where TEACHER='ГРН';  
drop trigger TR_TACHER_UPD
select * from TEACHER;

--ex4--
alter trigger TR_TEACHER_INS on TEACHER after INSERT, DELETE, UPDATE
as declare @a1 char(10), @a2 varchar(100), @a3 char(20), @in varchar(300);
declare @ins int = (select COUNT(*) from inserted),
        @del int = (select COUNT(*) from deleted);
if @ins > 0 and @del = 0
begin
print 'Операция вставки';
set @a1 = (select [TEACHER] from inserted);
set @a2 = (select [TEACHER_NAME] from inserted);
set @a3 = (select [PULPIT] from inserted);
set @in = @a1 + '' + @a2 + '' + @a3;
insert into TR_AUDIT(STMT, TRNAME, CC) values ('INS', 'TR_TEACHER_INS', @in);
end;
else
if @ins = 0 and @del > 0
begin
print 'Операция удаления';
set @a1 = (select [TEACHER] from deleted);
set @a2 = (select [TEACHER_NAME] from deleted );
set @a3 = (select [PULPIT] from deleted);
set @in = @a1 + '' + @a2 + '' + @a3;
insert into TR_AUDIT(STMT, TRNAME, CC) values ('DEL', 'TR_TEACHER_INS', @in);
end;
else
if @ins>0 and @del>0
begin
print 'Операция обновления';
set @a1 = (select [TEACHER] from inserted);
set @a2 = (select [TEACHER_NAME] from inserted);
set @a3 = (select [PULPIT] from inserted);
set @in = @a1 + '' + @a2 + '' + @a3;
set @a1 = (select [TEACHER] from deleted);
set @a2 = (select [TEACHER_NAME] from deleted );
set @a3 = (select [PULPIT] from deleted);
set @in = @a1 + '' + @a2 + '' + @a3;
insert into TR_AUDIT(STMT, TRNAME, CC) values ('UPD', 'TR_TEACHER_INS', @in);
end;
return;

insert into TEACHER(TEACHER, TEACHER_NAME, PULPIT)
values ('ЩАН', 'Щербакова Алина Николаевна', 'ИСиТ')
delete from TEACHER where TEACHER='ЩАН';
update TEACHER set TEACHER = 'ОХ' where TEACHER='ЩАН'; 

--ex5--
create trigger TR_TEACHER_DEL1 on TEACHER after DELETE
as declare @a1 char(10), @a2 varchar(100), @a3 char(1), @a4 char(20), @in varchar(300);
print 'Операция удаления';
set @a1 = (select TEACHER from deleted);
set @a2 = (select TEACHER_NAME from deleted);
set @a3 = (select GENDER from deleted);
set @a4 = (select PULPIT from deleted);
set @in = @a1 + ' ' + @a2 + ' ' + @a3 + ' ' + @a4;
insert into TR_AUDIT(STMT, TRNAME, CC) values ('DEL', 'TRIG_TEACHER_DEL1', @in);
return;
go

create trigger TR_TEACHER_DEL2 on TEACHER after DELETE
as declare @a1 char(10), @a2 varchar(100), @a3 char(1), @a4 char(20), @in varchar(300);
print 'Операция удаления';
set @a1 = (select TEACHER from deleted);
set @a2 = (select TEACHER_NAME from deleted);
set @a3 = (select GENDER from deleted);
set @a4 = (select PULPIT from deleted);
set @in = @a1 + ' ' + @a2 + ' ' + @a3 + ' ' + @a4;
insert into TR_AUDIT(STMT, TRNAME, CC) values ('DEL', 'TRIG_TEACHER_DEL2', @in);
return;
go
create trigger TR_TEACHER_DEL3 on TEACHER after DELETE
as declare @a1 char(10), @a2 varchar(100), @a3 char(1), @a4 char(20), @in varchar(300);
print 'Операция удаления';
set @a1 = (select TEACHER from deleted);
set @a2 = (select TEACHER_NAME from deleted);
set @a3 = (select GENDER from deleted);
set @a4 = (select PULPIT from deleted);
set @in = @a1 + ' ' + @a2 + ' ' + @a3 + ' ' + @a4;
insert into TR_AUDIT(STMT, TRNAME, CC) values ('DEL', 'TRIG_TEACHER_DEL3', @in);
return;
go

select t.name, e.type_desc 
	from sys.triggers t join sys.trigger_events e
	on t.object_id = e.object_id
	where OBJECT_NAME(t.parent_id) = 'TEACHER' and e.type_desc='DELETE';

exec sp_settriggerorder @triggername = 'TR_TEACHER_DEL3',
	@order = 'First', @stmttype='DELETE';
exec sp_settriggerorder @triggername = 'TR_TEACHER_DEL2',
	@order = 'Last', @stmttype='DELETE';

go

delete from TEACHER where TEACHER.TEACHER = 'ЩАН';
select * from TR_AUDIT;

--ex6--
create trigger TR_TEACHER_EX6 on TEACHER after insert, delete, update
as declare @c int =(select count(TEACHER) from TEACHER);
if (@c >10)
begin raiserror ('Кол-во преподавателей не можеть быть >10', 10, 1);
rollback;
end;
return;

drop trigger TR_TEACHER_EX6
update TEACHER set PULPIT = 'ЛВ' where PULPIT='ИСиТ' 
select * from TEACHER

--ex7--
create trigger TR_INSTEAD_OF on FACULTY instead of delete
as raiserror (N'Удаление запрещено', 10, 1);
return;

delete from FACULTY where FACULTY = 'ИЭФ'
select * from FACULTY

--ex8--
create  trigger DDL_UNIVER on database for DDL_DATABASE_LEVEL_EVENTS  
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

drop trigger DDL_UNIVER

DROP TRIGGER DDL_UNIVER ON DATABASE


drop trigger TR_TEACHER_DEL3


