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

insert into muser values(muser_no.nextval,'870205-1','이승진',1,10000,34);
insert into muser values(muser_no.nextval,'880405-1','박이진',2,20000,31);
insert into muser values(muser_no.nextval,'770715-2','최이수',4,40000,32);
insert into muser values(muser_no.nextval,'010205-3','류진아',1,10000,30);
insert into muser values(muser_no.nextval,'810205-2','오현식',2,20000,34);
insert into muser values(muser_no.nextval,'820219-2','정승우',3,30000,35);
insert into muser values(muser_no.nextval,'020205-3','이재수',1,10000,30);
insert into muser values(muser_no.nextval,'970214-2','박지영',2,20000,31);
insert into muser values(muser_no.nextval,'040205-4','정은아',4,40000,31);
insert into muser values(muser_no.nextval,'770225-1','정재영',5,50000,30);
insert into muser values(muser_no.nextval,'770905-2','이신수',4,40000,34);
insert into muser values(muser_no.nextval,'050208-3','이발끈',2,20000,30);
insert into muser values(muser_no.nextval,'051205-4','이욱이',1,10000,34);
insert into muser values(muser_no.nextval,'891215-1','지승아',3,30000,30);
insert into muser values(muser_no.nextval,'670805-1','현진수',2,20000,34);
insert into muser values(muser_no.nextval,'840207-1','최이런',1,10000,35);
insert into muser values(muser_no.nextval,'770405-1','이천안',1,10000,31);

--1 grade가 3인 사람은 모두 몇명인가요?
select count(*) from muser where grade=3;

select count(*) --원하는 값은 인원수. 컬럼으로 해결 불가 
from muser
where grade=3; --grade가 3인 사람은 튜플의 선정 조건
--group by
--order by

--2 grade가 1,2,4인 사람들의 salary의 평균을 구하시오.
select avg(salary) from muser where grade=1 or grade=2 or grade=4;

select avg(salary) --컬럼값에 함수를 사용해야한다.
from muser
where grade in (1,2,4); --in 연산자는 or의 의미이다.
--where grade=1 or grade=2 or grade=4;
--group by: 그룹별 집계일 경우 (개인 X)

--3 salary가 20000 미만인 사람은 총 몇명입니까?
select count(*) from muser where salary<20000;

select count(*)
from muser
where salary < 20000;
--group by
--order by

--4 salary가 30000 이상인 사람의 salary 평균을 구하시오.
select avg(salary) from muser where salary>30000;

select
from
where
group by
order by

--5 77년생 중에  salary가 가장 적은 사람의 이름과 나이와 salary를 출력하시오.
select name, sysdate-reg_num, (min)salary from muser where (reg_num,1,2)='77';

select -- 이름 나이 salary
from muser
where -- 77년생 중에
--group by
--order by
/* 77년생 쿼리 테스트 시작 */
select from muser substr(reg_num,1,2)='77'; --중간 단계
-- 본쿼리에 적용 -- 77년생 테스트 끝
-- 77년생 중 가장 작은 salary
select min(salary) from muser substr(reg_num,1,2)='77';
-- 가장 작은 salary를 알면 가장 작은 salary를 조건으로 사람의 튜플을 선정할 수 있다.
select * from muser substr(reg_num,1,2)='77' and salary=10000;
-- 위의 쿼리로 보아 서브쿼리가 필요하다고 느낌
-- salary가 상수가 아니기에 좋은 쿼리문이 아님
select name 이름, reg_num 나이, salary 급여
from muser
where substr(reg_num,1,2)='77' and salary=(
    select min(salary)
    from muser
    where substr(reg_num,1,2)='77');
-- 가독성을 위해 서브쿼리는 탭하고 입력
--나이를 출력한다. 그런데 위 쿼리는 주민번호를 출력
--컬럼으로 해결가능한가? 수식? 함수? 서브쿼리 > 수식과 함수가 필요
select 1900+substr(reg_num,1,2) from muser;
select * from muser;
--분석 상수로 1900를 보정하면 2000년 이후 출생자는 오류데이터가 됨
--조건에 따라 1900 또는 2000을 플러스 해줘야한다.
--검색어: 오라클 조건에 따라 > decode
select substr(reg_num,8,1) from muser;
select substr(reg_num,8,1) a,
    decode(select substr(reg_num,8,1),'1',1900,'2',1900,2000) b
from muser;
select substr(reg_num,8,1) a,
    (decode(select substr(reg_num,8,1),'1',1900,'2',1900,2000) b
    +substr(reg_num,1,2))c
