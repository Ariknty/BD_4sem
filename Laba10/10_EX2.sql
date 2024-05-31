--ex1--
declare @list char(20), @l char(300) = '';
declare listSubject cursor for select �������� from ������� where ���_������� = '�����������������'
open listSubject;
fetch listSubject into @list;
print '���������'
while @@FETCH_STATUS=0
begin 
set @l=RTRIM(@list) + ',' + @l;
fetch listSubject into @list
end;
print @l;
close listSubject;

--ex2--
declare puplit_cursor cursor global for select �������� from ������� where ���_������� = '�����������������'
declare @pupl char(50), @pupls char(100) ='';
open Puplit_cursor;
fetch  Puplit_cursor into @pupl;
	set @pupls ='1. ' + @pupl;	
	print @pupls;
go
close Puplit_cursor;

declare puplit_cursor cursor global for select �������� from ������� where ���_������� = '�����������������'
declare @pupl char(50), @pupls char(100) ='';
open Puplit_cursor;
fetch  Puplit_cursor into @pupl;
	set @pupls ='2. ' + @pupl;	
	print @pupls;
go
close Puplit_cursor;
deallocate puplit_cursor_L;
go

--ex3--
declare cur_S cursor local static for (select �.��������_�����, �.����������_����, �.���������_��������� from ��������� �)
declare @name varchar(20),  @type varchar(20),  @cap int

open cur_S
print '���-�� �����: ' + cast(@@cursor_rows as char)
--update ��������� set  ��������_����� = 'Apple' where ����������_���������  = '1%'		
fetch cur_S into @name, @type, @cap
while @@FETCH_STATUS = 0
begin
	print @name + ': ' + @type + ' '  + cast(@cap as char) 
	fetch cur_S into @name, @type, @cap
end
close cur_S
go 

declare cur_D cursor local dynamic for (select �.��������_�����, �.����������_����, �.���������_��������� from ��������� �)
declare @name varchar(20), @type varchar(20), @cap int

open cur_D
print '���-�� �����: ' + cast(@@cursor_rows as char)
--update ��������� set  ��������_����� = 'Apple' where ����������_���������  = '1%'		
fetch cur_D into @name, @type, @cap
while @@FETCH_STATUS = 0
begin
	print @name + ' ' + @type + ' ' + cast(@cap as char) 
	fetch cur_D into @name, @type, @cap
end
close cur_D

--ex4--
declare cur cursor local dynamic scroll for 
	select row_number() over (order by �.��������_�����), �.��������_�����, �.����������_����, �.���������_��������� from ��������� �
declare @rn int, @id varchar(10), @sub varchar(15), @nt int
open cur

fetch cur into @rn, @id, @sub, @nt
print  @id + ': ' + rtrim(cast(@sub as varchar)) + ' ����= ' + cast(@nt as varchar) 
																										 
fetch next from cur into @rn, @id, @sub, @nt															 
print @id + ': ' + rtrim(cast(@sub as varchar)) + ' ����= ' + cast(@nt as varchar) 
																										 
fetch relative 8 from cur into @rn, @id, @sub, @nt														 
print @id + ': ' + rtrim(cast(@sub as varchar)) + ' ����= ' + cast(@nt as varchar)
																										 
fetch absolute -20 from cur into @rn, @id, @sub, @nt													 
print @id + ': ' + rtrim(cast(@sub as varchar)) + ' ����= ' + cast(@nt as varchar) 
																										 
fetch prior from cur into @rn, @id, @sub, @nt															 
print @id + ': ' + rtrim(cast(@sub as varchar)) + ' ����= ' + cast(@nt as varchar) 
																										 
fetch last from cur into @rn, @id, @sub, @nt															 
print @id + ': ' + rtrim(cast(@sub as varchar)) + ' ����= ' + cast(@nt as varchar) 

close cur

--ex5--
declare cur cursor local dynamic for 
	select �.��������_�����, �.����������_����, �.���������_��������� from ��������� � FOR UPDATE
declare @id varchar(10), @sub varchar(15), @nt int
open cur
fetch cur into @id, @sub, @nt
print @id  + rtrim(cast(@sub as varchar)) + '������ ' + cast(@nt as varchar)
delete ��������� where CURRENT OF cur
fetch cur into @id, @sub, @nt
update ��������� set ��������_����� = ��������_����� + 1 where CURRENT OF cur
print ''
print @id  + rtrim(cast(@sub as varchar)) + '������ ' + cast(@nt as varchar)
close cur

--ex6--
declare cur cursor local dynamic for 
	select .��������_�����, �.����������_����, �.���������_��������� from ��������� �
	join ������� s on s.�������� = �.��������_�����
	where �.��������_����� = '��������'
		FOR UPDATE
declare @id varchar(20), @nm varchar(50), @nt int
open cur
fetch cur into @id, @nm, @nt
print @id + @nm + cast(@nt as varchar)
delete ��������� where CURRENT OF cur	-- �� ���������, ��� ��������
delete ������� where CURRENT OF cur
close cur

declare cur cursor local dynamic for 
	select .��������_�����, �.����������_����, �.���������_��������� from ��������� �
	join ������� s on s.�������� = �.��������_�����
	where �.��������_����� = '��������'
		FOR UPDATE
declare @id varchar(5), @nm varchar(50), @nt int
open cur
fetch cur into @id, @nm, @nt
update ��������� set ������� = ������� + 1 where CURRENT OF cur
print @id + @nm + cast(@nt as varchar)	-- ���������� ������� �� 1
close cur
