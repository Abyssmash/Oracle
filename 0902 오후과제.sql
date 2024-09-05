create table users(
no int primary key,
name varchar2(10),
addr varchar2(10),
point number,
grade varchar2(1),
jumin varchar2(8));

insert into users values (1,'kimsu','suwon',99.12,1,'820405-1');
insert into users values (2,'leesu','suwon city',89.00,2,'970805-2');
insert into users values (3,'choihee','seoul',88.21,1,'910204-2');
insert into users values (4,'leesil','suwon',77.62,4,'850405-1');
insert into users values (5,'james','seoul',60.22,1,'871105-1');
insert into users values (6,'parksuji','suwon',90.12,3,'880405-2');
insert into users values (7,'kimrae','yougin',89.96,3,'820105-1');
insert into users values (8,'sangJin','youngin',99.31,3,'990420-2');
insert into users values (9,'Leechan','incheon',79.12,2,'970605-2');
insert into users values (10,'kimmi','incheon',79.92,1,'810505-1');
insert into users values (11,'ryusu','seoul',85.32,4,'861205-2');
insert into users values (12,'Gosu',null,82.13,4,'810715-1');

//1. ��� ������� �̸��� ������ ��������� �˻��Ͻÿ�.  
select name,point,jumin from users;

//2. 80�� �̻��� ����� �̸��� �ּ�, ������ �˻��Ͻÿ�.
select name, addr, point from users where point>80;
// : users��� �����̼ǿ��� ����Ʈ�� 80 �̻��ΰ� ���� �������� ����, �ּ�, ������ ���

//3. �̸��� kim���� ���۵Ǵ� ����� �̸��� �ּҿ� ������ �˻��Ͻÿ�.
select name, addr, point from users where name='kim+name';

//4. ���� �������� +10���� ������ ������ ����Ͻÿ�.
//   ���� �����Ϳ� �ݿ����� �ʽ��ϴ�.
select point+10 from users;

//5. 1�г��� ������ +1���� �÷��� ����ϼ���. (��, ���� �����Ϳ� �ݿ����� �ʽ��ϴ�.)
select point+1 from users where grade=1;
//: users��� �����̼ǿ��� �г��� 1�г��ΰ� ���̶�� ������ 1���� �߰��ؼ� ���

//6. B����� ȹ���� ����� �̸�, �ּ�, ������ ����ϼ��� (B��� 80�� �̻� 90�� �̸��Դϴ�)
select name, addr, point from users where point=80-90;
//: users��� �����̼ǿ��� ������ 80�� �̻� 90�� �̸��� ���� �������� �̸�, �ּ�, ������ ���

//7. ���� ��� �� NULL�� ���� �Է����� ���� ���Դϴ�.
//   �ּҸ� �Է����� ���� �л��� �̸���, �ּ�, �г�, ����, �ֹι�ȣ�� ����ϼ���
select name, addr, grade, point, jumin from users where addr=null;

//8. 4�г��� ������ 10%�� �ø� ������ ����ϼ���.
//   (��, ���������ʹ� �ݿ����� �ʴ´�)
select point+point/10 from users where grade=4;
select point*1.1 from users where grade=4;
//: users��� �����̼ǿ��� �г��� 4�г��� ���� �������� ������ 10% �����ؼ� ���

//9. ������ ���� �л����� ����ϼ���.  ��ȣ, �̸�, �ּ�, ����Ʈ
select no, name, addr, point from users order by point asc;
//: users��� �����̼ǿ��� ��ȣ, �̸�, �ּ�, ����Ʈ�� ������ ���� �л����� ��� (��������)

//10. �г��� ������������ �����Ͻÿ�, �� �г��� ���� �� ��� ����Ʈ�� ���� ����� ���� ��µ˴ϴ�.
//     ����� ��ȣ, �̸�, �г�, ����Ʈ 
select no, name, grade, point from users order by grade asc, point desc;
//: users��� �����̼ǿ��� 

//11. ������ �������� -10�� ������ ��� 80�� �̻��� ����� �̸��� ����, ������ ��� ������ ����ϼ���.?
select name, point ����, point-10 �����Ѱ������ from users where point-10>80;

