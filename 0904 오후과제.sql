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
--10. 자동차 가격이 1000만원 이상인 자동차의 자동차 번호를 출력하시오.
--11. 배정된 자동차 중에 회사에서 구매한 자동차가 아닌 자동차 번호를 출력하시오.
--12. 모든 사람의 정보를 출력하시오. 이름, 배정받은 자동차번호, 자동차이름