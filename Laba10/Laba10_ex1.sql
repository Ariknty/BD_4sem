--ex1--
declare @list char(20), @l char(300) = '';
declare listSubject cursor for select SUBJECT_NAME from SUBJECT where PULPIT = '����'
open listSubject;
fetch listSubject into @list;
print '����������'
while @@FETCH_STATUS=0
begin 
set @l=RTRIM(@list) + ',' + @l;
fetch listSubject into @list
end;
print @l;
close listSubject;

DEALLOCATE listSubject;

--ex2--
declare puplit_cursor cursor global for select PULPIT.FACULTY from PULPIT where PULPIT.PULPIT='����'
declare @pupl char(50), @pupls char(100) ='';
open Puplit_cursor;
fetch  Puplit_cursor into @pupl;
	set @pupls ='1. ' + @pupl;	
	print @pupls;
go
close Puplit_cursor;

declare puplit_cursor_L cursor global for select PULPIT.FACULTY from PULPIT where PULPIT.PULPIT='����'
declare @pupl char(50), @pupls char(100) ='';
open puplit_cursor_L;
fetch  puplit_cursor_L into @pupl;
	set @pupls ='2. ' + @pupl;	
	print @pupls;
go
close puplit_cursor_L;
deallocate puplit_cursor_L;
go

--ex3--
declare cur_S cursor local static for (select a.AUDITORIUM, a.AUDITORIUM_TYPE, a.AUDITORIUM_CAPACITY from AUDITORIUM a)
declare @name varchar(10),  @type varchar(5),  @cap int

open cur_S
print '���-�� �����: ' + cast(@@cursor_rows as char)
--update AUDITORIUM set AUDITORIUM_TYPE = '��-�' where AUDITORIUM = '1234567'		
fetch cur_S into @name, @type, @cap
while @@FETCH_STATUS = 0
begin
	print @name + ' ' + @type + ' ' + cast(@cap as char) 
	fetch cur_S into @name, @type, @cap
end
close cur_S
go 

declare cur_D cursor local dynamic for (select a.AUDITORIUM, a.AUDITORIUM_TYPE, a.AUDITORIUM_CAPACITY from AUDITORIUM a)
declare @name varchar(10), @type varchar(5), @cap int

open cur_D
print '���-�� �����: ' + cast(@@cursor_rows as char)
--update AUDITORIUM set AUDITORIUM_TYPE = '��-�' where AUDITORIUM = '200-3�'		
fetch cur_D into @name, @type, @cap
while @@FETCH_STATUS = 0
begin
	print @name + ' ' + @type + ' ' + cast(@cap as char) 
	fetch cur_D into @name, @type, @cap
end
close cur_D

--ex4--
declare cur cursor local dynamic scroll for 
	select row_number() over (order by p.SUBJECT), p.IDSTUDENT, p.SUBJECT, p.NOTE from PROGRESS p
declare @rn int, @id varchar(10), @sub varchar(15), @nt int
open cur

fetch cur into @rn, @id, @sub, @nt
print 'First:    ' + cast(@rn as varchar) + @id + ' ������� � ' + rtrim(cast(@sub as varchar)) + ' ������= ' + cast(@nt as varchar) 
																										 
fetch next from cur into @rn, @id, @sub, @nt															 
print 'Next:     ' + cast(@rn as varchar) + @id + ' ������� � ' + rtrim(cast(@sub as varchar)) + ' ������= ' + cast(@nt as varchar) 
																										 
fetch relative 8 from cur into @rn, @id, @sub, @nt														 
print '8 rel:    ' + cast(@rn as varchar) + @id + ' ������� � ' + rtrim(cast(@sub as varchar)) + ' ������= ' + cast(@nt as varchar)
																										 
fetch absolute -20 from cur into @rn, @id, @sub, @nt													 
print '-20 abs:  ' + cast(@rn as varchar) + @id + ' ������� � ' + rtrim(cast(@sub as varchar)) + ' ������= ' + cast(@nt as varchar) 
																										 
fetch prior from cur into @rn, @id, @sub, @nt															 
print 'Prior:    ' + cast(@rn as varchar) + @id + ' ������� � ' + rtrim(cast(@sub as varchar)) + ' ������= ' + cast(@nt as varchar) 
																										 
fetch last from cur into @rn, @id, @sub, @nt															 
print 'Last:     ' + cast(@rn as varchar) + @id + ' ������� � ' + rtrim(cast(@sub as varchar)) + ' ������= ' + cast(@nt as varchar) 

close cur

--ex5--
declare cur cursor local dynamic for 
	select p.IDSTUDENT, p.SUBJECT, p.NOTE from PROGRESS p FOR UPDATE
declare @id varchar(10), @sub varchar(15), @nt int
open cur
fetch cur into @id, @sub, @nt
print @id  + rtrim(cast(@sub as varchar)) + '������ ' + cast(@nt as varchar)
delete PROGRESS where CURRENT OF cur
fetch cur into @id, @sub, @nt
update PROGRESS set NOTE = NOTE + 1 where CURRENT OF cur
print ''
print @id  + rtrim(cast(@sub as varchar)) + '������ ' + cast(@nt as varchar)
close cur

--ex6--
declare cur cursor local dynamic for 
	select p.IDSTUDENT, s.NAME, p.NOTE from PROGRESS p
	join STUDENT s on s.IDSTUDENT = p.IDSTUDENT
	where p.NOTE < 4
		FOR UPDATE
declare @id varchar(5), @nm varchar(50), @nt int
open cur
fetch cur into @id, @nm, @nt
print @id + @nm + '������= ' + cast(@nt as varchar)
delete PROGRESS where CURRENT OF cur	-- �� ���������, ��� ��������
delete STUDENT where CURRENT OF cur
close cur

declare cur cursor local dynamic for 
	select p.IDSTUDENT, s.NAME, p.NOTE from PROGRESS p
	join STUDENT s on s.IDSTUDENT = p.IDSTUDENT
	where p.IDSTUDENT = 1011
		FOR UPDATE
declare @id varchar(5), @nm varchar(50), @nt int
open cur
fetch cur into @id, @nm, @nt
update PROGRESS set NOTE = NOTE + 1 where CURRENT OF cur
print @id + @nm + '������= ' + cast(@nt as varchar)	-- ���������� ������ �� 1
close cur
