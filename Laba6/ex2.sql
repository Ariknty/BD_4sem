--ex1,ex2--
select ���������.��������_�����,
max(���������_������) [max],
count(*) [����� ���������],
AVG(���������_������) [avg],
sum(���������_������) [sum],
min(���������_������) [min]
from ������� inner join ���������
on �������.��������=���������.��������_�����
group by ���������.��������_�����

--ex3--

select �.��������_�����, 
       �.���������_������,
	   round(avg(cast(���������_������ AS float(4))), 2) as [������� ���������]
from ������� � inner join ��������� �
on �.��������=�.��������_�����
where �.���_�������='�����������������'
group by �.��������_�����, �.���������_������

--ex4--
select p1.���_�������, p1.������������_�_�������,
(select count(*) from ������� p2
where p1.���_�������=p2.���_������� and p1.������������_�_�������=p2.������������_�_�������) [����������]
from ������� p1
group by p1.���_�������, p1.������������_�_�������
having ���_�������='��������������' or ���_�������='�����������������'

--ex5--

SELECT ���_�������, ��������, 
    SUM(���������_������) AS �����_��������� 
	FROM ������� 
	where ���_������� = '��������������'
	GROUP BY ROLLUP (���_�������, ��������);


--ex6--
select ���������.��������_�����,
max(���������_������) [max],
count(*) [����� ���������],
AVG(���������_������) [avg],
sum(���������_������) [sum],
min(���������_������) [min]
from ������� inner join ���������
on �������.��������=���������.��������_�����
group by cube (���������.��������_�����)


--ex6--

SELECT ���_�������, ��������, 
    SUM(���������_������) AS �����_��������� 
	FROM ������� 
	where ���_������� = '��������������'
	GROUP BY ���_�������, ��������
	UNION
SELECT ���_�������, ��������, 
    SUM(���������_������) AS �����_��������� 
	FROM ������� 
	where ���_������� = '�����������������'
	GROUP BY ���_�������, ��������



select ��������_�����, ���������_������, [������� ���������]
from (
       select �.��������_�����, 
       �.���������_������,
	   round(avg(cast(���������_������ AS float(4))), 2) as [������� ���������]
from ������� � inner join ��������� �
on �.��������=�.��������_�����
where �.���_�������='�����������������'
group by �.��������_�����, �.���������_������
 INTERSECT
  select �.��������_�����, 
       �.���������_������,
	   round(avg(cast(���������_������ AS float(4))), 2) as [������� ���������]
from ������� � inner join ��������� �
on �.��������=�.��������_�����
where �.���_�������='��������������'
group by �.��������_�����, �.���������_������ ) AS intersection_result;


select ��������_�����, ���������_������, [������� ���������]
from (
       select �.��������_�����, 
       �.���������_������,
	   round(avg(cast(���������_������ AS float(4))), 2) as [������� ���������]
from ������� � inner join ��������� �
on �.��������=�.��������_�����
where �.���_�������='�����������������'
group by �.��������_�����, �.���������_������
  EXCEPT
  select �.��������_�����, 
       �.���������_������,
	   round(avg(cast(���������_������ AS float(4))), 2) as [������� ���������]
from ������� � inner join ��������� �
on �.��������=�.��������_�����
where �.���_�������='��������������'
group by �.��������_�����, �.���������_������ ) AS intersection_result;