--GROUPING (cube, rollup 절에 사용된 컬럼)
--해당 컬러밍 소계 계산에 사용된 경우 1
--사용되지 않는 경우 0

--job 컬럼 
--case1. GROUPING(job) = 1, GROUPING(deptno) = 1
--       job --> '총계'
--case else
--       job --> job
SELECT CASE WHEN GROUPING(job) = 1 AND GROUPING(deptno) = 1 THEN '총계'
            ELSE job
       END job,
       CASE WHEN GROUPING(job) = 0 AND GROUPING(deptno) = 1 THEN job || ' 소계'
            ELSE TO_CHAR(deptno)
       END deptno,
       /*GROUPING(job), GROUPING(deptno),*/ sum(sal) sal
FROM emp
GROUP BY ROLLUP (job, deptno);

--실습 GROUP_AD3
SELECT deptno, job, sum(sal) sal
FROM emp
GROUP BY ROLLUP (deptno, job);

--실습 GROUP_AD4(과제)
SELECT dept.dname, job, sum(sal) sal
FROM emp, dept
WHERE emp.deptno = dept.deptno
GROUP BY ROLLUP (dept.dname, job);

--실습 GROUP_AD5(과제)
SELECT CASE WHEN GROUPING(dname) = 1 AND GROUPING(job) = 1 THEN '총계'
            ELSE dept.dname 
       END dname, job, sum(sal) sal
FROM emp, dept
WHERE emp.deptno = dept.deptno
GROUP BY ROLLUP (dept.dname, job);


-----------------------------------------------------------------------

--CUBE (col1, col2, ...)
--CUBE 절에 나열된 컬럼의 가능한 모든 조합에 대해 서브 그룹으로 생성
--CUBE에 나열된 컬럼에 대해 방향성은 없다(rollup과의 차이)
--GROUP BY CUBE(job, deptno)
--oo : GROUP BY job, deptno
--ox : GROUP BY job
--ox : GROUP BY deptno
--xx : GROUP BY --모든 데이터에 대해서...

SELECT job, deptno, sum(sal) sal
FROM emp
GROUP BY CUBE (job, deptno);


-----------------------------------------------------------------------
--subquery를 통한 업데이트
DROP TABLE emp_test;

--emp테이블의 데이터를 포함해서 모든 컬럼을 이용하여 emp_test테이블로 생성
CREATE TABLE emp_test AS
SELECT *
FROM emp;

--emp_test 테이블의 dept테이블에서 관리되고 있는 dname 컬럼(VARCHAR2(14))을 추가
ALTER TABLE emp_test ADD (dname VARCHAR2(14));

SELECT *
FROM emp_test;

--emp_test테이블의 dname 컬럼을 dept테이블의 dname 컬럼 값으로 업데이트하는
--쿼리 작성

UPDATE emp_test SET dname = ( SELECT dname
                              FROM dept
                              WHERE dept.deptno = emp_test.deptno );


--실습 sub_a1
CREATE TABLE dept_test AS
SELECT *
FROM dept;

ALTER TABLE dept_test ADD (empcnt NUMBER(6));

--내가한거
UPDATE dept_test SET empcnt = ( SELECT a.c
                                FROM (SELECT deptno, COUNT(*) c
                                        FROM emp
                                        GROUP BY deptno) a
                                WHERE a.deptno = dept_test.deptno);
--정답
UPDATE dept_test SET empcnt = (SELECT COUNT(*)
                               FROM emp
                               WHERE deptno = dept_test.deptno);

SELECT *
FROM dept_test;


--실습 sub_a2
SELECT *
FROM dept_test;
INSERT INTO dept_test VALUES(98, 'it', 'daejeon', 0);
INSERT INTO dept_test VALUES(99, 'it', 'daejeon', 0);

DELETE FROM dept_test
WHERE NOT EXISTS (SELECT 'X'
                  FROM emp
                  WHERE deptno = dept_test.deptno);

rollback;

--실습 sub_a3
SELECT *
FROM emp_test;
SELECT *
FROM emp;

UPDATE emp_test SET sal = sal+200
WHERE sal < (SELECT AVG(sal)
             FROM emp_test a
             WHERE a.deptno = emp_test.deptno);

SELECT deptno, AVG(sal)
FROM emp
GROUP BY deptno;

--emp, emp_test empno컬럼으로 같은값끼리 조회
--1.emp.empno, emp.ename, emp.sal, emp_test.sal
--2.emp.empno, emp.ename, emp.sal, emp_test.sal, 해당사원(emp테이블 기준)이 속한 부서의 급여평균

SELECT emp.empno, emp.ename, emp.sal, emp_test.sal, emp.deptno
FROM emp, emp_test
WHERE emp.empno = emp_test.empno;


SELECT a.*, b.avg
FROM
(SELECT emp.empno, emp.ename, emp.sal sal1, emp_test.sal sal2, emp.deptno
FROM emp, emp_test
WHERE emp.empno = emp_test.empno) a,
(SELECT deptno, ROUND(AVG(sal),2) avg
FROM emp
GROUP BY deptno) b
WHERE a.deptno = b.deptno;
