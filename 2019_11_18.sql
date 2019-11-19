SELECT *
FROM USER_VIEWS;

SELECT *
FROM ALL_VIEWS
WHERE OWNER = 'PC21';

SELECT *
FROM PC21.V_EMP_DEPT;

--sem 계정에서 조회권한을 받은 V_EMP_DEPT view를 hr 계정에서 조회하기
--위해서는 계정명.view이름 형식으로 기술을 해야하나다
--매번 계정명을 기술하기 귀찮으므로 시노님을 통해 다른 별칭을 생성

CREATE SYNONYM V_EMP_DEPT FOR PC21.V_EMP_DEPT;

--PC21.V_EMP_DEPT --> V_EMP_DEPT
SELECT *
FROM V_EMP_DEPT;

--시노님 삭제
DROP SYNONYM V_EMP_DEPT;

--hr 계정 비밀번호 : java
--hr 계정 비밀번호 변경 : hr
ALTER USER hr IDENTIFIED BY hr;

--dictionary
--접두어   : USER : 사용자 소유 객체
--          ALL : 사용자가 사용가능 한 객체
--          DBA : 관리자 관점의 전체 객체(일반 사용자는 사용 불가)
--          V$ : 시스템과 관련된 view(일반 사용자는 사용 불가)

SELECT *
FROM USER_TABLES;

SELECT *
FROM ALL_TABLES;

SELECT *
FROM DBA_TABLES
WHERE OWNER IN('PC21', 'HR');

--오라클에서 동일한 SQL이란?
--문자가 하나라도 틀리면 안됨
--다음 sql들은 같은결과를 만들어 낼지 몰라도 DBMS에서는
--서로 다른 SQL로 인식된다.
SELECT /*bind_test*/* FROM emp;
Select /*bind_test*/* FROM emp;
Select /*bind_test*/*  FROM emp;

--이렇게 하면 실행계획 공유, 불필요하게 메모리 부하 안주기위해
Select /*bind_test*/*  FROM emp WHERE empno=:empno;

--system계정에서 조회
SELECT *
FROM v$SQL
WHERE SQL_TEXT LIKE '%bind_test%';



