use �����_MyBase
go
create procedure �_�������
as 
begin
declare @k int = (select COUNT(*) from �������);
select * from �������
return @k
end
go

exec �_�������

drop procedure �_�������

--ex2--
declare @k int = 0;
exec �_�������;
print '���������� �����: ' + cast (@k as varchar(10));
go

alter procedure �_������� @p varchar(20), @c int output
as begin
declare @k int =(select count(*) from �������);
print '��������� @p= ' + @p + ' @c= ' + cast(@c as varchar(10));
select * from ������� where ���_�������=@p;
set @c=@@ROWCOUNT;
return @k;
end;

declare @k int=0, @r int=0, @p varchar(20);
exec @k=�_������� @p='�����������������', @c=@r output
print '����� ����������: ' + cast(@k as varchar(10));
print '���-�� ����� ����������� �������' + cast(@p as varchar(10)) + '=' + cast(@r as varchar);
go

--ex3--
alter procedure �_������� @p varchar(20)
as begin
declare @k int = (select count(*) from �������);
select * from ������� where ���_�������=@p;
end;

CREATE table #������� 
(
  id int primary key,
  ���_������� nvarchar(50),
  ���� date,
  �������� nvarchar(50),
  �������� nvarchar(50),
  ���������_������ money not null,
  ������������_�_������� time not null
)

insert #������� exec �_������� @p='�����������������';
insert #������� exec �_������� @p='��������������';

select * from #�������
go
--ex4--


create procedure ���������_INSERT
@a nvarchar(50), @n int, @c nvarchar(50) = null, @t nvarchar(15)
as declare @rc int = 1;
begin try
insert into ��������� (��������_�����, ���������_���������, ����������_����, �������)
values (@a, @n, @c, @t)
return @rc;
end try
begin catch
print '����� ������: ' + convert(varchar(6), error_number());
	print '���������: ' + error_message();
	print '�������: ' + convert(varchar(6), error_severity());
	print '�����: ' + convert(varchar(8), error_state());
	print '����� ������: ' + convert(varchar(8), error_line());
	if error_procedure() is not null
		print '��� ���������: ' + error_procedure();
	return -1;
end catch;

declare @rc int;
exec @rc= ���������_INSERT @a = '�����', @n = 12121213, @c = '���--��', @t = '+33344';
print '��� ������: ' + convert(varchar(3), @rc);

go
--ex5--
drop procedure ��������_REPORT

create procedure ��������_REPORT @p int
as
declare @rc int = 0;
begin try
declare @tv nvarchar(50), @t int;
declare SUB cursor for
select ��������_�������� from �������� where �������=@p;
if not exists (select ��������_�������� from �������� where �������=@p)
raiserror ('������', 11,1)
else
open REPORT;
fetch REPORT into @tv;
print '������ ���������: ';
while @@FETCH_STATUS=0
begin
set @t=RTRIM(@tv) + ',' + @t;
set @rc = @rc + 1;
fetch REPORT into @tv;
end;
print @t;
close SUB;
return @rc;
end try
begin catch
print '������ � ����������'
if ERROR_PROCEDURE() is not null
print '��� ���������: ' + ERROR_PROCEDURE();
return @rc;
end catch;


declare @rc int;
exec @rc=��������_REPORT @p = 3;
print '���������� ������� = ' + cast(@rc as varchar(3));

--ex6--
create procedure ���������_INSERTEX
@a nvarchar(50), @n int, @c nvarchar(50) = null, @t nvarchar(15)
as declare @rc int = 1;
begin try
set transaction isolation level SERIALIZABLE;
begin tran
insert into ��������� (��������_�����, ���������_���������, ����������_����, �������)
values (@a, @n, @c, @t)
exec @rc = ���������_INSERTEX @a, @n, @c, @t;  
commit tran;
return @rc; 
end try
begin catch
    print '����� ������: ' + convert(varchar(6), error_number());
	print '���������: ' + error_message();
	print '�������: ' + convert(varchar(6), error_severity());
	print '�����: ' + convert(varchar(8), error_state());
	print '����� ������: ' + convert(varchar(8), error_line());
	if error_procedure() is not null
    print '��� ���������: ' + error_procedure();
if @@TRANCOUNT>0 rollback tran;
return -1;
end catch;

declare @rc int;
exec @rc= ���������_INSERT @a = 'T�TT', @n = 929279292, @c = '���-��_19', @t = '+332222';
print '��� ������ = ' + convert(varchar(3), @rc); 
