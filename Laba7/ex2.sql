
--ex1--
create view [����������_�_�������]
as select ���_�������, ��������, ����
from �������;

select * from ����������_�_�������

--ex2--
create view [����_�������]
as select ���_�������, count (*) [����������]
from ������� join ���������
on �������.�������� = ���������.��������_�����
group by �������.���_�������;

select * from ����_�������;

--ex3--
create view ���_�������� (��������, ���_�������)
as select ��������, ���_�������
from ������� where �������� like '���'

select * from ���_��������

--ex4--
create view ���_��������_1 (��������, ���_�������)
as select ��������, ���_�������
from ������� where �������� like '���' with check option;

select * from ���_��������_1

--ex5--
create view ����������_�_��������� (���, �����, �������������)
as select top 3 ��������_�����, �������, ����������_����
from ��������� order by ��������_�����

select * from ����������_�_���������

--ex6--
alter view [����_�������] with schemabinding
as select ���_�������, count (*) [����������]
from dbo.������� join dbo.���������
on �������.�������� = ���������.��������_�����
group by �������.���_�������;

select * from ����_�������

