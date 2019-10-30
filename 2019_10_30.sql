-- SELECT : 조회할 컬럼 명시
--        - 전체 컬럼 조회 : *
--        - 일부 컬럼 : 해당 컬럼명 나열 (,구분)
-- FROM : 조회할 테이블 명시
-- 쿼리를 여러줄에 나누어서 작성해도 상관 없다.
-- 단 keyword는 붙여서 작성

-- 모든 컬럼을 조회
SELECT * FROM prod;

--특정 컬럼만 조회
SELECT prod_id, prod_name
FROM prod;

--실습 select1
--1)lprod 테이블에서 모든 데이터를 조회
SELECT *
FROM lprod;

--2)buyer 테이블에서 buyer_id, buyer_name 컬럼만 조회
SELECT buyer_id, buyer_name
FROM buyer;

--3)cart 테이블에서 모든 데이터를 조회
SELECT *
FROM cart;

--4)member 테이블에서 mem_id, mem_pass, mem_name 컬럼만 조회
SELECT mem_id, mem_pass, mem_name
FROM member;


-- 연산자 / 날짜연산
-- date type + 정수 : 일자를 더한다.
-- null을 포함한 연산의 결과는 항상 null이다.
SELECT userid, usernm, reg_dt,
        reg_dt+5 reg_dt_after5,
        reg_dt-5 AS reg_dt_before5  --컬럼명 정해줄때 as 써도되고 안써도됨
FROM users;

--실습 select2
--1)prod 테이블에서 prod_id, prod_name 두 컬럼을 조회(단, 별칭은 id, name)
SELECT prod_id AS id, prod_name AS name
FROM prod;

--2)1prod 테이블에서 lprod_gu, lprod_nm 두 컬럼을 조회(단, 별칭은 gu, nm)
SELECT lprod_gu AS gu, lprod_nm AS nm
FROM lprod;

--3)buyer 테이블에서 buyer_id, buyer_name 두 컬럼을 조회(단, 별칭은 바이어아이디, 이름)
SELECT buyer_id AS 바이어아이디, buyer_name 이름
FROM buyer;

--문자열 결합
--자바에서는 + SQL에서는 ||
--CONCAT(str, str) 함수
--users테이블의 userid, usernm
SELECT userid, usernm, userid || usernm, CONCAT(userid, usernm)
FROM users;

--문자열 상수 (컬럼에 담긴 데이터가 아니라 개발자가 직접 입력한 문자열)
SELECT '사용자 아이디 : ' || userid,
        CONCAT('사용자 아이디 : ', userid)
FROM users;

--실습 sel_con1
SELECT table_name
FROM user_tables;

SELECT 'SELECT * FROM ' || table_name || ';' AS QUERY
FROM user_tables;

--desc table
--테이블에 정의된 컬럼을 알고 싶을 때
--1.desc
--2.slect* ...
desc emp;

SELECT *
FROM user_tables;

--WHERE절, 조건 연산자
SELECT 'SELECT * FROM ' || table_name || ';' AS QUERY
FROM user_tables
ORDER BY desc user_tables;