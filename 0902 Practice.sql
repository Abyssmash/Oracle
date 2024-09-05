create table hm(
no number (3) primary key,
name varchar2(10) not null,
point number(5) default 0, 
addr varchar2(20), 
indate timestamp default sysdate);
insert into hm values (1,'ȫ�浿',45,'�����',default);
insert into hm values (2,'������',50,'����',default);
insert into hm values (3,'������',43,'����',default);

select * from hm;
select no,name from hm;
select count(*) from hm;

select no,name from hm;

// �÷�(��)�� �̸� �ٲ㼭 ����ϱ�
select no,name �̸� 
from hm
where point < 50;

// ��� �л��� �̸��� ����Ʈ�� ����մϴ�. ����Ʈ�� ���� ����Ʈ���� 10���� �÷��� ���
select name, point+10 from hm;

// ��� �л��� �̸��� ����Ʈ�� ��� ����� �̸�/��������Ʈ/��������Ʈ
// �̸��� �л��� �̸� ��������Ʈ�� ����� ����Ʈ ��������Ʈ�� +10���� �ø���.
select name �̸�, point ��������Ʈ, point+10 ��������Ʈ from hm;

// ȫ�浿�̶�� ����� ������ �����ϱ�
delete from hm where name='������'; // ���� ������ ���� �̸� �ٲ����

// concat�̶�� �Լ��� �̿��� �Ű����� �ΰ��� ���� �ٿ��� �̸��̶�� �࿡ ���
select concat('�̸�','��') �̸� from dual;

// 20 ����Ʈ���� ū ����Ʈ�� ���� Ʃ���� ������������ ���
select *
from hm
where point >20
order by point desc;

// ���� ����Ŭ�� ��¥
select sysdate from dual;

//Q1. �̸� �ڿ� ���� ������ ����Ͻÿ�. ��� ����� �̸��� ����Ʈ�� ����մϴ�.

select concat(name ,'��') name, point from hm;

//Q2. ��� ����� �̸��� ����Ʈ�� ������� ����մϴ�.
// �̶� ���� ������ ���� ����մϴ�. ���� ���߿� ������ ����� ���� ���� ��� 
// ���� ��¥�� indate

select * from hm where indate<=sysdate order by indate desc;

//Q3. ����Ʈ�� 50 �̻��� ����� �̸��� ������ ����մϴ�.
// ������ no, �̸�, ����Ʈ�� ������ ���ڿ��̴�.
// *tip: concat�� �ΰ��� �Ű������� ���� �� �ֱ� ������ �ΰ��� ���� ���̰�
//       ���߿� �̾� ���̴� �۾��� �Ѵ�.

select name �̸�, concat(concat(no,name),point)���� from hm where point>=50;

//Q4. ���� ����Ʈ�� 60�̴�. ��� ȸ���� ���� ����Ʈ�� ���߱� ���ؼ� ������ ����Ʈ�� ���
// ����� �̸� ��������Ʈ ������ ����Ʈ

select name, point ��������Ʈ, 60-point ����������Ʈ from hm;

commit;