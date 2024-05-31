--ex1--
select TEACHER.TEACHER_NAME [�������������] from TEACHER where TEACHER.PULPIT = '��'
order by TEACHER_NAME for xml path ('�������������'),
root ('������_��������������'), elements;
--ex2--
select tpe.AUDITORIUM_TYPENAME, a.AUDITORIUM_TYPE, a.AUDITORIUM_CAPACITY 
		from AUDITORIUM a inner join AUDITORIUM_TYPE tpe on a.AUDITORIUM_TYPE = tpe.AUDITORIUM_TYPE 
		where tpe.AUDITORIUM_TYPENAME = '����������'
		order by tpe.AUDITORIUM_TYPENAME for xml auto, root('������_���������'),elements;
--ex3--
declare @h int = 0,
	@x varchar(2000)='<?xml version="1.0" encoding="windows-1251" ?>
	<����������>
			<���������� ���="����" ��������="������������ ��������� � �������" �������="����" />
			<���������� ���="���" ��������="������ ������ ����������" �������="����" />
			<���������� ���="���" ��������="����������� ���������� ���������������� � internet" �������="����" />
	</����������>';
	   exec sp_xml_preparedocument @h output, @x; 

insert into subject select[���], [��������], [�������] from openxml(@h, '/����������/����������', 0)
    with([���] char(10), [��������] varchar(100), [�������] char(20));
	select * from subject
delete from subject where subject.subject='����' or subject.subject='���' or subject.subject='���'


--ex4--
insert STUDENT (IDGROUP, NAME, BDAY, INFO) values
(10, '����� ����� ����������', '2004-04-12', 
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


update STUDENT set INFO = 
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
where INFO.value('(/STUDENT/ADRESS/APPARTEMENT)[1]', 'varchar(10)') = cast(13 as varchar(10))


select  NAME [���],
		INFO.value('(/STUDENT/PASSPORT/@SERIES)[1]', 'varchar(10)') �����,
		INFO.value('(/STUDENT/PASSPORT/@NUMBER)[1]', 'varchar(10)') �����,
		INFO.query('/STUDENT/ADRESS') �����
from STUDENT
where NAME = '����� ����� ���������� '

delete from STUDENT where NAME = '����� ����� ����������'

--ex5--

drop xml schema collection Student

create xml schema collection Student as 
N'<?xml version="1.0" encoding="utf-16" ?>
<xs:schema attributeFormDefault="unqualified" elementFormDefault="qualified" xmlns:xs="http://www.w3.org/2001/XMLSchema">
	<xs:element name="STUDENT">  
		<xs:complexType>
			<xs:sequence>
				<xs:element name="PASSPORT" maxOccurs="1" minOccurs="1">
					<xs:complexType>
						<xs:attribute name="SERIES" type="xs:string" use="required" />
						<xs:attribute name="NUMBER" type="xs:unsignedInt" use="required"/>
						<xs:attribute name="DATE"  use="required" >  
							<xs:simpleType> 
								<xs:restriction base ="xs:string">
									<xs:pattern value="[0-9]{2}.[0-9]{2}.[0-9]{4}"/>
								</xs:restriction>
							</xs:simpleType>
						</xs:attribute>
					</xs:complexType> 
				</xs:element>
				<xs:element maxOccurs="3" name="PHONE" type="xs:unsignedInt"/>
				<xs:element name="ADRESS">
					<xs:complexType>
						<xs:sequence>
							<xs:element name="COUNTRY" type="xs:string" />
							<xs:element name="CITY" type="xs:string" />
							<xs:element name="STREET" type="xs:string" />
							<xs:element name="HOUSE" type="xs:string" />
							<xs:element name="APPARTEMENT" type="xs:string" />
						</xs:sequence>
					</xs:complexType>
				</xs:element>
			</xs:sequence>
		</xs:complexType>
	</xs:element>
</xs:schema>'


alter table STUDENT alter column INFO xml(Student)

insert STUDENT(IDGROUP, NAME, BDAY, INFO) values
(5, '���������� ���', '2003-03-19', 
'<STUDENT>
	<PASSPORT SERIES="MB" NUMBER="2841943" DATE="11.07.2017" />
	<PHONE>293341834</PHONE>
	<ADRESS>
		<COUNTRY>��������</COUNTRY>
		<CITY>�����</CITY>
		<STREET>��������</STREET>
		<HOUSE>76</HOUSE>
		<APPARTEMENT>142</APPARTEMENT>
	</ADRESS>
</STUDENT>')



insert STUDENT(IDGROUP, NAME, BDAY, INFO) values
(5, '������������ ��� 1 (DATE)', '2003-03-19', 
'<STUDENT>
	<PASSPORT SERIES="MB" NUMBER="2841943" DATE="2005-12-04" />
	<PHONE>293341834</PHONE>
	<ADRESS>
		<COUNTRY>��������</COUNTRY>
		<CITY>�����</CITY>
		<STREET>��������</STREET>
		<HOUSE>76</HOUSE>
		<APPARTEMENT>142</APPARTEMENT>
	</ADRESS>
</STUDENT>')


