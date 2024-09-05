create table hm(
no number (3) primary key,
name varchar2(10) not null,
point number(5) default 0, 
addr varchar2(20), 
indate timestamp default sysdate);
insert into hm values (1,'홍길동',45,'서울시',default);
insert into hm values (2,'일지매',50,'수원',default);
insert into hm values (3,'이지매',43,'서울',default);

select * from hm;
select no,name from hm;
select count(*) from hm;

select no,name from hm;

// 컬럼(행)의 이름 바꿔서 출력하기
select no,name 이름 
from hm
where point < 50;

// 모든 학생의 이름과 포인트를 출력합니다. 포인트는 현재 포인트에서 10점을 올려서 출력
select name, point+10 from hm;

// 모든 학생의 이름과 포인트를 출력 출력은 이름/현재포인트/가산포인트
// 이름은 학생의 이름 현재포인트는 저장된 포인트 가산포인트는 +10점을 올린다.
select name 이름, point 현재포인트, point+10 가산포인트 from hm;

// 홍길동이라는 사람의 데이터 삭제하기
delete from hm where name='ㅎㄱㄷ'; // 실행 방지를 위해 이름 바꿔놓음

// concat이라는 함수를 이용해 매개변수 두개의 값을 붙여서 이름이라는 행에 출력
select concat('이름','님') 이름 from dual;

// 20 포인트보다 큰 포인트를 가진 튜플을 오름차순으로 출력
select *
from hm
where point >20
order by point desc;

// 현재 오라클의 날짜
select sysdate from dual;

//Q1. 이름 뒤에 님을 붙혀서 출력하시오. 모든 사람의 이름과 포인트를 출력합니다.

select concat(name ,'님') name, point from hm;

//Q2. 모든 사람의 이름과 포인트와 등록일을 출력합니다.
// 이때 가입 순서에 따라 출력합니다. 가장 나중에 가입한 사람이 제일 먼저 출력 
// 가입 날짜는 indate

select * from hm where indate<=sysdate order by indate desc;

//Q3. 포인트가 50 이상인 사람의 이름과 정보를 출력합니다.
// 정보는 no, 이름, 포인트가 합쳐진 문자열이다.
// *tip: concat은 두개의 매개변수만 붙일 수 있기 때문에 두개를 먼저 붙이고
//       나중에 이어 붙이는 작업을 한다.

select name 이름, concat(concat(no,name),point)정보 from hm where point>=50;

//Q4. 기준 포인트는 60이다. 모든 회원이 기준 포인트를 맞추기 위해서 부족한 포인트를 출력
// 출력은 이름 현재포인트 부족한 포인트

select name, point 현재포인트, 60-point 부족한포인트 from hm;

commit;