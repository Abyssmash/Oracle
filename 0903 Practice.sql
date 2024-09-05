
    
select grade, count(*) 인원수 from users group by grade;
 
--응용1, 그룹별 인원수를 출력하되 학년을 오름차순으로 정렬
select grade, count(*) 인원수 from users group by grade order by group asc;

--응용2, 그룹별 최고점과 최저점을 출력하시오.
select grade, max(point) 최고점, min(point) 최저점  from users group by grade;

--응용3, 그룹별 최고점을 획득한 사람의 이름은?
select grade, max(point) 최고점,name from users group by grade;
--: 에러가 뜸. 이유는 name은 그룹화 되지 않았기 때문

--확인 문제
--1. 3학년과 4학년 각각 그룹의 인원수를 출력하시오.
select grade, count(*) from users where grade=3 or grade=4 group by grade;
--2. 1학년과 2학년의 최고점과 최저점의 점수 차이를 출력하시오.
select max(point)-min(point) from users where grade=1 or grade=2 group by grade;
--3. 주민번호 2 자리는 태어난 년도이다. 같은 년도에 태어난 사람을 카운팅 하시오.
--이때 태어난 년도와 인원수로 출력한다. 
-- **jumin이라는 컬럼으로 그룹의 기준을 정의
select substr(jumin,1,2)태어난년도, count(*)인원수 from users group by substr(jumin,1,2);

--+연구과제+ 
--그룹을 만들 때 그룹별 조건을 지정할 수 있다.
--예를 들어, 그룹의 인원이 3명 이상인 그룹의 인원수를 출력하시오.
--이 지시사항은 그룹별로 인원을 카운팅하고 그룹중에 인원수가 3명 이상인 그룹만 선택하는 의미이다.
--그룹에 조건을 지정하는 방법을 찾아보세요.
--다음 문제를 쿼리문으로 완성하세요.
--그룹의 인원이 3명 이상인 그룹의 인원수를 출력하세요.

select grade, count(*)인원수 from users group by grade having count(*)>=3;
--: 먼저 3명 이상인 그룹을 출력해야하니까 group by에서 3명 이상인 그룹을 지정해야함
--: 그 후 3명 이상인 그룹의 인원수를 출력
-- * having은 group by에 대한 조건이다. having절은 단독으로 쓸 수 없다. *

--*hard* 전체 평균보다 큰 평균값을 가진 그룹의 학년과 평균값을 출력하시오.
select grade, avg(point) from users group by grade 
having avg(point)>=(select avg(point)from users);
--서브쿼리의 결과값이 전체 평균. 그 결과값으로 그룹의 조건을 완성
--avg(point)>=서브쿼리 결과값(전체 평균)

select m.name, m.addr from (select * from users) m;
--: m이라는 이름으로 지정한 복제된 테이블을 만든 것 (실제 테이블을 조회해서 만든 임시 테이블)
--: from절에 m이라는 처음 보는 글자가 있기 때문에 
--  m은 서브 쿼리로 만든 임시 테이블의 이름을 지정한 것이라고 유추할 수 있음

-- Bonus Quiz 가장 높은 점수를 획득한 사람의 이름과 점수는?
select name, point from users where point = (select max(point) from users);
: 먼저 서브 쿼리로 가장 높은 점수를 출력