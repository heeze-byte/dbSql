--숫자비교 연산
--부서번호가 30번 보다 크거나 같은 부서에 속한 직원 조회
SELECT *
FROM emp
WHERE deptno >= 30;

--부서번호가 30번 보다 작은 부서에 속한 직원 조회
SELECT *
FROM emp
WHERE deptno < 30;

--입사일자가 1982년 1월 1일 이후인 직원 조회
SELECT *
FROM emp
WHERE hiredate >= TO_DATE('19820101', 'YYYYMMDD');
--WHERE hiredate >= TO_DATE('1982/01/01', 'YYYY/MM/DD');

--col BETEEN X AND Y 연산
--컬럼의 값이 x보다 크거나 같고, y보다 작거나 같은 데이터
--급여(sal)가 1000보다 크거나 같고, 2000보다 작거나 같은 데이터를 조회
SELECT *
FROM emp
WHERE sal between 1000 and 2000;

SELECT *
FROM emp
WHERE sal >= 1000
AND sal <= 2000
AND deptno = 30;

--실습 where1
SELECT ename, hiredate
FROM emp
WHERE hiredate BETWEEN TO_DATE('19820101', 'YYYYMMDD') AND TO_DATE('19830101', 'YYYYMMDD');

--실습 where2
SELECT ename, hiredate
FROM emp
WHERE hiredate >= TO_DATE('19820101', 'YYYYMMDD') AND HIREDATE <= TO_DATE('19830101', 'YYYYMMDD');

--IN 연산자
--COL IN (values...)
--부서번호가 10 혹은 20인 직원 조회
SELECT *
FROM emp
WHERE deptno in (10, 20);

--IN 연산자는 AND/OR 연산자로 표현할 수 있다.
SELECT *
FROM emp
WHERE deptno = 10 OR deptno = 20;

--실습 where3
SELECT USERID 아이디 , USERNM 이름 
FROM users
WHERE USERID IN ('brown', 'cony', 'sally');

--COL LIKE 'S%'
--COL 의 값이 대문자 s로 시작하는 모든 값
--COL LIKE 'S____'
--COL의 값이 대문자 s로 시작하고 이어서 4개의 문자열이 존재하는 값

--emp 테이블에서 직원이름이 s로 시작하는 모든 직원 조회
SELECT *
FROM emp
WHERE ename LIKE 'S%';

SELECT *
FROM emp
WHERE ename LIKE 'S____';

--실습 where4
SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '신%';

--실습 where5
SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '%진%';

--NULL 비교
--col IS NULL
--EMP 테이블에서 MGR정보가 없는 사람(NULL) 조회
SELECT *
FROM emp
WHERE mgr IS NULL;

--소속 부서가 10번이 아닌직원들
SELECT *
FROM emp
WHERE deptno != '10';
-- = , !=
-- IS NULL, IS NOT NULL

--실습 where6
SELECT *
FROM emp
WHERE comm IS NOT NULL;

--AND / OR
--관리자(mgr) 사번이 7698이고 급여가 1000 이상인 사람
SELECT *
FROM emp
WHERE mgr = 7698 AND sal >= 1000;

--emp 테이블에서 관리자(mgr) 사번이 7698이거나
--  급여(sal)가 1000 이상인 직원 조회
SELECT *
FROM emp
WHERE mgr = 7698 OR sal >= 1000;

--emp 테이블에서 관리자(mgr) 사번이 7698이 아니고, 7839가 아닌 직원들 조회
SELECT *
FROM emp
WHERE mgr NOT IN (7698, 7839);

SELECT *
FROM emp
WHERE mgr != 7698 AND mgr != 7839;

--IN, NOT IN 연산자의 NULL 처리
--emp 테이블에서 관리자(mgr) 사번이 7698, 7839 또는 null이 아닌 직원들 조회
SELECT *
FROM emp
WHERE mgr NOT IN(7698,7839) AND mgr IS NOT NULL;
--WHERE mgr NOT IN(7698,7839, NULL); IN안에 NULL있으면 의도하지 않은 결과

--실습 where7
SELECT *
FROM emp
WHERE job = 'SALESMAN' AND hiredate > TO_DATE('19810601', 'YYYYMMDD');

--실습 where8
SELECT *
FROM emp
WHERE deptno != 10 AND hiredate > TO_DATE('19810601', 'YYYYMMDD');

--실습 where9
SELECT *
FROM emp
WHERE deptno NOT IN(10) AND hiredate > TO_DATE('19810601', 'YYYYMMDD');

--실습 where10
SELECT *
FROM emp
WHERE deptno IN(20, 30) AND hiredate > TO_DATE('19810601', 'YYYYMMDD');

--실습 where11
SELECT *
FROM emp
WHERE job = 'SALESMAN' OR hiredate > TO_DATE('19810601', 'YYYYMMDD');

--실습 where12
SELECT *
FROM emp
WHERE job='SALESMAN' OR empno LIKE '78%';

--실습 where13
SELECT *
FROM emp
WHERE job='SALESMAN' OR (empno >= 7800 AND empno <7900);


