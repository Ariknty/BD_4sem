--ex1--
select t.���_�������, t.��������, t.������������_�_�������, t.��������
from ������� t where t.���_������� = '�����������������' for xml RAW ('�������'),
root ('������'), elements;
--ex2--
select tpe.��������_�����, a.����, a.���_������� 
		from ������� a inner join ��������� tpe on a.�������� = tpe.��������_�����
		where tpe.��������_����� = '��������'
		order by tpe.��������_����� for xml auto, root('������'),elements;

--ex3--
declare @h int = 0,
	@x varchar(2000)='<?xml version="1.0" encoding="windows-1251" ?>
	<��������>
					   	<�������� ��������_��������="����" �������= "7" />
					    <�������� ��������_��������="����_1" �������= "10" />
					    <�������� ��������_��������="����_2" �������= "10" />
	</��������>';
	   exec sp_xml_preparedocument @h output, @x; --���������� ���������

insert into �������� select[��������_��������], [�������] from openxml(@h, '/��������/��������', 0)
    with([��������_��������] varchar(50), [�������] char(10));
	select * from ��������
delete from �������� where ��������.��������_��������='����' or ��������.�������=7

--ex4--

insert ���������( ��������_�����, ���������_���������, ����������_����, ������� ) values
 ('�������_1', 22221111, '���� �������', '+375295635869', 
'<STUDENT>
	<PASSPORT SERIES="��" NUMBER="1111111" DATE="01.01.2016" />
	<PHONE>442184582</PHONE>
	<ADRESS>
		<COUNTRY>��������</COUNTRY>
		<CITY>�����</CITY>
		<STREET>���������</STREET>
		<HOUSE>38</HOUSE>
		<APPARTEMENT>13</APPARTEMENT>
	</ADRESS>
</STUDENT>')


update ��������� set ������� = 
'<STUDENT>
	<PASSPORT SERIES="��" NUMBER="1111111" DATE="01.01.2016" />
	<PHONE>1111111</PHONE>
	<ADRESS>
		<COUNTRY>��������_1</COUNTRY>
		<CITY>���������</CITY>
		<STREET>���������</STREET>
		<HOUSE>38</HOUSE>
		<APPARTEMENT>6412</APPARTEMENT>
	</ADRESS>
</STUDENT>'
where �������.value('(/STUDENT/ADRESS/APPARTEMENT)[1]', 'varchar(10)') = cast(13 as varchar(10))


select  NAME [���],
		INFO.value('(/STUDENT/PASSPORT/@SERIES)[1]', 'varchar(10)') �����,
		INFO.value('(/STUDENT/PASSPORT/@NUMBER)[1]', 'varchar(10)') �����,
		INFO.query('/STUDENT/ADRESS') �����
from STUDENT
where NAME = '����� ����� ���������� '

delete from STUDENT where NAME = '����� ����� ����������'

select * from ��������