drop table nusers;
drop table carinfo;

create table nusers(
id varchar2(8), 
name varchar2(10), 
addr varchar2(10));

create table carinfo(
c_num varchar2(4),   --�ڵ��� ��ȣ
c_name varchar2(10),  -- �ڵ��� ����
 id varchar2(8));
 
insert into nusers values ('1111','kim','����');
insert into nusers values ('2222','lee','����');
insert into nusers values ('3333','park','����');
insert into nusers values ('4444','choi','����');

insert into carinfo values ('1234','����','1111');
insert into carinfo values ('3344','����','1111');
insert into carinfo values ('5566','����','3333');
insert into carinfo values ('6677','����','3333');
insert into carinfo values ('7788','����','4444');
insert into carinfo values ('8888','����','5555');

--1. ȸ���� �̸��� �ּҸ� ����Ͻÿ�.
select name ȸ���̸�, addr �ּ� from nusers;

--2. ȸ���� �̸��� ������ �ڵ��� ��ȣ�� ����Ͻÿ�.
select n.name ȸ���̸�, c.c_num �ڵ�����ȣ from nusers n, carinfo c 
where n.id=c.id;

--3. �ڵ��� ��ȣ�� 7788�� �������� �̸��� �ּҸ� ����Ͻÿ�.
select n.name ȸ���̸�, n.addr �ּ� from nusers n, carinfo where c_num=7788;

--4. �ڵ����� �������� ���� ����� �̸��� �ּҸ� ����Ͻÿ�.
select n.name �̸�, n.addr �ּ� from nusers n 
left outer join carinfo c on n.id=c.id where c.id is null; 

--5. ȸ���� ����� �ڵ��� ���� ����Ͻÿ�.
select distinct n.name ȸ��, count(*) over(partition by c.id) �ڵ����� 
from nusers n, carinfo c 
where c.id=n.id;

--6. 2�� �̻��� ������ ȸ���� �̸��� ������ �ڵ��� ���� ����Ͻÿ�.
      
select distinct n.name ȸ��, count(*)over(partition by c.id) �ڵ�����
 from nusers n
 inner join carinfo c
where 2 = in(n.id,c.id);
        
--7. �ڵ����� ��ϵǾ� �ִµ� �����ڰ� ���� �ڵ��� ��ȣ�� ����Ͻÿ�.

select c.c_num �ڵ�����ȣ 
from carinfo c left outer join nusers n 
on c.id=n.id where n.id is null;

-- ���� ���ʹ� 3�� ���̺��� �����ϴ� �����Դϴ�.

-- companycar ȸ�翡�� ������ �ڵ����� �ǹ�, 
--carinfo�� �������� ������ �ڵ���
--���� ���̺��� �����Ͻÿ�.

create table companycar(     -- �ڵ��� ����
c_num varchar2(4),   -- ����ȣ
c_com varchar2(30), 
c_name varchar2(10),  -- ���̸�
c_price number);  -- �� ����

--���� Ʃ���� �����ϼ���
insert into companycar values ('1234','����','�ҳ�Ÿ',1000);
insert into companycar values ('3344','���','����',2000);
insert into companycar values ('7788','���','��2',800);
insert into companycar values ('9900','����','�׷���',2100);

--8. ���� �ڵ����� ����ȣ, ������, �ڵ�����, ������ ����Ͻÿ�.
select p.num ����ȣ, p.com ������, p.name �ڵ�����, p.price ���� from companycar p
inner join carinfo c on c.num=p.num;

--9. ȸ�翡�����Ŵ� �Ͽ����� �������� ���� �ڵ����� ����ȣ, ������, �ڵ��� �̸��� ���  

--���̺��� ���� ������ ���� ���ô�.
--companycar ���̺� ������ �ڵ��� ������ Ȯ��, �� �ڵ��� �����Ǿ�����
--Ȯ���ϱ� ���ؼ� carinfo���̺� Ȯ��..  ������ �ڵ����� �̳�����
--������ �ȵ� �ڵ����� �ƿ��� ����.. �̶� campanycar�� left
select c.c_num, c.c_com, c.c_name
from companycar c
left outer join carinfo cc
on c.c_num = cc.c_num
where cc.c_num is null;

--10. �ڵ��� ������ 1000���� �̻��� �ڵ����� �ڵ��� ��ȣ�� ����Ͻÿ�.
--�ڵ��� ������ 1000���� �̻��̶�� ������ companycar ���� �ذᰡ��
--���ϴ� �ڵ��� ��ȣ�� companycar���� �ذᰡ�� �� ���� �ʿ����
 select c_name
 from companycar
 where c_price >=1000;
 
--11. ������ �ڵ��� �߿� ȸ�翡�� ������ �ڵ����� �ƴ� �ڵ��� ��ȣ�� ����Ͻÿ�.
--���� ���̺��� carinfo   companycar
--outer join  >  carinfo ���̺��� left
select c.c_num
from carinfo c
left outer join companycar c1
on c.c_num = c1.c_num
where c1.c_com is null;

--12. ��� ����� ������ ����Ͻÿ�. �̸�, �������� �ڵ�����ȣ, �ڵ����̸�
--�������̺��� users, carinfo, companycar
--�����ؼ� ����� ���� ���̺���
--users.name  carinfo.c_num  companycar.c_name
--�� ���̺�3���� ����. �̶��� ������ ���ϰ� ������� 2���� �����ϰ�
--�� ����� �����̺�� ���� ���̺��� ���� .. ����
select n.name, NVL(c.c_num,'����'), NVL(p.c_name,'����')
from nusers n
left outer join carinfo c
on n.id=c.id
left outer join companycar p
on c.c_num= p.c_num;

-- view�� ���� �����ϴ� ���̺��� �ƴ϶�, ���� �����ϴ� ���̺��� ���Ͽ� ���� �������̺��̴�.
-- �̷��� view�� view�̸����� ��ȸ�� �����ϴ�.
-- �̷������δ� view�� ���ؼ� insert, delete, update�� ����������,
-- ���̺��� ���Ἲ �� �������ǿ� ���谡 ���� �ʾƾ��Ѵ�.
-- �̷�������, view�� ��ȸ�������� ���� ����Ѵ�.

