--ex1--
create function COUNT_���������� (@zk varchar(20)) returns int
as begin declare @rc int =0;
set @rc = (select count(*) from ��������� �
           join ������� � on �.��������_�����=�.�������� where �.��������_�����=@zk)
return @rc
end;

declare @f int = dbo.COUNT_����������('��������');
print '���������� ����������: ' + convert(varchar(4), @f);

select ��������_�����, dbo.COUNT_����������(��������_�����) from ���������;
go
--ex2--

create function F_��������� (@p varchar (20)) returns char(300)
as begin 
declare @tv char(20);
declare @t varchar(300)='��� �������: ';
declare FCUR cursor local
for select ���_������� from ������� where ��������=@p;
open FCUR;
fetch FCUR into @tv;
while @@FETCH_STATUS=0
begin
set @t=@t + ',' + RTRIM(@tv);
fetch FCUR into @tv;
end;
return @t;
end;

select ��������_�����, dbo. F_���������(��������_�����) from ���������
go
--ex3--
create function F_�����(@f varchar(10), @p varchar(10)) returns table
as return
select f.��������_�����, p.���_������� from ��������� f left outer join ������� p
on f.��������_�����=p.��������
where f.��������_�����=ISNULL(@f, f.��������_�����) and p.���_�������=ISNULL(@p, p.���_�������);

select * from dbo.F_�����(null, null)
select * from dbo.F_�����('��������', null)
select * from dbo.F_�����(null, '�������������')
select * from dbo.F_�����('������', '�������������')
go
--ex4--
create function FC_������� (@p varchar(50)) returns int
as begin
declare @rc int=(select count(*) from �������
where ���_�������=ISNULL(@p, ���_�������));
return @rc;
end;

select ���_�������, dbo.FC_�������(���_�������) [����������]
from �������


