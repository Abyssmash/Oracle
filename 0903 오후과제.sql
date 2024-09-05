create table muser(
id int,
reg_num varchar2(8) not null,
name varchar2(10 char),
grade int,
salary int,
time int);

create sequence muser_no
increment by 1
start with 10
;

insert into muser values(muser_no.nextval,'870205-1','�̽���',1,10000,34);
insert into muser values(muser_no.nextval,'880405-1','������',2,20000,31);
insert into muser values(muser_no.nextval,'770715-2','���̼�',4,40000,32);
insert into muser values(muser_no.nextval,'010205-3','������',1,10000,30);
insert into muser values(muser_no.nextval,'810205-2','������',2,20000,34);
insert into muser values(muser_no.nextval,'820219-2','���¿�',3,30000,35);
insert into muser values(muser_no.nextval,'020205-3','�����',1,10000,30);
insert into muser values(muser_no.nextval,'970214-2','������',2,20000,31);
insert into muser values(muser_no.nextval,'040205-4','������',4,40000,31);
insert into muser values(muser_no.nextval,'770225-1','���翵',5,50000,30);
insert into muser values(muser_no.nextval,'770905-2','�̽ż�',4,40000,34);
insert into muser values(muser_no.nextval,'050208-3','�̹߲�',2,20000,30);
insert into muser values(muser_no.nextval,'051205-4','�̿���',1,10000,34);
insert into muser values(muser_no.nextval,'891215-1','���¾�',3,30000,30);
insert into muser values(muser_no.nextval,'670805-1','������',2,20000,34);
insert into muser values(muser_no.nextval,'840207-1','���̷�',1,10000,35);
insert into muser values(muser_no.nextval,'770405-1','��õ��',1,10000,31);

--1 grade�� 3�� ����� ��� ����ΰ���?
select count(*) from muser where grade=3;

select count(*) --���ϴ� ���� �ο���. �÷����� �ذ� �Ұ� 
from muser
where grade=3; --grade�� 3�� ����� Ʃ���� ���� ����
--group by
--order by

--2 grade�� 1,2,4�� ������� salary�� ����� ���Ͻÿ�.
select avg(salary) from muser where grade=1 or grade=2 or grade=4;

select avg(salary) --�÷����� �Լ��� ����ؾ��Ѵ�.
from muser
where grade in (1,2,4); --in �����ڴ� or�� �ǹ��̴�.
--where grade=1 or grade=2 or grade=4;
--group by: �׷캰 ������ ��� (���� X)

--3 salary�� 20000 �̸��� ����� �� ����Դϱ�?
select count(*) from muser where salary<20000;

select count(*)
from muser
where salary < 20000;
--group by
--order by

--4 salary�� 30000 �̻��� ����� salary ����� ���Ͻÿ�.
select avg(salary) from muser where salary>30000;

select
from
where
group by
order by

--5 77��� �߿�  salary�� ���� ���� ����� �̸��� ���̿� salary�� ����Ͻÿ�.
select name, sysdate-reg_num, (min)salary from muser where (reg_num,1,2)='77';

select -- �̸� ���� salary
from muser
where -- 77��� �߿�
--group by
--order by
/* 77��� ���� �׽�Ʈ ���� */
select from muser substr(reg_num,1,2)='77'; --�߰� �ܰ�
-- �������� ���� -- 77��� �׽�Ʈ ��
-- 77��� �� ���� ���� salary
select min(salary) from muser substr(reg_num,1,2)='77';
-- ���� ���� salary�� �˸� ���� ���� salary�� �������� ����� Ʃ���� ������ �� �ִ�.
select * from muser substr(reg_num,1,2)='77' and salary=10000;
-- ���� ������ ���� ���������� �ʿ��ϴٰ� ����
-- salary�� ����� �ƴϱ⿡ ���� �������� �ƴ�
select name �̸�, reg_num ����, salary �޿�
from muser
where substr(reg_num,1,2)='77' and salary=(
    select min(salary)
    from muser
    where substr(reg_num,1,2)='77');
