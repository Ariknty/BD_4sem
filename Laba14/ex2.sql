--ex1--
create table TR_��������
(
  ID int identity,
  STMT varchar(20) check (STMT in ('INS', 'DEL','UPD')),
  ��������_�������� varchar(50),
  ������� int
)

drop table TR_��������
select * from TR_��������
select * from ��������

create trigger TR_��������_INS on �������� after INSERT
as declare @a1 varchar(50), @a2 int, @in varchar(300);
print '�������� �������';
set @a1 = (select [��������_��������] from inserted);
set @a2 = (select [�������] from inserted);
set @in =@a1 + '' + cast(@a2 as varchar(50));
insert into TR_��������(STMT, ��������_��������, �������) values ('INS', @a1, @a2);
return;

drop trigger TR_��������_DEl
insert into ��������(��������_��������, �������)
values ('���_1', 6)

create trigger TR_��������_DEL on �������� after delete
as declare @a1 varchar(50), @a2 int, @in varchar(300);
print '�������� ��������';
set @a1 = (select [��������_��������] from deleted);
set @a2 = (select [�������] from deleted);
set @in =@a1 + '' + cast(@a2 as varchar(50));
insert into TR_��������(STMT, ��������_��������, �������) values ('DEL', @a1, @a2);
return;

delete from �������� where ��������_��������='���_1';
drop trigger TR_��������_DEL

create trigger TR_��������_UPD on �������� after update
as declare @a1 varchar(50), @a2 int, @in varchar(300);
print '�������� ����������';
set @a1 = (select [��������_��������] from inserted);
set @a2 = (select [�������] from inserted);
set @in =@a1 + '' + cast(@a2 as varchar(50));
insert into TR_��������(STMT, ��������_��������, �������) values ('UPD', @a1, @a2);
return;

update �������� set ������� = 10 where ��������_�������� = '���'

--ex4--
alter trigger TR_��������_INS on �������� after INSERT, delete, update
as declare @a1 varchar(50), @a2 int, @in varchar(300);
declare @ins int = (select COUNT(*) from inserted),
        @del int = (select COUNT(*) from deleted);
if @ins > 0 and @del = 0
begin
print '�������� �������';
set @a1 = (select [��������_��������] from inserted);
set @a2 = (select [�������] from inserted);
set @in =@a1 + '' + cast(@a2 as varchar(50));
insert into TR_��������(STMT, ��������_��������, �������) values ('INS', @a1, @a2);
end;
else
if @ins = 0 and @del > 0
begin
print '�������� ��������';
set @a1 = (select [��������_��������] from deleted);
set @a2 = (select [�������] from deleted);
set @in =@a1 + '' + cast(@a2 as varchar(50));
insert into TR_��������(STMT, ��������_��������, �������) values ('DEL', @a1, @a2);
end;
else
if @ins>0 and @del>0
begin
print '�������� ����������';
set @a1 = (select [��������_��������] from inserted);
set @a2 = (select [�������] from inserted);
set @in =@a1 + '' + cast(@a2 as varchar(50));
set @a1 = (select [��������_��������] from deleted);
set @a2 = (select [�������] from deleted);
set @in =@a1 + '' + cast(@a2 as varchar(50));
insert into TR_��������(STMT, ��������_��������, �������) values ('UPD', @a1, @a2);
end;
return;

insert into ��������(��������_��������, �������)
values ('���_2', 7)
delete from �������� where ��������_��������='���_2';
update �������� set ������� = 10 where ��������_�������� = '���_2'

create trigger TR_��������_DEL1 on �������� after delete
as declare @a1 varchar(50), @a2 int, @in varchar(300);
print '�������� ��������';
set @a1 = (select [��������_��������] from deleted);
set @a2 = (select [�������] from deleted);
set @in =@a1 + '' + cast(@a2 as varchar(50));
insert into TR_��������(STMT, ��������_��������, �������) values ('DEL', @a1, @a2);
return;

create trigger TR_��������_DEL2 on �������� after delete
as declare @a1 varchar(50), @a2 int, @in varchar(300);
print '�������� ��������';
set @a1 = (select [��������_��������] from deleted);
set @a2 = (select [�������] from deleted);
set @in =@a1 + '' + cast(@a2 as varchar(50));
insert into TR_��������(STMT, ��������_��������, �������) values ('DEL', @a1, @a2);
return;

create trigger TR_��������_DEL3 on �������� after delete
as declare @a1 varchar(50), @a2 int, @in varchar(300);
print '�������� ��������';
set @a1 = (select [��������_��������] from deleted);
set @a2 = (select [�������] from deleted);
set @in =@a1 + '' + cast(@a2 as varchar(50));
insert into TR_��������(STMT, ��������_��������, �������) values ('DEL', @a1, @a2);
return;

select t.name, e.type_desc from sys.triggers t join sys.trigger_events e
on t.object_id=e.object_id
where OBJECT_NAME(t.parent_id) = '��������' and e.type_desc='DELETE';

exec SP_SETTRIGGERORDER @triggername = 'TR_��������_DEL3', 
	                        @order = 'First', @stmttype = 'DELETE';

exec SP_settriggerorder @triggername = 'TR_��������_DEL2', 
	                        @order = 'Last', @stmttype = 'DELETE';


create trigger TR_TEACHER_EX6 on TEACHER after insert, delete, update
as declare @c int =(select count(TEACHER) from TEACHER);
if (@c >10)
begin raiserror ('���-�� �������������� �� ������ ���� >10', 10, 1);
rollback;
end;
return;

update TEACHER set PULPIT = '��' where PULPIT='����' 
select * from TEACHER

--ex7--
create trigger TR_��������_OF on �������� instead of delete
as raiserror (N'�������� ���������', 10, 1);
return;

delete from �������� where ��������_�������� = '�������'


--ex8--
create  trigger DDL_MyBase on database for DDL_DATABASE_LEVEL_EVENTS  
as   
declare @t varchar(50) =  EVENTDATA().value('(/EVENT_INS-TANCE/EventType)[1]', 'varchar(50)');
declare @t1 varchar(50) = EVENTDATA().value('(/EVENT_INS-TANCE/ObjectName)[1]', 'varchar(50)');
declare @t2 varchar(50) = EVENTDATA().value('(/EVENT_INS-TANCE/ObjectType)[1]', 'varchar(50)');
       print '��� �������: '+@t;
       print '��� �������: '+@t1;
       print '��� �������: '+@t2;
       raiserror( N'�������� � ��������� ��������� ', 16, 1);  
rollback; 


create TABLE Persons (
    PersonID int,
    LastName varchar(255),
    FirstName varchar(255),
    Address varchar(255),
    City varchar(255)
);

DROP TABLE Persons
