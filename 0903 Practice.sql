
    
select grade, count(*) �ο��� from users group by grade;
 
--����1, �׷캰 �ο����� ����ϵ� �г��� ������������ ����
select grade, count(*) �ο��� from users group by grade order by group asc;

--����2, �׷캰 �ְ����� �������� ����Ͻÿ�.
select grade, max(point) �ְ���, min(point) ������  from users group by grade;

--����3, �׷캰 �ְ����� ȹ���� ����� �̸���?
select grade, max(point) �ְ���,name from users group by grade;
--: ������ ��. ������ name�� �׷�ȭ ���� �ʾұ� ����

--Ȯ�� ����
--1. 3�г�� 4�г� ���� �׷��� �ο����� ����Ͻÿ�.
select grade, count(*) from users where grade=3 or grade=4 group by grade;
--2. 1�г�� 2�г��� �ְ����� �������� ���� ���̸� ����Ͻÿ�.
select max(point)-min(point) from users where grade=1 or grade=2 group by grade;
--3. �ֹι�ȣ 2 �ڸ��� �¾ �⵵�̴�. ���� �⵵�� �¾ ����� ī���� �Ͻÿ�.
--�̶� �¾ �⵵�� �ο����� ����Ѵ�. 
-- **jumin�̶�� �÷����� �׷��� ������ ����
select substr(jumin,1,2)�¾�⵵, count(*)�ο��� from users group by substr(jumin,1,2);

--+��������+ 
--�׷��� ���� �� �׷캰 ������ ������ �� �ִ�.
--���� ���, �׷��� �ο��� 3�� �̻��� �׷��� �ο����� ����Ͻÿ�.
--�� ���û����� �׷캰�� �ο��� ī�����ϰ� �׷��߿� �ο����� 3�� �̻��� �׷츸 �����ϴ� �ǹ��̴�.
--�׷쿡 ������ �����ϴ� ����� ã�ƺ�����.
--���� ������ ���������� �ϼ��ϼ���.
--�׷��� �ο��� 3�� �̻��� �׷��� �ο����� ����ϼ���.

select grade, count(*)�ο��� from users group by grade having count(*)>=3;
--: ���� 3�� �̻��� �׷��� ����ؾ��ϴϱ� group by���� 3�� �̻��� �׷��� �����ؾ���
--: �� �� 3�� �̻��� �׷��� �ο����� ���
-- * having�� group by�� ���� �����̴�. having���� �ܵ����� �� �� ����. *

--*hard* ��ü ��պ��� ū ��հ��� ���� �׷��� �г�� ��հ��� ����Ͻÿ�.
select grade, avg(point) from users group by grade 
having avg(point)>=(select avg(point)from users);
--���������� ������� ��ü ���. �� ��������� �׷��� ������ �ϼ�
--avg(point)>=�������� �����(��ü ���)

select m.name, m.addr from (select * from users) m;
--: m�̶�� �̸����� ������ ������ ���̺��� ���� �� (���� ���̺��� ��ȸ�ؼ� ���� �ӽ� ���̺�)
--: from���� m�̶�� ó�� ���� ���ڰ� �ֱ� ������ 
--  m�� ���� ������ ���� �ӽ� ���̺��� �̸��� ������ ���̶�� ������ �� ����

-- Bonus Quiz ���� ���� ������ ȹ���� ����� �̸��� ������?
select name, point from users where point = (select max(point) from users);
: ���� ���� ������ ���� ���� ������ ���