from muser;
--최종 쿼리에 대입해 봅니다.
select name 이름,
    (extract (year from sysdate))-
    (decode(substr(reg_num,8,1),'1',1900,'2',1900,2000)
    +substr(reg_num,1,2)) 나이,
    salary 급여
from muser
where substr(reg_num,1,2)='77' and salary=(
    select min(salary)
    from muser
    where substr(reg_num,1,2)='77');
    -------5번 문제 끝

--6 모든 사람의 이름과, 생일(월과 일 예를들어 0205)를 출력하시오.
select name, substr(reg_num,3,4) 생일 from muser;

--7 남자의 평균 급여를 구하시오.
select avg(salary)남자평균급여 from muser where reg_num=1 group by substr(reg_num,8,1);

select avg(salary)남자평균급여
from muser
where substr(reg_num,8,1)in('1','3');
 -- 남자? 컬럼으로 안된다. 수식이나 함수나 서브쿼리.. 함수와 수식
--group by
--order by

--8 전체 평균급여보다 높은 급여를 받는 사람의 이름과, 급여를 출력하시오.
select name, salary from muser where salary>(select avg(salary) from muser);
--Sol
select name, salary
from muser
where -- 평균급여보다 높은 급여 받는 사람의 튜플 선택
      -- 컬럼 자체로 해결? 수식? 함수? 서브쿼리?
      -- 평균 급여의 결과값으로 조건을 완성 -> 서브쿼리
--group by
--order by
select name, salary
from muser
where  salary>
    (select avg(salary) 
    from muser);

--9 전체 평균급여보다 높은 급여를 받는 사람의 이름과, 급여, 평균급여를 출력하시오
select name 이름, salary 급여, (select avg(salary)from muser)평균급여 from muser 
where salary > (select avg(salary)from muser);
--: 평균 급여보다 높은 급여를 받는 사람들의 평균 급여를 따로 계산해야함
--Sol
select name, 
       salary ,
       (select avg(salary)  -- 스칼라 서브 쿼리, 대안책은 Join
       from muser)          
from muser
where  salary>
    (select avg(salary) 
    from muser);
    -- 성능은 별로임. 왜냐하면 본쿼리 select에서 튜플을
    -- 하나씩 완성해 갈때마다 서브 쿼리를 실행한다.
    -- 동일한 서브쿼리를 계속 실행하기 때문이다.
    
--10 여직원의 평균급여보다 높은 남자직원은 모두 몇명입니까
select count(*) 남자직원수 from muser;

select count(*) 남자직원수
from muser
where salary >
    (select avg(salary) 
    from muser
    where substr(reg_num,8,1)in('2','4'));

--11 grade별 평균 급여를 출력하세요..
select grade, avg(salary) from muser group by grade;

--12 그룹별 평균급여가 전체 평균보다 높은 그룹을 출력하시오.
select grade 그룹, avg(salary) 그룹평균 from muser group by grade having avg(salary)>=(select avg(salary) from muser);

select grade 그룹 , avg(salary) 그룹평균
from muser
--where
group by grade having avg(salary) > (
                                    select avg(salary)
                                    from muser);
--order by

