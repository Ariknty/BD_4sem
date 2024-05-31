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
	   print 'количество строк в таблице: ' + cast(@c as varchar(2));
	   if @flag='c' commit;
	   else rollback;
set implicit_transactions off

if exists (select * from SYS.OBJECTS
           where OBJECT_ID=object_id(N'DBO.ex_1'))
print 'таблица есть';
else print 'таблица отсутствует';
go
--ex2--

select * from AUDITORIUM
use UNIVER;
begin try
	begin tran
	delete AUDITORIUM where AUDITORIUM = '236-1';
    insert into AUDITORIUM values('325-1','ЛК','5','ЛК');
	insert into AUDITORIUM values('312-1','ЛК','60','KR');
	commit tran;
end try
begin catch
	print 'Ошибка: ' + cast(error_number() as varchar(5)) + ' ' + error_message()
	if @@TRANCOUNT > 0 
	rollback tran;
end catch;

--ex3--
DECLARE @point varchar(30);
begin try
	begin tran
		delete AUDITORIUM where AUDITORIUM_NAME = '302-1';
		set @point = 'р1'; save transaction @point;
		insert into AUDITORIUM values('320-1','ЛК','15','301-1');							
		set @point = 'р2'; save transaction @point;
		insert into AUDITORIUM values('317-1','ЛК-К','15','301-1');							
	commit tran;
end try
begin catch
	print 'Ошибка: ' + cast(error_number() as varchar(5)) + ' ' + error_message()
	if @@TRANCOUNT > 0
		begin
			print 'Контрольная точка: ' + @point;
			rollback tran @point;
			commit tran;
		end;
end catch;	

insert into AUDITORIUM values('301-1','ЛК','15','301-1');

--ex4--

--А--
set transaction isolation level read uncommitted
begin transaction
--t1--
select @@spid, 'insert Pulpit''Результат', * from PULPIT
select @@SPID, 'update Progress''Результат', * from PROGRESS
commit;
--t2--
--В--
begin transaction
select @@spid
insert pulpit values ('ПИ', 'Программной инженерии', 'ИТ');
update progress set note = note + 1 where SUBJECT = 'ОАиП'
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
select 'update AUDITORIUM'  'результат',  AUDITORIUM_NAME, 
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
select count(*) from subject where SUBJECT = 'КГ';
--t1--
--t2--
select 'update subject' 'Результат', count(*)
from subject where subject = 'КГ';
commit;

--B--
begin transaction
--t1--
update subject set SUBJECT_NAME = 'KG' where subject = 'КГ'
commit;
--t2--

--ex7--
set transaction isolation level serializable
begin transaction
delete PROGRESS where NOTE=7;
insert PROGRESS values ('БД', 1013,  '01.10.2013',5);
update PROGRESS set SUBJECT ='ОАиП' where NOTE = 5;
select SUBJECT, NOTE from PROGRESS where SUBJECT='ОАиП';
--t1--
select SUBJECT, NOTE from PROGRESS where SUBJECT='ОАиП';
--t2--
commit;

--B--
begin transaction
delete PROGRESS where NOTE=8;
insert PROGRESS values ('ОАиП', 1013,  '01.10.2013',8);
update PROGRESS set SUBJECT ='ОАиП' where NOTE = 9;
select SUBJECT, NOTE from PROGRESS where SUBJECT='ОАиП';
--t1--
commit
select SUBJECT, NOTE from PROGRESS where SUBJECT='ОАиП';
--t2--


--ex8--
begin tran
insert into SUBJECT values('СТПИ','Современные технологии программирования в  интернете','ИСиТ');   ;
begin tran
update SUBJECT set SUBJECT_NAME='СТПИ' where SUBJECT='СТПИ';
commit
if @@TRANCOUNT > 0 rollback;
select
(select count(*) from SUBJECT where SUBJECT='СТПИ') 'Дисциплина',
(select count(*) from TEACHER inner join SUBJECT on TEACHER.PULPIT = SUBJECT.PULPIT) 'Преподаватели'

delete SUBJECT where SUBJECT='СТПИ';
