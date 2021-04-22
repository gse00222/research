SELECT * FROM works.jusorok;

select * from works.jusorok;

insert into works.jusorok value('이기자',23,'1999-3-13',default,'부산','학생',1);
insert into works.jusorok value('홍길동',37,'1985-2-12',default,'광주','자영업자',1);
insert into works.jusorok value('김말숙',28,'1994-12-15','여자','서울','회사원',1);
insert into works.jusorok value('이긴다',11,'2010-4-25',default,'수원','학생',1);
insert into works.jusorok value('고인말',35,'1989-10-14',default,'서울','회사원',1);
insert into works.jusorok value('김숙자',24,'1998-9-20','여자','부산','회사원',1);
insert into works.jusorok value('홍만길',27,'1995-5-30',default,'안산','학생',1);
insert into works.jusorok value('이겼다',42,'1980-7-20','여자','안양','자영업자',1);
insert into works.jusorok value('이겼나',20,'2001-3-19','여자','서울','회사원',1);
insert into works.jusorok value('김자수',21,'2000-2-18',default,'서울','군인',1);
insert into works.jusorok value('홍수진',21,'2000-2-18',default,'서울','군인',1);

/*delete from works.jusorok;*/

select * from works.jusorok;
-- 남자만 보여주시오.
select * from works.jusorok where gender='남자';
-- 나이가 30살 이상만 보여주시오.
select * from works.jusorok where age>=30;
-- 서울 지역만 보여주시오.
select * from works.jusorok where address= '서울';
-- 남자이면서 30살 이상인 사람만 보여주시오.
select * from works.jusorok where gender='남자' and age>=30;
-- jusorok테이블의 이름/나이/주소 필드를 '오늘도/29/서울'을 추가하시오.
insert into works.jusorok (name,age,address) values ('오늘도',29,'서울');
-- 성별이 여자 중에서 content 가 학생 인 자료를 보여주시오.
select * from works.jusorok where gender='여자' and content='학생';
-- 필드명 content필드를 job으로 수정 해보자.
alter table works.jusorok change content job varchar(15);
-- jusorok테이블에 pay필드(int)를 추가하시오.
alter table works.jusorok add pay int;
-- jusorok테이블의 구조를 부여주시오.
desc works.jusorok;

select * from works.jusorok;

-- 자료의 수정 : update 테이블명 set 필드명=수정할 내용...... where 조건절....;

-- 홍길동의 나이를 33살로 수정하시오.
update works.jusorok set age=33 where name='홍길동';

select * from works.jusorok where name='홍길동';

-- 모든 자료들의 나이를 +1살 하시오.
update works.jusorok set age=age+1;
-- 모든 자료들의 pay를 1000000으로 변경하시오.
update works.jusorok set pay=1000000;
select *from works.jusorok;
-- 여자 자료에 대하여 pay를 200000원 추가하시오.
update works.jusorok set pay=pay+200000 where gender='여자';
-- 제주와 부산 거주가는 pay를 100000원 추가 지급하시오.
update works.jusorok set pay=pay+100000 where address='부산' or address='제주';

select *from works.jusorok;
-- 서울 지역 거주자를 보여주시오.
select *from works.jusorok where address='서울';
-- 서울 지역 거주자 중에서 남자를 삭제하시오.
delete from works.jusorok where address='서울'and gender='남자';
-- 나이순으로 내림차순 정렬
select * from works.jusorok order by age desc;

-- 주소록 테이블을 juso로 변경하시오.


-- 주소록 테이블에 mbc필드를 추가(varchar(50) not null)
alter table works.jusorok add mbc varchar(50) not null;
-- 주소록 테이블에 mbc 필드를 삭제
alter table works.jusorok drop column mbc;

desc jusorok; 
-- ------------------------------------------------------------------
select *from jusorok;

update jusorok set pay=pay+100000 where age<=10;

select * from jusorok order by age desc;
-- 성별순으로 내림차순 정렬하되, 같은 성별은 나이오름차순으로 정렬하시오.
select * from jusorok order by gender desc, age;

-- 나이가 30~40사이를 보여주시오.
select * from jusorok where age>=30 and age<=40;
-- between ~ and - 지정된 범위의 자료를 처리. 윗줄과 아랫줄이 같은 의미.
select * from jusorok where age between 30 and 40;

select * from jusorok where job='회사원' or job='학생';
-- in() - 포함 연산자.
select * from jusorok where job in('회사원','학생');
-- like % - 포함 연산자(복수개의 와일드카드의 의미)
-- job 필드의 '사원'으로 끝나는 단어를 모두 보여주시오.
select * from jusorok where job like '%사원';

-- 김씨 성을 가진 모든 사람을 보여주시오.
select * from jusorok where name like '김%';

-- 이름 중에서 '말'이라는 글자가 들어있으면 모두 보여주시오.
select * from jusorok where name like '%말%';
-- 이름 중에서 '수'이라는 글자가 들어있으면 모두 보여주시오.
select * from jusorok where name like '%수%';

-- like _ - 포함 연산자(단수개의 와일드카드의 의미)
-- 이름 중에서 2번째 글자가 '수'로 끝나는 사람들을 보여주세요.  
select * from jusorok where name like '_수%';

-- 한계치를 적용 - limit , limit 시작 인덱스 , 보여줄 갯수;
-- 주소록의 자료를 처음부터 5건만 보여주시오.
select * from jusorok limit 5;
-- 주소록의 자료를 3번째부터 5건만 보여주시오.
select * from jusorok limit 2,5;



select *from jusorok;









