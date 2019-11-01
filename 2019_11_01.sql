--복습
--WHERE
--연산자
-- 비교 : =, !=, <>, >=, >, <=, <
-- BETWEEN start AND end
-- IN (set)
-- LIKE 'S%' (% : 다수의 문자열과 매칭, _ : 정확히 한글자 매칭)
-- IS NULL ( != NULL 이거 아님)
-- AND, OR, NOT,

--emp 테이블에서 입사일자가 1981년 6월 1일부터 1986년 12월 31일 사이에 있는 직원 정보 조회
--BTWEEN AND
SELECT *
FROM emp
WHERE hiredate BETWEEN TO_DATE('19810601' ,'YYYYMMDD') AND TO_DATE('19811231' ,'YYYYMMDD');

SELECT *
FROM emp
WHERE hiredate >= TO_DATE('19810601' ,'YYYYMMDD') AND hiredate <= TO_DATE('19811231' ,'YYYYMMDD');

--emp 테이블에서 관리자(mgr)가 있는 직원만 조회
SELECT *
FROM emp
WHERE mgr IS NOT NULL;

----------------------------------------------------------------------------------------------------
--실습 where13
SELECT *
FROM emp
WHERE job='SALESMAN' OR (empno >= 7800 AND empno <7900) OR (empno >= 780 AND empno <790) OR (empno = 78);

SELECT *
FROM emp
WHERE job='SALESMAN' OR (empno LIKE '78%' AND hiredate >= TO_DATE('19810601' ,'YYYYMMDD'));

--order by 컬럼명 | 별칭 | 컬럼인덱스 [ASC | DESC]
--order by 구문은 WHERE절 다음에 기술
--ename 기준으로 오름차순 정렬
SELECT *
FROM emp
ORDER BY ename ASC;

--ASC를 안붙여도 위 쿼리와 동일
SELECT *
FROM emp
ORDER BY ename;

--이름(ename)을 기준으로 내림차순
SELECT *
FROM emp
ORDER BY ename DESC;

--job을 기준으로 내림차순으로 정렬, 만약 job이 같을 경우
--사번(empno)으로 오름차순 정렬
SELECT *
FROM emp
ORDER BY job DESC, empno;

--별칭으로 정렬하기
--사원 번호(empno), 사원명(ename), 연봉(sal*12) as year_sal
SELECT empno, ename, sal, sal*12 AS year_sal
FROM emp
ORDER BY year_sal;

--SELECT절 컬럼 순서 인덱스로 정렬
SELECT empno, ename, sal, sal*12 AS year_sal
FROM emp
ORDER BY 4;

--실습 orderby1
SELECT *
FROM dept
ORDER BY dname;

SELECT *
FROM dept
ORDER BY loc DESC;

--실습 orderby2
SELECT *
FROM emp
WHERE comm IS NOT NULL
ORDER BY comm DESC, empno;

--실습 orderby3
SELECT *
FROM emp
WHERE mgr IS NOT NULL
ORDER BY job, empno DESC;

--실습 orderby4
SELECT *
FROM emp
WHERE (deptno = 10 OR deptno = 30) AND sal > 1500
ORDER BY ename DESC;

SELECT ROWNUM, empno, ename
FROM emp;

SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM > 10;
--WHERE ROWNUM <=10;

--emp 테이블에서 사번(empno), 이름(ename)을 급여 기준으로 오름차순 정렬하고
--정렬된 결과순으로 ROWNUM
SELECT empno, ename, sal, ROWNUM
FROM emp
ORDER BY sal;

--실습 row1
SELECT ROWNUM, a.*
FROM
(SELECT empno, ename, sal
FROM emp
ORDER BY sal) a;


SELECT ROWNUM, a.*
FROM
(SELECT empno, ename, sal
FROM emp
ORDER BY sal) a
WHERE ROWNUM <= 10;


--실습 row_2(sal오름차순 정렬의 11~14만 출력)
--내가하다 실패한거
SELECT a.RN, a.empno, a.ename
FROM
(SELECT ROWNUM RN, empno, ename, sal
FROM emp
ORDER BY sal) a
WHERE sal>=2900;

--정답
SELECT *
FROM
    (SELECT ROWNUM rn, B.*
    FROM
        (SELECT empno, ename, sal
        FROM emp
        ORDER BY sal) B
    WHERE ROWNUM <= 14)
WHERE rn BETWEEN 11 AND 14;


--FUNCTION
--DUAL 테이블 조회
SELECT 'HELLO WORLD' as msg
FROM DUAL;

--문자열 대소문자 관련 함수
--LOWER, UPPER, INITCAP
SELECT LOWER('Hello, World'), UPPER('Hello, World'), INITCAP('hello, world')
FROM DUAL;

--FUNCTION은 WHERE절에서도 사용가능
SELECT *
FROM emp
--WHERE ename = UPPER('smith');
WHERE LOWER(ename) = 'smith';

--개발자 SQL 칠거지악
--1.좌변을 가공하지 말아라
--좌변(TABLE의 컬럼)을 가공하게 되면 INDEX를 정상적으로 사용하지 못함
--Function Based Index -> FBI

--CONCAT : 문자열 결합 - 두개의 문자열을 결합하는 함수
--SUBSTR : 문자열의 부분 문자열 (java : String.substring)
--LENGTH : 문자열의 길이
--INSTR : 문자열에 특정 문자열이 등장하는 첫번 째 인덱스
--LPAD : 문자열에 특정 문자열을 삽입
SELECT CONCAT('HELLO', CONCAT(', ','WORLD')) AS CONCAT,
       SUBSTR('HELLO, WORLD', 0, 5) substr1,
       SUBSTR('HELLO, WORLD', 1, 5) substr2,
       LENGTH('HELLO, WORLD') length,
       INSTR('HELLO, WORLD', 'O') instr1,
       INSTR('HELLO, WORLD', 'O', 6) instr2,
       --INSTR(문자열, 찾을 문자열, 문자열의 특정 위치 이후 표시)
       LPAD('HELLO, WORLD', 15, '*') lpad,
       --LAPD(문자열, 전체 문자열길이, 문자열이 전체문자열 길이에 미치지 못 할 경우 추가할 문자);
       LPAD('HELLO, WORLD',15,'*') lpad1,
       LPAD('HELLO, WORLD',15) lpad2,
       LPAD('HELLO, WORLD',15,' ') lpad3,
       RPAD('HELLO, WORLD',15,'*') rpad1
FROM dual;