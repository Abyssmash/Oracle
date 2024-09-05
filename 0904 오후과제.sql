drop table nusers;
drop table carinfo;

create table nusers(
id varchar2(8), 
name varchar2(10), 
addr varchar2(10));

create table carinfo(
c_num varchar2(4),   --자동차 번호
c_name varchar2(10),  -- 자동차 종류
 id varchar2(8));
 
insert into nusers values ('1111','kim','수원');
insert into nusers values ('2222','lee','서울');
insert into nusers values ('3333','park','대전');
insert into nusers values ('4444','choi','대전');

insert into carinfo values ('1234','중형','1111');
insert into carinfo values ('3344','소형','1111');
insert into carinfo values ('5566','중형','3333');
insert into carinfo values ('6677','중형','3333');
insert into carinfo values ('7788','중형','4444');
insert into carinfo values ('8888','중형','5555');

--1. 회원의 이름과 주소를 출력하시오.
select name 회원이름, addr 주소 from nusers;

--2. 회원의 이름과 소유한 자동차 번호를 출력하시오.
select n.name 회원이름, c.c_num 자동차번호 from nusers n, carinfo c 
where n.id=c.id;

--3. 자동차 번호가 7788인 소유자의 이름과 주소를 출력하시오.
select n.name 회원이름, n.addr 주소 from nusers n, carinfo where c_num=7788;

--4. 자동차를 소유하지 않은 사람의 이름과 주소를 출력하시오.
select n.name 이름, n.addr 주소 from nusers n 
left outer join carinfo c on n.id=c.id where c.id is null; 

--5. 회원별 등록한 자동차 수를 출력하시오.
select distinct n.name 회원, count(*) over(partition by c.id) 자동차수 
from nusers n, carinfo c 
where c.id=n.id;

--6. 2대 이상을 소유한 회원의 이름과 소유한 자동차 수를 출력하시오.
      
select distinct n.name 회원, count(*)over(partition by c.id) 자동차수
 from nusers n
 inner join carinfo c
where 2 = in(n.id,c.id);
        
--7. 자동차는 등록되어 있는데 소유자가 없는 자동차 번호를 출력하시오.

select c.c_num 자동차번호 
from carinfo c left outer join nusers n 
on c.id=n.id where n.id is null;

-- 다음 부터는 3개 테이블을 조인하는 문제입니다.

-- companycar 회사에서 구매한 자동차를 의미, 
--carinfo는 직원에게 배정한 자동차
--다음 테이블을 생성하시오.

create table companycar(     -- 자동차 정보
c_num varchar2(4),   -- 차번호
c_com varchar2(30), 
c_name varchar2(10),  -- 차이름
c_price number);  -- 차 가격

--다음 튜플을 삽입하세요
insert into companycar values ('1234','현다','소나타',1000);
insert into companycar values ('3344','기와','축제',2000);
insert into companycar values ('7788','기와','레2',800);
insert into companycar values ('9900','현다','그랭저',2100);

--8. 배정 자동차의 차번호, 제조사, 자동차명, 가격을 출력하시오.
select p.num 차번호, p.com 제조사, p.name 자동차명, p.price 가격 from companycar p
inner join carinfo c on c.num=p.num;

--9. 회사에서구매는 하였지만 배정되지 않은 자동차의 차번호, 제조자, 자동차 이름을 출력  

--테이블을 보는 순서를 정해 봅시다.
--companycar 테이블에 보유한 자동차 정보를 확인, 이 자동차 배정되었는지
--확인하기 위해서 carinfo테이블 확인..  배정된 자동차는 이너조인
--배정이 안된 자동차는 아우터 조인.. 이때 campanycar를 left
select c.c_num, c.c_com, c.c_name
from companycar c
left outer join carinfo cc
on c.c_num = cc.c_num
where cc.c_num is null;

--10. 자동차 가격이 1000만원 이상인 자동차의 자동차 번호를 출력하시오.
--자동차 가격이 1000만원 이상이라는 조건은 companycar 에서 해결가능
--원하는 자동차 번호도 companycar에서 해결가능 즉 조인 필요없음
 select c_name
 from companycar
 where c_price >=1000;
 
--11. 배정된 자동차 중에 회사에서 구매한 자동차가 아닌 자동차 번호를 출력하시오.
--관련 테이블은 carinfo   companycar
--outer join  >  carinfo 테이블을 left
select c.c_num
from carinfo c
left outer join companycar c1
on c.c_num = c1.c_num
where c1.c_com is null;

--12. 모든 사람의 정보를 출력하시오. 이름, 배정받은 자동차번호, 자동차이름
--관련테이블은 users, carinfo, companycar
--조인해서 만들고 싶은 테이블은
--users.name  carinfo.c_num  companycar.c_name
--즉 테이블3개를 조인. 이때는 순서를 정하고 순서대로 2개씩 조인하고
--그 결과의 논리테이블과 다음 테이블을 조인 .. 진행
select n.name, NVL(c.c_num,'없음'), NVL(p.c_name,'없음')
from nusers n
left outer join carinfo c
on n.id=c.id
left outer join companycar p
on c.c_num= p.c_num;

-- view는 실제 존재하는 테이블이 아니라, 실제 존재하는 테이블을 통하여 만든 가상테이블이다.
-- 이러한 view는 view이름으로 조회가 가능하다.
-- 이론적으로는 view를 통해서 insert, delete, update가 가능하지만,
-- 테이블의 무결성 및 제약조건에 위배가 되지 않아야한다.
-- 이런점에서, view는 조회목적으로 많이 사용한다.

