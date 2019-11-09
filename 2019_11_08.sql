--조인복습
--조인 왜??
--RDBMS의 특성상 데이터 중복을 최대 배제한 설계를 한다.
--EMP 테이블에는 직원의 정보가 존재, 해당 직원의 소속 부서정보는
--부서번호만 갖고있고, 부서번호를 통해 dept 테이블과 조인을 통해
--해당 부서의 정보를 가져올 수 있다.

--직원 번호, 직원이름, 직원의 소속 부서번호, 부서이름
--emp, dept

SELECT emp.empno, emp.ename, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--부서번호, 부서명, 해당부서의 인원수
SELECT e.deptno, dept.dname, cnt
FROM    (SELECT deptno, count(*) cnt
        FROM emp
        GROUP BY DEPTNO) e, dept
WHERE e.deptno = dept.deptno;


--count(col) : col 값이 존재하면 1, null이면 0
--TOTAL ROW : 14
SELECT COUNT(*), COUNT(EMPNO), COUNT(MGR), COUNT(COMM)
FROM emp;

--OUTER JOIN : 조인에 실패도 기준이 되는 테이블의 데이터는 조회결과가 나오도록 하는 조인 형태
--LEFT OUTER JOIN : JOIN KEYWORD 왼쪽에 위치한 테이블이 조회 기준이 되도록 하는 조인 형태
--RIGHT OUTER JOIN : JOIN KEYWORD 오른쪽에 위치한 테이블이 조회 기준이 되도록 하는 조인 형태
--FULL OUTER JOIN : LFET OUTER JOIN + RIGHT OUTER JOIN - 중복제거

--직원 정보와, 해당 직원의 관리자 정보 outer join
--직원 번호, 직원이름, 관리자 번호, 관리자 이름

--ansi
--LEFT OUTER JOIN
SELECT a.empno, a.ename, a.mgr, b.ename
FROM emp a LEFT OUTER JOIN emp b ON (a.mgr = b.empno);
--걍 JOIN
SELECT a.empno, a.ename, a.mgr, b.ename
FROM emp a JOIN emp b ON (a.mgr = b.empno);

--oracle outer join (left, right만 존재 fullouter는 지원하지 않음)
SELECT a.empno, a.ename, a.mgr, b.ename
FROM emp a, emp b
WHERE a.mgr = b.empno(+);

--ANSI LEFT OUTER
SELECT a.empno, a.ename, a.mgr, b.ename
FROM emp a LEFT OUTER JOIN emp b ON(a.mgr = b.empno AND b.deptno = 10);

SELECT a.empno, a.ename, a.mgr, b.ename
FROM emp a LEFT OUTER JOIN emp b ON(a.mgr = b.empno)
WHERE a.deptno = 10;

--oracle outer 문법에서는 outer 테이블이되는 모든 컬럼에 (+)를 붙여줘야 outer joing이 정상적으로 동작한다
SELECT *
FROM emp a, emp b
WHERE a.mgr = b.empno(+)
AND b.deptno(+) = 10;

--ANSI RIGHT OUTER
SELECT a.empno, a.ename, a.mgr, b.ename
FROM emp a RIGHT OUTER JOIN emp b ON (a.mgr = b.empno);

--실습 outerjoin1
SELECT BUY_DATE, BUY_PROD, PROD_ID, PROD_NAME, BUY_QTY
FROM buyprod a RIGHT OUTER JOIN prod b
ON (a.buy_prod = b.prod_id AND BUY_DATE = TO_DATE('05/01/25', 'YY/MM/DD'));

--실습 outerjoin2
SELECT '05/01/25' BUY_DATE, BUY_PROD, PROD_ID, PROD_NAME, BUY_QTY
FROM buyprod a , prod b
WHERE a.buy_prod(+) = b.prod_id AND BUY_DATE(+) = TO_DATE('05/01/25', 'YY/MM/DD');

--실습 outerjoin3
SELECT '05/01/25' BUY_DATE, BUY_PROD, PROD_ID, PROD_NAME, NVL(BUY_QTY, 0) BUY_QTY
FROM buyprod a , prod b
WHERE a.buy_prod(+) = b.prod_id AND BUY_DATE(+) = TO_DATE('05/01/25', 'YY/MM/DD');

--실습 outerjoin4
SELECT a.pid, pnm, 1 cid, NVL(day,0) day, NVL(cnt,0) cnt
FROM product a, cycle b
WHERE a.pid = b.pid(+) AND b.cid(+) = 1;

SELECT a.pid, pnm, cid, NVL(day,0) day, NVL(cnt,0) cnt
FROM product a LEFT OUTER JOIN cycle b ON(a.pid = b.pid AND b.cid = 1);

--실습 outerjoin5
SELECT PID, PNM, c.CID, CNM, DAY, CNT
FROM (SELECT a.pid, pnm, 1 cid, NVL(day,0) day, NVL(cnt,0) cnt
    FROM product a, cycle b
    WHERE a.pid = b.pid(+) AND b.cid(+) = 1) c, customer d
WHERE c.cid = d.cid;

--실습 crossjoin1
SELECT CID, CNM, PID, PNM
FROM customer CROSS JOIN product;

--subquery : main쿼리에 속하는 부분 쿼리
--사용되는 위치 : 
-- SELECT - scalar subquery(하나의 행과, 하나의 컬럼만 조회되는 쿼리이어야 한다.)
-- FROM - inline view 
-- WHERE - subquery

-- SCALAR subquery
SELECT empno, ename, SYSDATE now/*현재날짜*/
FROM emp;

SELECT empno, ename, (SELECT SYSDATE FROM dual) now
FROM emp;


SELECT deptno --20
FROM emp
WHERE ename = 'SMITH';

SELECT *
FROM emp
WHERE deptno = 20;

SELECT *
FROM emp
WHERE deptno = (SELECT deptno
                FROM emp
                WHERE ename = 'SMITH');
                

--실습 sub1 평균 급여보다 높은 급여를 받는 직원의 수를 조회하세요
SELECT COUNT(*)
FROM emp
WHERE sal > (SELECT AVG(sal)
            FROM emp);
            
--실습 sub2
SELECT *
FROM emp
WHERE sal > (SELECT AVG(sal)
            FROM emp);
            
SELECT *
FROM emp
WHERE deptno IN (SELECT deptno
                FROM emp
                WHERE ename = 'SMITH' OR ename = 'WARD');