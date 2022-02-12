use sqldb;

show tables;

select * from buytbl;

select prodname from buytbl;

select * from usertbl;

select * from usertbl where name = '김경호';

-- 출생년도가 1970년 이후이고, 키가 182 이상인 회원의 userid를 출력
select userid from usertbl where birthYear > 1970 and height >= 182;

-- 출생년도가 1970년 이후이거나, 키가 182 이상인 회원의 userid를 출력
select userid from usertbl where birthyear > 1970 or height >= 182;

-- 키가 180 이상이고 183 이하인 회원의 이름을 출력
select name from usertbl where height between 180 and 183;

-- 출생지가 '경남', '전남', 또는 '경북'인 회원의 이름과 아이디, 주소를 출력
select name, userid, addr from usertbl where addr in ('경남', '전남', '경북');

-- 텍스트 검색 
-- 성이 '김'인 사람의 데이터를 출력
select * from usertbl where name like '김%';

-- 이름이 '종신'인 사람의 데이터를 출력
select * from usertbl where name like '%종신';

-- 이름이 '종신'인 성이 한 글자인 사람의 데이터를 출력
select * from usertbl where name like '_종신';

-- 키가 178 이상인 사람의 데이터를 출력
select * from usertbl where height >= 178;

-- 임재범 보다 키가 큰 사람의 데이터를 출력
select * from usertbl where height > (select height from usertbl where name = '임재범');

-- 임재범 보다 나이가 많은 사람의 이름을 출력하시오
select name from usertbl where birthyear < (select birthyear from usertbl where name = '임재범');

-- 김범수와 출생지역이 동일한 사람의 데이터를 출력하시오
select * from usertbl where addr in (select addr from usertbl where name = '김범수');

-- 경남에 사는 사람 보다 키가 큰 사람의 데이터를 출력 
-- subquery 에서 값이 복수인 경우 비교연산 할 수 없다
-- all() : 전체 데이터에 True,  any() : 어느 하나만 True

select height from usertbl where addr = '경남';
select * from usertbl where height > (select height from usertbl where addr = '경남');
select * from usertbl where height > all (select height from usertbl where addr = '경남');
select * from usertbl where height > any (select height from usertbl where addr = '경남');

-- 경남에 사는 사람과 키가 동일한 사람의 데이터 출력
select * from usertbl where height in (select height from usertbl where addr = '경남');

-- 정렬(sort)   order by
-- 출생 기준으로 오름차순 정렬해서 출력
select * from usertbl order by birthyear;

-- 출생 기준으로 내림차순 정렬해서 출력
select * from usertbl order by birthyear desc;

-- 키 순으로 오름차순 정렬하시오
select * from usertbl order by height;

-- 키 순으로 내림차순 정렬하시오
select * from usertbl order by height desc;

-- 출생지의 종류를 중복값 없이 출력하시오
select distinct(addr) from usertbl ;

-- 출생지 종류수를 출력하시오
select count(distinct(addr)) from usertbl;

-- n개만 출력
select * from usertbl limit 3;

-- 키가 가장 큰 사람의 이름을 출력하시오
select name from usertbl order by height desc limit 1;

-- subquery를 이용해서 기존 table을 복사해서 새로운 table을 생성
create table usertbl1 (select * from usertbl);
select * from usertbl1;

create table usertbl2 (select name, mdate from usertbl);
select * from usertbl2;

drop table usertbl1;
drop table usertbl2;




create database practice;
use practice;

create table onepiece(
	name char(10) not null,
    title char(10) not null,
    prize int,
    age int not null,
    hometown char(10) not null);

insert ignore into onepiece values( '루피', '해적', 10000, 19, '이스트 블루');
insert ignore into onepiece values( '크로커다일', '해적', 500, 34, '웨스트 블루');
insert ignore into onepiece values( '키자루', '해군', null, 46, '노스 블루');
insert ignore into onepiece values( '사보', '혁명군', 8000, 20, '이스트 블루');
insert ignore into onepiece values( '스모커', '해군', null, 30, '이스트 블루');
insert ignore into onepiece values( '이반', '혁명군', 7000, 39, '위대한 항로');
insert ignore into onepiece values( '징베', '해적', 12000, 42, '위대한 항로');


select * from onepiece;

-- 키자루의 데이터를 뽑아라
select * from onepiece where name = '키자루';

-- 나이가 20 이상인 자들의 데이터를 뽑아라
select * from onepiece where age >= 20;

-- title이 혁명군인 자들의 이름과 출신을 뽑아라
select name, hometown from onepiece where title = '혁명군';

-- 출신이 이스트 블루이면서 노스 블루인 자들의 이름과 나이를 뽑아라
select name, age from onepiece where hometown in ('이스트 블루', '노스 블루');

-- 출신이 웨스트 블루인 사람보다 현상금이 더 높은 자들의 데이터를 뽑아라
select * from onepiece where prize > all (select prize from onepiece where hometown = '웨스트 블루');


use sqldb;

select * from usertbl;
select * from buytbl;

-- 구매횟수
select userid, count(amount) as '구매횟수' from buytbl  group by userid order by count(amount);

-- 사용자별 총구매액이 1000 이상인 고객데이터 출력
-- group by 에서 조건을 지정하는 경우 : having (o), where (x)
select userid, sum(price * amount) as '총구매금액' from buytbl group by userid having sum(price * amount) >= 1000 ;

-- 구매횟수가 2회 이상인 고객정보를 출력
select userid, count(prodname) as '구매횟수' from buytbl group by userid having count(prodname) >= 2;