--13 직원들의 월급 명세서를 출력하시오. (출력 형태는 이름, 월급(grade*salary*time)
select name 이름, grade*salary*time, concat(concat(concat(grade,'*')salary)'*'time)월급 from muser;


--14 직원들의 성별을 출력하시오. (출력 형태 이름, 성별(성별은 남또는 여로 출력한다)
select name, reg_num 성별 from muser where substr(reg_num,8)=1;

--Sol
select name 이름, decode(substr(reg_num,8,1),'1','남','3','남','여') 성별
from muser;
--where
--group by
--order by
--오라클에 조건에 따라 처리하는 문법은 case when then else end
-- case when then else end의 구조를 분석
-- case
--      when 조건 1 then 조건 1이 참일 경우 실행
--      when 조건 2 then 조건 2가 참일 경우 실행
--      else 조건 1과 조건 2 어느 것도 참이 아닐 경우
-- end
select name 이름,
       case 
            when substr(reg_num,8,1)in('1','3') then '남'
            else '여'
            end 성별
from muser;     -- 연계된 문제는 18번

select distinct grade, salary from muser;
-- distinct는 중복된 컬럼을 제거하고 select 절에서 한번만 사용이 가능
-- 중복 제거 범위는 select에서 지정한 전체 행의 중복이다.
-- #3번 문제에서 연령별(time컬럼) 급여의 합. over 함수 이용
select distinct
        time 연령,
        sum(salary) over(partition by time) 총합
from muser;

--15 time은 근무시간이 근무시간이 31이상인 사람의 이름을 출력하시오. 
select name from muser where time>31;

--16 짝수년도에 태어난 사람들의 이름을 모두 출력하사오.
select name from muser where MOD(reg_num,2)=0 ;

--17 직원들의 생년월일을 출력하시오. (출력 형태는 이름과 생년월일(97년1월2일))
select name, substr(reg_num,1,2)||'년'||substr(reg_num,3,2)||'월'|| 
substr(reg_num,5,2)||'일' 생년월일 from muser;

--18 여직원들의 육아를 지원하기 위한 정책으로 time을 2시간가산하기로 했다. 이를 처리 하시오.

--19 나이별 인원수는 몇명입니까
select count(*) from muser group by reg_num ;

--20 2학년그룹과 4학년 그룹은 모두 몇명입니까
select sum(count(*)) from muser where grade=2 or grade=4 group by grade;

--추가문제

--#1) 모든 사람이 태어난 후 오늘까지 몇 달이 지났는지 출력하시오
--(출력형태: 이름, 주민번호, 지금까지살아온월수)
select name 이름, reg_num 주민번호 , months_between(sysdate,to_date('reg_num')) 살아온월수 from muser;

--#2) time을 나이로 봄. 30~31세의 살아온 월수의 합, 32세 이상의 살아온 월수의 합 구하기
select count(*) from muser;

--Sol
select
    (select trunc(sum(months_between(sysdate, substr(reg_num,1,6))
    from muser where time in (30,31)) as 삼공삼일,
    (select trunc(sum(months_between(sysdate, substr(reg_num,1,6))
    from muser where time >= 32) as 삼이
from dual;

--#3) 연령별 급여의 합, over()함수 이용
select time 연령, sum(salary)over(partition by time) 급여 from muser group by time;
--: 그룹 내 합 = 연령(time)별 급여(salary)의 합

--#4) 연령별 인원수, over()함수 이용
select time 연령, sum(time)over(partition by id) 인원수 from muser group by time;
--: 그룹 내 합 = 연령(time)별 인원 수 

--#5) 등급별 급여의 최고급여, over()함수 이용
select grade 등급, max(salary)over(partition by grade) 최고급여 from muser group by grade;
--: 그룹 내 최고값 = 등급별 내 최고 급여

--#6) 구글검색하여 오라클 함수 정리

<Oracle에서 자주 쓰이는 함수>

1. 집계 함수

max(column)	최대값을 구하는 함수
min(column)	최소값을 구하는 함수
avg(column)	평균값을 구하는 함수
sum(column)	합계를 구하는 함수
mod(a, b)	a를 b로 나눈 나머지값을 구하는 함수
count(*)	총 레코드 수를 세는 함수, null값도 포함
count(컬럼명)	컬럼명을 기준으로 총 레코드 수를 세는 함수, null값은 제외

2. 문자열 함수

lower('Hello World') 	hello world, 해당 컬럼의 값을 소문자로 변환하는 함수
upper('Hello World') 	HELLO WORLD, 해당 컬럼의 값을 대문자로 변환하는 함수
inicap('go go go!')	            Go Go Go!, 첫글자와 공백이후 첫글자는 대문자로 변환하는 함수
concat('Helllo', 'World')	Hello World, 두개의 문자열을 연결하는 함수
substr('HelloWorld', 6)	World, 문자열의 6번째자리부터 전체를 추출
substr('HelloWorld', 1, 5)	Hello, 문자열의 1번째자리부터 5자까지 추출하는 함수
length('oracle')	            6, 문자열의 총 길이를 세는 함수
instr('HelloWorld', 'W')	6, 문자열에서 특정문자의 위치를 세는 함수
                                    만약 특정문자가 문자열에 없다면 0 반환
lpad('SQLPLUS', 10, '*') 	***SQLPLUS,  해당길이에 부족한 부분은 왼쪽부터 특정문자로 채우는 함수
rpad('SQLPLUS', 10, '*')	SQLPLUS***,  해당길이에 부족한 부분은 오른쪽부터 특정문자로 채우는 함수
trim(' SQLPLUS')	            SQLPLUS, 공백을 제거하는 함수
ltrim('*SQLPLUS', '*')	SQLPLUS, 좌측부터 문자열에서 해당 문자를 제거하는 함수
rtrim('SQLPLUS*', '*') 	SQLPLUS, 우측부터 문자열에서 해당 문자를 제거하는 함수
replace('SEVLTL', 'L', 'EN')	SEVENTEN, 문자열에서 해당 문자를 다른 문자로 바꾸어주는 함수
nvl(expr1, expr2)	            expr1이 null이면 expr2 값으로 반환하는 함수
nvl2(expr1, expr2, expr3)	expr1과 null1을 비교해 null이 아니면 expr2, null이면 expr3을 반환하는 함수
nullif(expr1, expr2)   	expr1과 expr2를 비교하여 같으면 null, 다르면 expr1을 반환하는 함수
coalesce(expr1, expr2, ... exprn)	expr1~exprn 목록에서 첫번째로 null이 아닌 expr을 반환
||	                        결합연산자
                                    ex) select uname || '의 평균은 ' || aver || '입니다' from sungjuk;

3. 숫자 함수

abs(-7)	            7, 절대값을 계산하는 함수
mod(1500, 200)	100, 1500 / 200 의 나머지를 반환하는 함수
ceil(1.123) ; 2	소수점 첫째자리에서 해당 값을 올림 처리한 정수를 반환하고 해당 값보다는 크지만 가장 근접하는 최소값을 구하는 함수
ceil(-1.623) ; -1     //
floor(1.123)	소수점 첫째자리에서 해당 값을 내림 처리한 정수를 반환하고 해당 값보다는 작지만 가장 근접하는 최대값을 구하는 함수
floor(-1.123)         //
round(n, m)	해당 숫자 n에서 m자리까지 반올림하는 함수
trunc(n. m)	해당 숫자 n에서 m자리까지 버림하는 함수
to_number	문자열을 숫자형으로 바꿔준다
  select to_number('123')+1 from dual;         -- 124
  select '100'+1 from dual;                        -- 101, 내부적으로 to_number()가 호출됨

4. 날짜 함수

 sysdate	                        현재 날짜, 시간 ex) select sysdate from dual;
extract(year from sysdate)	sysdata에서 년월일 추출하기(year, month, day)
months_between(sysdate, to_date('2014-12-11'))	첫번째 날짜에서 두번째 날짜 사이 개월 수를 반환하는 함수
to_date()	                        문자열을 날짜형으로 변환
add_months(sysdate, 5)	해당 날짜에서 개월 수를 더한 날짜를 반환하는 함수
next_day(sysdate, '금요일')	해당 날짜에서 최초로 도래하는 해당 요일의 날짜를 반환하는 함수
last_day(sysdate)	            해당 날짜가 포함되어 있는 달의 마지막 날짜를 반환하는 함수

5. 형변환 함수

TO_CHAR(원래 날짜, '원하는 모양') - 숫자와 날짜를 문자로 변환해 주는 두가지 기능
TO_NUMBER('1')
TO_DATE('문자','날짜포맷')


★ OVER()함수란?

OVER함수는 ORDER BY, GROUP BY 서브쿼리를 개선하기 위해 나온 함수라고 할 수 있습니다.

★ OVER() 함수


COUNT(*)OVER() : 전체행 카운트
COUNT(*)OVER(PARTITION BY 컬럼) : 그룹단위로 나누어 카운트


MAX(컬럼)OVER() : 전체행 중에 최고값
MAX(컬럼)OVER(PARTITION BY 컬럼) : 그룹내 최고값


MIN(컬럼)OVER() : 전체행 중에 최소값
MIN(컬럼)OVER(PARTITION BY 컬럼) : 그룹내 최소값


SUM(컬럼)OVER() : 전체행 합
SUM(컬럼)OVER(PARTITION BY 컬럼) : 그룹내 합


AVG(컬럼)OVER() : 전체행 평균
AVG(컬럼)OVER(PARTITION BY 컬럼) : 그룹내 평균


STDDEV(컬럼)OVER() : 전체행 표준편차
STDDEV(컬럼)OVER(PARTITION BY 컬럼) : 그룹내 표준편차


RATIO_TO_REPORT(컬럼)OVER() : 현재행값/SUM(전체행값) 퍼센테이지로 나타낼경우 100곱하면 됩니다.
RATIO_TO_REPORT(컬럼)OVER(PARTITION BY 컬럼) : 현재행값 / SUM(그룹행값) 퍼센테이지로 나타낼경우 100곱하면 됩니다.

