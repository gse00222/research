show tables;

select * from test1;

-- 테이블 만들기 와중 idx 고유 인덱스 번호는 중복불허하고싶음.
-- auto_increment로 DB자동 숫자증가를 했으면 primary key를 지정해야 한다.
-- 회원 정보 테이블
create table test1 (
idx int not null auto_increment primary key,
mid varchar(20) not null,
pwd varchar(20) not null,
name varchar(10) not null,
age int default 20
);

insert into test1 values(default,'hkd1234','1234','홍길동',default);
insert into test1 values(default,'kms1234','1234','김말숙',25);
insert into test1 values(default,'lkj1234','1234','이기자',default);
insert into test1 values(default,'snm1234','1234','소나무',35);

select* from test1;
drop table test1;

delete from test1;

-- DVD 대여 테이블 
create table test2 (
  idx int not null auto_increment primary key, 
  dvdName varchar(50) not null,                
  mid varchar(20) not null,                    
  part varchar(10) not null default '액션',     
  dvdIpgo datetime default now(),             
  dvuSu int default 1                     
);
-- dvd 고유 번호
-- dvd 이름
-- DVD 대여한 사람의 아이디
--dvd 장르
-- dvd 대여 날짜
-- dvd 대여수량

insert into test2 values (default,'전쟁과평화','hkd1234',default,default,default);
insert into test2 values (default,'아침의제국','hkd1234','스릴러',default,default);
insert into test2 values (default,'프로그램과의전쟁','kms1234','교양',default,default);
insert into test2 values (default,'세상이가면','lkj1234','교양',default,default);
insert into test2 values (default,'세상밖으로','kms1234',default,default,default);
insert into test2 values (default,'자바의세상','java1234',default,'2021-4-14',default);

select*from test2;

-- inner join(내부 조인) - 공통사항을 참조한다. 
select a.mid,a.name,b.dvdName,b.part from test1 as a join test2 as b on a.mid=b.mid;

-- left join(외부 조인) - join기준으로 왼쪽테이블을 중심으로 출력
select a.mid,a.name,b.dvdName,b.part from test1 as a left join test2 as b on a.mid=b.mid;
-- right join(외부 조인) -join기준으로 오른족 테이블을 중심으로 출력
select a.mid,a.name,b.dvdName,b.part from test1 as a right join test2 as b on a.mid=b.mid;