-- usertbl 에서 가장 키가 큰 사람과 작은 사람을 출력하시오
select name, height from usertbl order by height desc limit 1;
select name, height from usertbl order by height limit 1;





use employees;
select * from employees;

create table testtbl1(id int, fname varchar(50), lname varchar(50));
use sqldb;
insert into testtbl1 select emp_no, first_name, last_name from employees.employees;
select * from testtbl1;


-- join
select * from usertbl;
select * from buytbl;

select * from buytbl b inner join usertbl u on b.userid = u.userid;

select * from buytbl, usertbl where buytbl.userid = usertbl.userid;

-- 조용필이 구매한 제품의 이름과 조용필의 주소를 출력하시오
select name, prodname, addr from buytbl b inner join usertbl u on b.userid = u.userid where name = '조용필';










create database cartoon;
use cartoon;

create table bleach(
	 name char(10) primary key,
     age int not null,
     title char(10) not null,
     hometown char(10) not null);
     
insert into bleach values('Ichigo', 18, 'reaper', 'earth');

select * from bleach;

use sqldb;
show tables;

select * from buytbl;
select * from usertbl;

-- 김경호라는 가수의 데이터를 출력
select * from usertbl where name = '김경호';

-- 출생년도가 1970년 이후이고, 키가 182 이상인 회원의 userid를 출력
select userid from usertbl where birthyear > 1970 and height >= 182;

-- 출생년도가 1970년 이후이거나, 키가 182 이상인 회원의 userid를 출력
select userid from usertbl where birthyear >= 1970 or height >= 182;

-- 키가 180 이상이고 183 이하인 회원의 이름을 출력
select name from usertbl where height between 180 and 183;

-- 출생지가 '경남', '전남', 또는 '경북'인 회원의 이름과 아이디, 주소를 출력
select name, userid, addr from usertbl where addr in ('경남', '전남' ,'경북');

-- 성이 '김'인 사람의 데이터를 출력
select * from usertbl where name like '김%';

-- 이름이 '종신'인 사람의 데이터를 출력
select * from usertbl where name like '%종신';

-- 이름이 '종신'인 성이 한 글자인 사람의 데이터를 출력
select * from usertbl where name like '_종신';

-- 임재범 보다 키가 큰 사람의 데이터를 출력
select height from usertbl where name = '임재범';
select * from usertbl where height > (select height from usertbl where name = '임재범');

-- 임재범 보다 나이가 많은 사람의 이름을 출력하시오
select name from usertbl where  birthyear < (select birthyear from usertbl where name = '임재범');

-- 김범수와 출생지역이 동일한 사람의 데이터를 출력하시오
select * from usertbl where addr in (select addr from usertbl where name = '김범수');

-- 경남에 사는 사람 보다 키가 큰 사람의 데이터를 출력
select * from usertbl where height > all(select height from usertbl where addr = '경남');

-- 경남에 사는 사람과 키가 동일한 사람의 데이터 출력
select * from usertbl where height in (select height from usertbl where addr = '경남');

-- 출생 기준으로 오름차순 정렬해서 출력
select * from usertbl order by birthyear;

-- 출생 기준으로 내림차순 정렬해서 출력
select * from usertbl order by birthyear desc;

-- 키 순으로 오름차순 정렬하시오
select * from usertbl order by height;

-- 키 순으로 내림차순 정렬하시오
select * from usertbl order by height desc;

-- 출생지의 종류를 중복값 없이 출력하시오
select distinct(addr) from usertbl;

-- 출생지 종류수를 출력하시오
select count(distinct(addr)) from usertbl;

-- n개만 출력
select * from usertbl limit 4;

-- 키가 가장 큰 사람의 이름을 출력하시오
select name from usertbl order by height desc limit 1;

-- subquery를 이용해서 기존 table을 복사해서 새로운 table을 생성
create table usertbl2(select * from usertbl);

drop table usertbl2;

-- groupby
-- 총구매액
select userid, sum(price * amount) as '총구매액'  from buytbl group by userid;

-- 평균구매액
select userid, avg(price * amount) as' 평균구매액' from buytbl group by userid;

-- 구매횟수
select userid, count(amount) as '구매횟수' from buytbl group by userid;

-- 사용자별 총구매액이 1000 이상인 고객데이터 출력
select userid, sum(price * amount) as' 총구매액' from buytbl group by userid having sum(price * amount) >= 1000 ;

-- 구매횟수가 2회 이상인 고객정보를 출력
select * from buytbl group by userid having count(amount) >= 2 ;

-- usertbl 에서 가장 키가 큰 사람과 작은 사람을 출력하시오
select * from usertbl;
select name, height from usertbl where height in ((select max(height) from usertbl), (select min(height) from usertbl));


-- join
select * from usertbl inner join buytbl on usertbl.userid = buytbl.userid;
select * from usertbl u inner join buytbl b  on u.userid = b.userid;

-- 조용필이 구매한 제품의 이름과 조용필의 주소를 출력하시오
select name, prodname, addr from usertbl u inner join buytbl b on u.userid = b.userid where name = '조용필';

-- 모니터를 구매한 사람들의 이름을 출력
select name from usertbl u inner join buytbl b on u.userid =  b.userid where prodname = '모니터';

-- 전화번호가 없는 고객의 이름, 주소, 구매제품을 출력
select name, addr, prodname from usertbl u inner join buytbl b on u.userid =  b.userid where mobile1 is null ;


drop procedure if exists ifproc3;
delimiter $$

create procedure ifproc3()

select cast('2020-10-16 12:25:29:123' as date) as 'Date';






