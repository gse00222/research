select * from jusorok;

show tables;

-- 남자/여자 군에 자료 1건씩 출력.
select distinct gender as '성별' from jusorok;
-- 각 직업군(중복 불허된 직업)에 대한 자료출력
select distinct job as '직업' from jusorok;
-- 남자들의 직업군에 대한 자료출력
select distinct job as '직업' from jusorok where gender='남자';

-- 주소록에 사용된 직업의 개수(count)는?
select count(*) from jusorok; -- 전체 레코드 갯수.
select count(name) from jusorok where gender='남자'; -- 성별이 남자인 자료의 개수.
select count(distinct job) as '사용된 직업갯수' from jusorok;

-- %함수% 중요!!!!!!!!!!!!

-- 개수를 구하는 함수 - count().
-- 서울에 사는 여자가 몇명인지 보여주시오.
select count(*) from jusorok where address='서울' and gender='여자';

-- 합계를 구하는 함수 - sum()
-- 전체 pay의 합계를 구하시오.
select sum(pay) as '급여' from jusorok; 
-- 서울에 사는 여자회원의 총 pay 합계를 보여주시오.
select sum(pay) as '급여' from jusorok where address='서울' and gender='여자';

--  평균을 구하는 함수 - avg()
-- 전체 pay의 평균을 구하시오
select avg(pay) as '급여 평균' from jusorok;

-- 남자 회원의 급여 평균을 구하시오.
select gender,avg(pay) as '남자회원 급여평균' from jusorok where gender='남자';

-- 최대값을 구하는 함수 - max()
-- 성별에 상관없이 최대 급여액을 구하시오.
select max(pay) from jusorok;
-- 최소값을 구하는 함수 - min()
-- 성별에 상관없이 최소 급여액을 구하시오.
select min(pay) from jusorok;

-- 그룹(군)을 지어서 표시하고자 할 때 - (group by절 ~having 조건)를 쓴다.
-- 성별에 대한 자료?
select * from jusorok group by gender; -- 각 자료의 첫번째 모든 자료가 나온다.(*라서)

-- 성별에 따른 급여액의 평균.
select gender,avg(pay) from jusorok group by gender;
-- 각 성별에 따른 인원 수 와 급여의 합계를 출력하시오.
select gender,sum(pay),count(*) from jusorok group by gender;

-- 각 성별에 따른,인원수와 급여의 합계를 출력하시오(단 30~40세의 자료)
select gender,sum(pay),count(*) from jusorok where age between 30 and 40 group by gender; 

-- 각 직업군을 출력하시오.W
select job from jusorok group by job;

-- 각 직업군의 갯수를 출력하시오.
select job,count(*) from jusorok group by job;

-- 각 직업군의 개수를 비교하되 직업군의 갯수가 2개 이상인 경우만 출력하시오.
select job,count(*) as cnt from jusorok group by job having cnt>=2;
-- 각 직업군의 남자의 명수를 출력하시오.
select job,count(*) from jusorok where gender='남자' group by job;
-- 각 직업군의 남자의 명수를 비교하되 직업군의 갯수가 2개 이상인 경우만 출력하시오.
select job,count(*) from jusorok where gender='남자' group by job having count(*)>=2;

-- 반올림 함수 - round() , round(소수 이하 자리수)
select round(123.456); -- 123.456을 반올림했다.
select round(123.456,1); -- 123.456을 반올림하되 소수이하 1자리까지 구하라.
select round(123.456,-1); -- 123.456을 반올림하되 정수자리 1자리까지 반올림해라.

-- 주소록의 나이평균을 구하시오.
select avg(age) from jusorok;
-- 주소록의 나이평균을 구하시오 (정수부 반올림처리하시오.).
select round(avg(age),1) from jusorok;

-- 내림함수 - truncate(,표현 자리수)
select truncate(125.678,-1);
select truncate(125.678,0);
select truncate(125.678,1);
-- 주소록의 나이평균을 구하시오 (내림처리해 정수만 출력하시오).
select truncate(avg(age),0) from jusorok;

-- 무조건 올림 - ceil() , 무조건 내림 floor().
select ceil(123.456);
select ceil(-123.456);

select floor(123.956);
select floor(-123.956);

-- 나이의 평균을 구하되, 소수이하는 버리시오.
select floor(avg(age)) from jusorok;

-- 성별에 따른 나이의 평균을 구하되, 소수이하는 버리시오.
select gender as '성별나이 평균',floor(avg(age)) from jusorok group by gender;

-- 절대값(양수값 표현) - abs()
select abs(1234);
select abs(-1234);
select abs(123-456);

-- 나머지를 구하는 함수 - mod(정수1, 정수2)
select mod(10,3);
-- 10을 3으로 나눴을 때의 몫과 나머지를 구하시오.
select floor(10/3) as '몫',mod(10,3) as '나머지';

-- 지수(승수) 함수 - power(n1,n2) 밑수n1,지수n2.
select power(10,3) as '10^3';

-- 천단위마다 쉼표를 표시 - format(필드명,소수 이하자리수)
select format(12314345,0);
select format(12314.345,0);
select name,format(pay,0) from jusorok;

-- 문자 함수 --
-- 영문 대.소문자 변환 - upper,lower.
select upper('asdBBQwe');
select lower('asdBBQwe');
select upper('Welcome to Korea!');
select lower('Welcome to Korea!');

-- 문자열의 길이를 구하시오.
select length('Seoul');
select job,length(job) from jusorok;