-- �������� ���� ���������� ���ϰ� �Է�
--���̸� ����Ѵ�. �׷��� �� ������ �ֹι�ȣ�� ���
--�÷����� �ذᰡ���Ѱ�? ����? �Լ�? �������� > ���İ� �Լ��� �ʿ�
select 1900+substr(reg_num,1,2) from muser;
select * from muser;
--�м� ����� 1900�� �����ϸ� 2000�� ���� ����ڴ� ���������Ͱ� ��
--���ǿ� ���� 1900 �Ǵ� 2000�� �÷��� ������Ѵ�.
--�˻���: ����Ŭ ���ǿ� ���� > decode
select substr(reg_num,8,1) from muser;
select substr(reg_num,8,1) a,
    decode(select substr(reg_num,8,1),'1',1900,'2',1900,2000) b
from muser;
select substr(reg_num,8,1) a,
    (decode(select substr(reg_num,8,1),'1',1900,'2',1900,2000) b
    +substr(reg_num,1,2))c
from muser;
--���� ������ ������ ���ϴ�.
select name �̸�,
    (extract (year from sysdate))-
    (decode(substr(reg_num,8,1),'1',1900,'2',1900,2000)
    +substr(reg_num,1,2)) ����,
    salary �޿�
from muser
where substr(reg_num,1,2)='77' and salary=(
    select min(salary)
    from muser
    where substr(reg_num,1,2)='77');
    -------5�� ���� ��

--6 ��� ����� �̸���, ����(���� �� ������� 0205)�� ����Ͻÿ�.
select name, substr(reg_num,3,4) ���� from muser;

--7 ������ ��� �޿��� ���Ͻÿ�.
select avg(salary)������ձ޿� from muser where reg_num=1 group by substr(reg_num,8,1);

select avg(salary)������ձ޿�
from muser
where substr(reg_num,8,1)in('1','3');
 -- ����? �÷����� �ȵȴ�. �����̳� �Լ��� ��������.. �Լ��� ����
--group by
--order by

--8 ��ü ��ձ޿����� ���� �޿��� �޴� ����� �̸���, �޿��� ����Ͻÿ�.
select name, salary from muser where salary>(select avg(salary) from muser);
--Sol
select name, salary
from muser
where -- ��ձ޿����� ���� �޿� �޴� ����� Ʃ�� ����
      -- �÷� ��ü�� �ذ�? ����? �Լ�? ��������?
      -- ��� �޿��� ��������� ������ �ϼ� -> ��������
--group by
--order by
select name, salary
from muser
where  salary>
    (select avg(salary) 
    from muser);

--9 ��ü ��ձ޿����� ���� �޿��� �޴� ����� �̸���, �޿�, ��ձ޿��� ����Ͻÿ�
select name �̸�, salary �޿�, (select avg(salary)from muser)��ձ޿� from muser 
where salary > (select avg(salary)from muser);
--: ��� �޿����� ���� �޿��� �޴� ������� ��� �޿��� ���� ����ؾ���
--Sol
select name, 
       salary ,
       (select avg(salary)  -- ��Į�� ���� ����, ���å�� Join
       from muser)          
from muser
where  salary>
    (select avg(salary) 
    from muser);
    -- ������ ������. �ֳ��ϸ� ������ select���� Ʃ����
    -- �ϳ��� �ϼ��� �������� ���� ������ �����Ѵ�.
    -- ������ ���������� ��� �����ϱ� �����̴�.
    
--10 �������� ��ձ޿����� ���� ���������� ��� ����Դϱ�
select count(*) ���������� from muser;

select count(*) ����������
from muser
where salary >
    (select avg(salary) 
    from muser
    where substr(reg_num,8,1)in('2','4'));

--11 grade�� ��� �޿��� ����ϼ���..
select grade, avg(salary) from muser group by grade;

--12 �׷캰 ��ձ޿��� ��ü ��պ��� ���� �׷��� ����Ͻÿ�.
select grade �׷�, avg(salary) �׷���� from muser group by grade having avg(salary)>=(select avg(salary) from muser);

