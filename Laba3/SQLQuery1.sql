use master;
CREATE database �����_MyBase on primary
(name='Laba_mdf', filename='C:\�����\4�������\��\�����_MyBase_mdf.mdf',
size = 10240Kb,maxsize=UNLIMITED, filegrowth=1024Kb),
( name = N'UNIVER_ndf', filename = N'C:\�����\4�������\��\�����_MyBase_ndf.ndf', 
   size = 10240KB, maxsize=1Gb, filegrowth=25%),
filegroup FG1
( name = N'UNIVER_fg1_1', filename = N'C:\�����\4�������\��\�����_MyBase_fg1_1.ndf', 
   size = 10240Kb, maxsize=1Gb, filegrowth=25%),
( name = N'UNIVER_fg1_2', filename = N'C:\�����\4�������\��\�����_MyBase_fg1_2.ndf', 
   size = 10240Kb, maxsize=1Gb, filegrowth=25%)
log on
( name = N'UNIVER_log', filename=N'C:\�����\4�������\��\�����_MyBase_log.ldf',       
   size=10240Kb,  maxsize=2048Gb, filegrowth=10%);

use �����_MyBase;

CREATE table ��������
(
  ��������_�������� nvarchar(50) primary key,
  ������� int
) on FG1;

CREATE table ���������
(
  ��������_����� nvarchar(50) primary key,
  ���������_��������� int not null,
  ����������_���� nvarchar(50),
  ������� nvarchar(15),
) on FG1;

CREATE table ������� 
(
  id int primary key,
  ���_������� nvarchar(50),
  ���� date,
  �������� nvarchar(50) foreign key  references ���������(��������_�����),
  �������� nvarchar(50) foreign key  references ��������(��������_��������),
  ���������_������ money not null,
  ������������_�_������� time not null
) on FG1;

ALTER Table ��������� ADD ���_���������� nvarchar(50);
ALTER TABLE ��������� DROP COLUMN ���_����������;
			
ALTER Table ��������� ADD ��� nvarchar(1) default '�' check (��� in('�', '�'));
			
ALTER TABLE ��������� DROP CONSTRAINT DF_������_�������_���;
ALTER TABLE ��������� DROP COLUMN ���;


INSERT into �������� (��������_��������, �������)
       Values ('���', 5),
	          ('�������', 4);

INSERT into ��������� (��������_�����, ���������_���������, ����������_����, �������)
       Values ('��������', 11111111, '��� ���������', '+375445635869'),
	   ('�������', 22221111, '���� �������', '+375295635869'),
	   ('��������', 33331111, '���� ���������', '+375175635869'),
	   ('������', 44441111, '����� ����������', '+375295635844');

INSERT into ������� (id, ���_�������, ����, ��������, ��������, ���������_������, ������������_�_�������)
       Values (1, '�����������������', '2024-01-01', '��������', '���', 1500, '00:02:00'),
	   (2, '��������������', '2024-02-02', '��������', '���', 2500, '00:01:00'),
	   (3, '�����������������', '2024-03-03', '������', '�������', 3500, '00:03:00'),
	   (4, '���������������', '2024-04-04', '�������', '�������', 1500, '00:04:00');

SELECT * From �������;
SELECT ���_�������, ��������  From �������;
SELECT count(*) From �������; 
UPDATE ������� set ���������_������ = 5000 where ��������='���';
SELECT * From �������;





