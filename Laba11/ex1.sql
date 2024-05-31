use master;
--ex1--
set nocount on
if exists (select * from SYS.OBJECTS
           where OBJECT_ID=object_id(N'ex_1'))
drop table ex_1;

declare @c int, @flag char='c';
set implicit_transactions on
create table ex_1(K int);
       insert ex_1 values (1),(2),(3);
	   set @c=(select COUNT(*) from ex_1);
	   print '���������� ����� � �������: ' + cast(@c as varchar(2));
	   if @flag='c' commit;
	   else rollback;
set implicit_transactions off

if exists (select * from SYS.OBJECTS
           where OBJECT_ID=object_id(N'DBO.ex_1'))
print '������� ����';
else print '������� �����������';
go
--ex2--

select * from AUDITORIUM
use UNIVER;
begin try
	begin tran
	delete AUDITORIUM where AUDITORIUM = '236-1';
    insert into AUDITORIUM values('325-1','��','5','��');
	insert into AUDITORIUM values('312-1','��','60','KR');
	commit tran;
end try
begin catch
	print '������: ' + cast(error_number() as varchar(5)) + ' ' + error_message()
	if @@TRANCOUNT > 0 
	rollback tran;
end catch;

--ex3--
DECLARE @point varchar(30);
begin try
	begin tran
		delete AUDITORIUM where AUDITORIUM_NAME = '302-1';
		set @point = '�1'; save transaction @point;
		insert into AUDITORIUM values('320-1','��','15','301-1');							
		set @point = '�2'; save transaction @point;
		insert into AUDITORIUM values('317-1','��-�','15','301-1');							
	commit tran;
end try
begin catch
	print '������: ' + cast(error_number() as varchar(5)) + ' ' + error_message()
	if @@TRANCOUNT > 0
		begin
			print '����������� �����: ' + @point;
			rollback tran @point;
			commit tran;
		end;
end catch;	

insert into AUDITORIUM values('301-1','��','15','301-1');

--ex4--

--�--
set transaction isolation level read uncommitted
begin transaction
--t1--
select @@spid, 'insert Pulpit''���������', * from PULPIT
select @@SPID, 'update Progress''���������', * from PROGRESS
commit;
--t2--
--�--
begin transaction
select @@spid
insert pulpit values ('��', '����������� ���������', '��');
update progress set note = note + 1 where SUBJECT = '����'
--t1--
--t2--
rollback;
select * from PROGRESS

--ex5--
delete AUDITORIUM where AUDITORIUM_NAME = '722';
delete AUDITORIUM where AUDITORIUM_NAME = '700';
delete AUDITORIUM where AUDITORIUM_NAME = '301-1';

select* from AUDITORIUM

set transaction isolation level read committed
begin transaction
select count(*) from AUDITORIUM where AUDITORIUM_CAPACITY = '100';
--t1--
--t2--
select 'update AUDITORIUM'  '���������',  AUDITORIUM_NAME, 
AUDITORIUM_TYPE,AUDITORIUM_CAPACITY from AUDITORIUM  
where  AUDITORIUM_NAME='413-1';
commit; 
--B--
set transaction isolation level read committed
begin transaction
--t1--
update AUDITORIUM set AUDITORIUM_CAPACITY = '90' 
where AUDITORIUM_NAME='413-1';	
commit; 
--t2--

select * from AUDITORIUM

--ex6--
set transaction isolation level REPEATABLE READ
begin transaction
select count(*) from subject where SUBJECT = '��';
--t1--
--t2--
select 'update subject' '���������', count(*)
from subject where subject = '��';
commit;

--B--
begin transaction
--t1--
update subject set SUBJECT_NAME = 'KG' where subject = '��'
commit;
--t2--

--ex7--
set transaction isolation level serializable
begin transaction
delete PROGRESS where NOTE=7;
insert PROGRESS values ('��', 1013,  '01.10.2013',5);
update PROGRESS set SUBJECT ='����' where NOTE = 5;
select SUBJECT, NOTE from PROGRESS where SUBJECT='����';
--t1--
select SUBJECT, NOTE from PROGRESS where SUBJECT='����';
--t2--
commit;

--B--
begin transaction
delete PROGRESS where NOTE=8;
insert PROGRESS values ('����', 1013,  '01.10.2013',8);
update PROGRESS set SUBJECT ='����' where NOTE = 9;
select SUBJECT, NOTE from PROGRESS where SUBJECT='����';
--t1--
commit
select SUBJECT, NOTE from PROGRESS where SUBJECT='����';
--t2--


--ex8--
begin tran
insert into SUBJECT values('����','����������� ���������� ���������������� �  ���������','����');   ;
begin tran
update SUBJECT set SUBJECT_NAME='����' where SUBJECT='����';
commit
if @@TRANCOUNT > 0 rollback;
select
(select count(*) from SUBJECT where SUBJECT='����') '����������',
(select count(*) from TEACHER inner join SUBJECT on TEACHER.PULPIT = SUBJECT.PULPIT) '�������������'

delete SUBJECT where SUBJECT='����';