//12. 2�г��� ��� �л��� ����Ͻÿ� . ��� �÷�����
//    �̸� �ּ� �г����� ����Ͻÿ�. ���⼭ �̸��� name�÷�, �ּҴ� addr�÷�, �г��� grade�÷��� �ǹ�
select name �̸�, addr �ּ�, grade �г� from users where grade=2;

//�߰�����  -- ����Ŭ �Լ��� �˻��� ������ ( ���ۿ� �˻� )
//13. �л��� �� ����Դϱ�? 

//14. 1�г��� �� ����Դϱ�?

//15. ��� �л��� �̸��� �г��� ����Ͻÿ�. �� �̸��� ��� �ҹ��ڷθ� ����Ͻÿ�. 

//16. 2�г� �л��� �̸��� �г��� ����Ͻÿ�. ������ ���ؼ� �ּҴ� �ձ��� 2���ڸ� ����Ͻÿ�.
//17. ��� �л��� ������ ���� �ڸ��� �����Ͻÿ�. - �ݿø� ���� (��, ���� �����Ϳ� �ݿ����� �ʽ��ϴ�.)
//18. ��� �л��� ������ �ݿø��Ͽ� ����Ͻÿ�. (��, ���� �����Ϳ� �ݿ����� �ʽ��ϴ�.)
//19. 2�г��� ��� ����Դϱ�?
//20. 1�г��� 80�� �̻��� ����Դϱ�?
//21. 3�г��� ����� �����Դϱ�?
//22. ��ü �л� �� �ְ����� �����Դϱ�?
//23. 2�г� �� ���� ���� ������ ȹ���� ������ �����Դϱ�?

//��Ǫ�� ����
//24. ������ ���ؼ� �ּҸ� ��� ������� �ʰ� ���� �� ���ڸ� ����ϰ� �ڿ� *�� �ϳ� ������.
//   (��, ���� �����Ϳ� �ݿ����� �ʽ��ϴ�.)
//   ��)suwon  >> su*
select name, addr, concat(addr(3),'*')�ּ� from users;

//25. �̸��� �� �տ� *�� �� �ڿ���*�� ������ ����Ѵ�. (��, ���� �����Ϳ� �ݿ����� �ʽ��ϴ�.)
select name, concat(concat('*',name),'*')�̸� from users;

//26. ��������� �״�� ������� ����
//    xx �� xx �� xx �� �������� ����Ѵ�. (��, ���� �����Ϳ� �ݿ����� �ʽ��ϴ�. ������ �����Ѵ�)
select jumin �������, jumin from users;

//27. �̸�, ����Ʈ, �г�, �������, ������ �߰��Ѵ�. ������ ������Ϸ� �Ǵ��ϸ� ������ ���ڰ�1�̸� ��
//    2�̸� ����� ǥ���Ѵ�. 
select name �̸�, point ����Ʈ, grade �г�, jumin �������,���� from users
where jumin1=�� jumin2=��;

//�߰� ����
//1. ��� ����� �̸��� �ֹι�ȣ�� ����ϰ� ���̸� ����Ͻÿ�.
select name �̸�, jumin �ֹι�ȣ, ���� from users where sysdate-jumin=����';


//2. ��� ����� ������ ����Ͻÿ�.
//   �� �̸��� ����ŷ�Ͻÿ�.
//   ����ŷ ����� ù���ڴ� �״�� �������� *, *�� �� ���� �̸��� ���̺��� �ϳ� ����.
//   ��) abcdef > a*****

//3. ��� ����� ������ ����Ͻÿ�.
//    1�г��� �̸��ڿ� *, 2�г��� �̸� �ڿ� %, 3�г��� �̸��ڿ� #, 4�г��� �̸��ڿ� !��
//   �߰��Ͽ� ����Ͻÿ�.
select name from users where grade=1=name+'*';

// ABCD��� ���ڿ��� �ҹ��ڷ� �ٲٱ�

select lower('ABCD') from dual;

//1. ����Ŭ���� �̹� ���� �����ϴ� �����Լ�
//   �Ű������� ���� �ҹ��ڷ� �ٲٴ� ���
//2. lower()�� �Լ��� call�ϴ� �۾�, �̶� �Ű������� ���ڿ� 'ABCD'����
//3. �Լ��� ����� ������. ������� abcd
   