-- 결합 연산자 - concat(문자열1, 문자열2...)
select concat('a','b','c');
select name,age from jusorok;

select concat('이름: ',name),concat('나이 : ',age) from jusorok;

-- 지정된 문자열을 반환 - substr(문자열, 시작위치(1부터 시작), 절제할 개수)
select substr('Welcome to korea',4,4);
select substr('Welcome to korea',9,2);
select substr('Welcome to korea',12);

-- 'seoul서울'의 길이는?
select length('seoul서울');

select substr('Welcome to 한국 Korea',12,2); -- 한국 추출하기
-- 직업의 두번째 글자만 출력
select substr(job,2,1) from jusorok;

-- 생일을 'xxxx년 xx월 xx일'로 이름과 같이 출력하시오.
select concat('이름 : ',name) as '이름',concat(substr(birthday,1,4),'년',substr(birthday,6,2),'월',substr(birthday,9,2),'일') as '생년월일' from jusorok;

-- 중간 위치값을 출력하고자 한다 - mid(문자열, 시작위치, 추출크기) 
select mid('Welcome to Korea',4,4);
select mid('Welcome to Korea',4);

-- 문자열 중에서 특정 문자의 존재 유무 - instr()
select instr('welcOme to korea','o'); -- 대소문자 구분을 안함.

select instr('welcome to korea',' ');
select instr('welcome to korea','  ');

-- 왼쪽, 오른족, 중간 문자열 호출 - left(), right(), min().
select left('welcome to korea',3);
select right('welcome to korea',3);
select mid('welcome to korea',4,4);

-- 문자열 치환 - replace(str, char1 ,char2) 문자열(str)중에서 특정 문자(char1)를 지정한 문자(char2)로 치환한다.
select ('Welcome to korea');
select replace('Welcome to korea',' ','');
select replace('Welcome to korea',' ','_');

-- 날짜 함수 - now()
-- 오늘 시스템의 날자/시간 출력
select now();

-- 연도를 출력 - year
select year(now());
-- 월 출력 -month
select month(now());
-- 일 출력 - day
select day(now());

select concat(year(now()),'년',month(now()),'월', day(now()),'일');

select name,birthday from jusorok;

select name,substr(birthday,1,10) from jusorok;

-- 시간 - hour, 분 - minute, 초 - second.
select hour(now());
select minute(now());
select second(now());

select concat(hour(now()),'시',minute(now()),'분',second(now()),'초') as '현재시간';

-- 요일(dayname() / week())

select dayname(now()); -- 현재 요일을 영어로 출력해준다.
select week(now()); -- 현재가 올해의 몇번째 주 인지를 출력해준다(0부터 시작)

select monthname(now()); -- 현재 월을 영어로 출력한다.

-- 지정된 형식으로 날짜 출력 - date_format() , 날짜 기호 앞에 '%'를 붙여서 서식을 지정한다.
select name,birthday from jusorok;
-- 두자리씩나옴
select date_format(now(),'%y-%m-%d');
-- 연도만 4자리됨
select date_format(now(),'%Y-%m-%d'); 
-- 월이 영어로나옴
select date_format(now(),'%Y-%M-%d'); 
-- 요일이 영어로나옴
select date_format(now(),'%y-%m-%d %W'); 
-- 요일이 숫자로 나옴
select date_format(now(),'%y-%m-%d %w');

select date_format(birthday,'%Y-%m-%d %w') from jusorok; 
select date_format(birthday,'%y-%m-%d %w') from jusorok;

-- am/pm 개념으로 나옴, 시간이 두자리로나옴
select date_format(now(), '%h:%i:%s');
-- 24시 기준으로 나옴
select date_format(now(), '%H:%i:%s');
--두번째 위랑 같지만 시간이 한자리로 나온다.
select date_format(now(), '%l:%i:%s');
-- 현재 시간에 자동으로 am/pm 이 붙는다
select date_format(now(), '%r');
-- 월과 일의 표현을 한(두)자리로 표시(한자리면 한자리나온다는 것)
select date_format(now(), '%Y-%c-%e');

select date_format(birthday, '%Y-%c-%e') from jusorok;

-- 현재 날짜 - now()/sysdate()/current_timestamp()
select now();
select sysdate();
select current_timestamp();

-- 날짜 연산(date_add(기본 날짜, 계산할 수치 값)) - interval 명령어와 함께사용.
select now();
-- 오늘 날짜에 +1일 한 것
select date_add(now(), interval 1 day);
-- 오늘 날짜에 -1일 한 것
select date_add(now(), interval -1 day);
-- 오늘 날짜에 +1시간 한 것.
select date_add(now(), interval 1 hour);
-- 오늘 날짜에 -1시간 한 것
select date_add(now(), interval -1 hour);
-- 오늘 날짜에 +24시간 한 것
select date_add(now(), interval 24 hour);

select date_add(birthday, interval 1 day) from jusorok;

select date_add(birthday, interval 24 hour) from jusorok;

-- 달의 마지막 일자를 구하기 - last_day()
select last_day(now());

select last_day('2021-2-1');
select last_day('2020-2-1');

-- 날짜 차이 계산하기(to_days())
-- 오늘 날짜 -2021-4-1일 15일차이가 나서 15나옴
select to_days(now()) - to_days('2021-4-1');
-- 오늘부터 5일 전의 날짜는?
select date_format(date_add(now(), interval -5 day),'%Y-%m-%d');

-- 날짜 차이 비교 계산 - datediff()
select datediff(now(),'2021-4-1');






select * from jusorok;