select grade �׷� , avg(salary) �׷����
from muser
--where
group by grade having avg(salary) > (
                                    select avg(salary)
                                    from muser);
--order by

--13 �������� ���� ������ ����Ͻÿ�. (��� ���´� �̸�, ����(grade*salary*time)
select name �̸�, grade*salary*time, concat(concat(concat(grade,'*')salary)'*'time)���� from muser;


--14 �������� ������ ����Ͻÿ�. (��� ���� �̸�, ����(������ ���Ǵ� ���� ����Ѵ�)
select name, reg_num ���� from muser where substr(reg_num,8)=1;

--Sol
select name �̸�, decode(substr(reg_num,8,1),'1','��','3','��','��') ����
from muser;
--where
--group by
--order by
--����Ŭ�� ���ǿ� ���� ó���ϴ� ������ case when then else end
-- case when then else end�� ������ �м�
-- case
--      when ���� 1 then ���� 1�� ���� ��� ����
--      when ���� 2 then ���� 2�� ���� ��� ����
--      else ���� 1�� ���� 2 ��� �͵� ���� �ƴ� ���
-- end
select name �̸�,
       case 
            when substr(reg_num,8,1)in('1','3') then '��'
            else '��'
            end ����
from muser;     -- ����� ������ 18��

select distinct grade, salary from muser;
-- distinct�� �ߺ��� �÷��� �����ϰ� select ������ �ѹ��� ����� ����
-- �ߺ� ���� ������ select���� ������ ��ü ���� �ߺ��̴�.
-- #3�� �������� ���ɺ�(time�÷�) �޿��� ��. over �Լ� �̿�
select distinct
        time ����,
        sum(salary) over(partition by time) ����
from muser;

--15 time�� �ٹ��ð��� �ٹ��ð��� 31�̻��� ����� �̸��� ����Ͻÿ�. 
select name from muser where time>31;

--16 ¦���⵵�� �¾ ������� �̸��� ��� ����ϻ��.
select name from muser where MOD(reg_num,2)=0 ;

--17 �������� ��������� ����Ͻÿ�. (��� ���´� �̸��� �������(97��1��2��))
select name, substr(reg_num,1,2)||'��'||substr(reg_num,3,2)||'��'|| 
substr(reg_num,5,2)||'��' ������� from muser;

--18 ���������� ���Ƹ� �����ϱ� ���� ��å���� time�� 2�ð������ϱ�� �ߴ�. �̸� ó�� �Ͻÿ�.

--19 ���̺� �ο����� ����Դϱ�
select count(*) from muser group by reg_num ;

--20 2�г�׷�� 4�г� �׷��� ��� ����Դϱ�
select sum(count(*)) from muser where grade=2 or grade=4 group by grade;

--�߰�����

--#1) ��� ����� �¾ �� ���ñ��� �� ���� �������� ����Ͻÿ�
--(�������: �̸�, �ֹι�ȣ, ���ݱ�����ƿ¿���)
select name �̸�, reg_num �ֹι�ȣ , months_between(sysdate,to_date('reg_num')) ��ƿ¿��� from muser;

--#2) time�� ���̷� ��. 30~31���� ��ƿ� ������ ��, 32�� �̻��� ��ƿ� ������ �� ���ϱ�
select count(*) from muser;

--Sol
select
    (select trunc(sum(months_between(sysdate, substr(reg_num,1,6))
    from muser where time in (30,31)) as �������,
    (select trunc(sum(months_between(sysdate, substr(reg_num,1,6))
    from muser where time >= 32) as ����
from dual;

--#3) ���ɺ� �޿��� ��, over()�Լ� �̿�
select time ����, sum(salary)over(partition by time) �޿� from muser group by time;
--: �׷� �� �� = ����(time)�� �޿�(salary)�� ��

--#4) ���ɺ� �ο���, over()�Լ� �̿�
select time ����, sum(time)over(partition by id) �ο��� from muser group by time;
--: �׷� �� �� = ����(time)�� �ο� �� 

--#5) ��޺� �޿��� �ְ�޿�, over()�Լ� �̿�
select grade ���, max(salary)over(partition by grade) �ְ�޿� from muser group by grade;
--: �׷� �� �ְ� = ��޺� �� �ְ� �޿�

--#6) ���۰˻��Ͽ� ����Ŭ �Լ� ����

<Oracle���� ���� ���̴� �Լ�>

1. ���� �Լ�

max(column)	�ִ밪�� ���ϴ� �Լ�
min(column)	�ּҰ��� ���ϴ� �Լ�
avg(column)	��հ��� ���ϴ� �Լ�
sum(column)	�հ踦 ���ϴ� �Լ�
mod(a, b)	a�� b�� ���� ���������� ���ϴ� �Լ�
count(*)	�� ���ڵ� ���� ���� �Լ�, null���� ����
count(�÷���)	�÷����� �������� �� ���ڵ� ���� ���� �Լ�, null���� ����

2. ���ڿ� �Լ�

lower('Hello World') 	hello world, �ش� �÷��� ���� �ҹ��ڷ� ��ȯ�ϴ� �Լ�
upper('Hello World') 	HELLO WORLD, �ش� �÷��� ���� �빮�ڷ� ��ȯ�ϴ� �Լ�
inicap('go go go!')	            Go Go Go!, ù���ڿ� �������� ù���ڴ� �빮�ڷ� ��ȯ�ϴ� �Լ�
concat('Helllo', 'World')	Hello World, �ΰ��� ���ڿ��� �����ϴ� �Լ�
substr('HelloWorld', 6)	World, ���ڿ��� 6��°�ڸ����� ��ü�� ����
substr('HelloWorld', 1, 5)	Hello, ���ڿ��� 1��°�ڸ����� 5�ڱ��� �����ϴ� �Լ�
length('oracle')	            6, ���ڿ��� �� ���̸� ���� �Լ�
instr('HelloWorld', 'W')	6, ���ڿ����� Ư�������� ��ġ�� ���� �Լ�
                                    ���� Ư�����ڰ� ���ڿ��� ���ٸ� 0 ��ȯ
lpad('SQLPLUS', 10, '*') 	***SQLPLUS,  �ش���̿� ������ �κ��� ���ʺ��� Ư�����ڷ� ä��� �Լ�
rpad('SQLPLUS', 10, '*')	SQLPLUS***,  �ش���̿� ������ �κ��� �����ʺ��� Ư�����ڷ� ä��� �Լ�
trim(' SQLPLUS')	            SQLPLUS, ������ �����ϴ� �Լ�
ltrim('*SQLPLUS', '*')	SQLPLUS, �������� ���ڿ����� �ش� ���ڸ� �����ϴ� �Լ�
rtrim('SQLPLUS*', '*') 	SQLPLUS, �������� ���ڿ����� �ش� ���ڸ� �����ϴ� �Լ�
replace('SEVLTL', 'L', 'EN')	SEVENTEN, ���ڿ����� �ش� ���ڸ� �ٸ� ���ڷ� �ٲپ��ִ� �Լ�
nvl(expr1, expr2)	            expr1�� null�̸� expr2 ������ ��ȯ�ϴ� �Լ�
nvl2(expr1, expr2, expr3)	expr1�� null1�� ���� null�� �ƴϸ� expr2, null�̸� expr3�� ��ȯ�ϴ� �Լ�
nullif(expr1, expr2)   	expr1�� expr2�� ���Ͽ� ������ null, �ٸ��� expr1�� ��ȯ�ϴ� �Լ�
coalesce(expr1, expr2, ... exprn)	expr1~exprn ��Ͽ��� ù��°�� null�� �ƴ� expr�� ��ȯ
||	                        ���տ�����
                                    ex) select uname || '�� ����� ' || aver || '�Դϴ�' from sungjuk;

3. ���� �Լ�

abs(-7)	            7, ���밪�� ����ϴ� �Լ�
mod(1500, 200)	100, 1500 / 200 �� �������� ��ȯ�ϴ� �Լ�
ceil(1.123) ; 2	�Ҽ��� ù°�ڸ����� �ش� ���� �ø� ó���� ������ ��ȯ�ϰ� �ش� �����ٴ� ũ���� ���� �����ϴ� �ּҰ��� ���ϴ� �Լ�
ceil(-1.623) ; -1     //
floor(1.123)	�Ҽ��� ù°�ڸ����� �ش� ���� ���� ó���� ������ ��ȯ�ϰ� �ش� �����ٴ� ������ ���� �����ϴ� �ִ밪�� ���ϴ� �Լ�
floor(-1.123)         //
round(n, m)	�ش� ���� n���� m�ڸ����� �ݿø��ϴ� �Լ�
trunc(n. m)	�ش� ���� n���� m�ڸ����� �����ϴ� �Լ�
to_number	���ڿ��� ���������� �ٲ��ش�
  select to_number('123')+1 from dual;         -- 124
  select '100'+1 from dual;                        -- 101, ���������� to_number()�� ȣ���

4. ��¥ �Լ�

 sysdate	                        ���� ��¥, �ð� ex) select sysdate from dual;
extract(year from sysdate)	sysdata���� ����� �����ϱ�(year, month, day)
months_between(sysdate, to_date('2014-12-11'))	ù��° ��¥���� �ι�° ��¥ ���� ���� ���� ��ȯ�ϴ� �Լ�
to_date()	                        ���ڿ��� ��¥������ ��ȯ
add_months(sysdate, 5)	�ش� ��¥���� ���� ���� ���� ��¥�� ��ȯ�ϴ� �Լ�
next_day(sysdate, '�ݿ���')	�ش� ��¥���� ���ʷ� �����ϴ� �ش� ������ ��¥�� ��ȯ�ϴ� �Լ�
last_day(sysdate)	            �ش� ��¥�� ���ԵǾ� �ִ� ���� ������ ��¥�� ��ȯ�ϴ� �Լ�

5. ����ȯ �Լ�

TO_CHAR(���� ��¥, '���ϴ� ���') - ���ڿ� ��¥�� ���ڷ� ��ȯ�� �ִ� �ΰ��� ���
TO_NUMBER('1')
TO_DATE('����','��¥����')


�� OVER()�Լ���?

OVER�Լ��� ORDER BY, GROUP BY ���������� �����ϱ� ���� ���� �Լ���� �� �� �ֽ��ϴ�.

�� OVER() �Լ�


COUNT(*)OVER() : ��ü�� ī��Ʈ
COUNT(*)OVER(PARTITION BY �÷�) : �׷������ ������ ī��Ʈ


MAX(�÷�)OVER() : ��ü�� �߿� �ְ�
MAX(�÷�)OVER(PARTITION BY �÷�) : �׷쳻 �ְ�


MIN(�÷�)OVER() : ��ü�� �߿� �ּҰ�
MIN(�÷�)OVER(PARTITION BY �÷�) : �׷쳻 �ּҰ�


SUM(�÷�)OVER() : ��ü�� ��
SUM(�÷�)OVER(PARTITION BY �÷�) : �׷쳻 ��


AVG(�÷�)OVER() : ��ü�� ���
AVG(�÷�)OVER(PARTITION BY �÷�) : �׷쳻 ���


STDDEV(�÷�)OVER() : ��ü�� ǥ������
STDDEV(�÷�)OVER(PARTITION BY �÷�) : �׷쳻 ǥ������


RATIO_TO_REPORT(�÷�)OVER() : �����ప/SUM(��ü�ప) �ۼ��������� ��Ÿ����� 100���ϸ� �˴ϴ�.
RATIO_TO_REPORT(�÷�)OVER(PARTITION BY �÷�) : �����ప / SUM(�׷��ప) �ۼ��������� ��Ÿ����� 100���ϸ� �˴ϴ�.

