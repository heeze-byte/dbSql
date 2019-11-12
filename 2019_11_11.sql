--SMITH, WARD가 속하는 부서의 직원들 조회
SELECT *
FROM emp
WHERE deptno IN (20, 30);

SELECT *
FROM emp
WHERE deptno = 20
   OR deptno = 30;

SELECT *
FROM emp
WHERE deptno IN (SELECT deptno
               FROM emp
               WHERE ename IN ('SMITH', 'WARD'));

SELECT *
FROM emp
WHERE deptno IN (SELECT deptno
               FROM emp
               WHERE ename IN (:name1, :name2));

--ANY : set 중에 만족하는게 하나라도 있으면 참으로(크기비교)
--SMITH 또는 WARD 보다 적은 급여를 받는 직원 정보 조회
SELECT *
FROM emp
WHERE sal < ANY(SELECT sal  --800, 1250
            FROM emp
            WHERE ename IN ('SMITH', 'WARD'));

--ALL
--SMITH와 WARD보다 급여가 높은 직원 조회
--SMITH보다도 급여가 높고 WARD보다도 급여가 높은사람(AND)
SELECT *
FROM emp
WHERE sal > ALL(SELECT sal  --800, 1250
            FROM emp
            WHERE ename IN ('SMITH', 'WARD'));

--NOT IN
--1. 관리자인 사람만 조회
--mgr 컬럼에 값이 나오는 직원
SELECT *
FROM emp
WHERE empno IN (SELECT mgr
                FROM emp);

SELECT *
FROM emp
WHERE empno NOT IN (SELECT mgr
                    FROM emp
                    WHERE mgr IS NOT NULL);

--pairwise
--사번 7499, 7782인 직원의 관리자, 부서번호 조회
--7698  30
--7839  10
--직원중에 관리자와 부서번호가 (7698, 30)이거나, (7839, 10)인 사람
--mgr, deptno 컬럼을 [동시]에 만족 시키는 직원 정보 조회
SELECT *
FROM emp
WHERE (mgr, deptno) IN (SELECT mgr, deptno
                        FROM emp
                        WHERE empno IN (7499, 7782));

--SCALAR SUBQUERY : SELECT 절에 등장하는 서브 쿼리(단, 값이 하나의 행, 하나의 컬럼)
--직원의 소속 부서명을 JOIN을 사용하지 않고 조회
SELECT empno, ename, deptno, (SELECT dname
                              FROM dept
                              WHERE deptno = emp.deptno) dname
FROM emp;

--sub4 데이터 생성
SELECT *
FROM dept;
INSERT INTO dept VALUES (99, 'ddit', 'daejeon');
COMMIT;

--실습 sub4
SELECT deptno, dname, loc
FROM dept
WHERE deptno NOT IN(SELECT deptno
                    FROM emp);

--실습 sub5
SELECT pid, pnm
FROM product
WHERE pid NOT IN (SELECT pid
                  FROM cycle
                  WHERE cid=1);

--실습 sub6
SELECT cid, pid, day, cnt
FROM cycle
WHERE cid=1 AND pid IN(SELECT pid
                    FROM cycle
                    WHERE cid=2);

--실습 sub7
SELECT a.cid, cnm, a.pid, pnm, day, cnt
FROM(SELECT cid, pid,day, cnt
     FROM cycle
     WHERE cid=1 AND pid IN(SELECT pid
                            FROM cycle
                            WHERE cid=2)) a, customer c, product p
WHERE a.cid = c.cid AND a.pid = p.pid;

--Exists MAIN쿼리의 컬럼을 사용해서 SUBQUERY에 만족하는 조건이 있는지 체크
--만족하는 값이 하나라도 존재하면 더이상 진행하지 않고 멈추기 때문에 성능면에서 유리

--MGR가 존재하는 직원 조회
SELECT *
FROM emp a
WHERE EXISTS (SELECT 'X'
              FROM emp
              WHERE empno = a.mgr);

--MGR가 존재하지 않는 직원 조회
SELECT *
FROM emp a
WHERE NOT EXISTS (SELECT 'X'
                  FROM emp
                  WHERE empno = a.mgr);

--실습 sub8
SELECT *
FROM emp
WHERE mgr IS NOT NULL;

--부서에 소속된 직원이 있는 부서 정보 조회(EXISTS)
SELECT *
FROM dept
WHERE EXISTS (SELECT *
              FROM emp
              WHERE deptno = dept.deptno);

--실습 sub9
SELECT p.pid, pnm
FROM product p
WHERE NOT EXISTS (SELECT *
                  FROM cycle
                  WHERE pid = p.pid AND cid=1);

SELECT p.pid, pnm
FROM product p;


--집합연산
--UNION : 합집합, 중복을 제거
--        DBMS에서는 중복을 제거하기위해 데이터를 정렬
--        (대량의 데이터에 대해 정렬시 부하)
--UNION ALL : UNION과 같은개념
--            중복을 제거하지 않고 위아래 집합을 결합 => 중복가능
--            위아래 집합에 중복되는 데이터가 없다는 것을 확신하면
--            UNION 연산자보다 성능면에서 유리

--사번이 7566 또는 7698인 사원 조회 (사번, 이름)
SELECT empno, ename
FROM EMP
WHERE empno = 7566 OR empno =7698
UNION
--사번이 7369 또는 7499인 사원 조회 (사번, 이름)
SELECT empno, ename
FROM EMP
WHERE empno = 7369 OR empno =7499;


--사번이 7566 또는 7698인 사원 조회 (사번, 이름)
SELECT empno, ename
FROM EMP
WHERE empno = 7566 OR empno =7698
UNION
--사번이 7566 또는 7698인 사원 조회 (사번, 이름)
SELECT empno, ename
FROM EMP
WHERE empno = 7566 OR empno =7698;


--사번이 7566 또는 7698인 사원 조회 (사번, 이름)
SELECT empno, ename
FROM EMP
WHERE empno = 7566 OR empno =7698
UNION ALL
--사번이 7566 또는 7698인 사원 조회 (사번, 이름)
SELECT empno, ename
FROM EMP
WHERE empno = 7566 OR empno =7698;


--INTERSECT(교집합 : 위 아래 집합간 공통 데이터)
--사번이 7566 또는 7698 또는 7369인 사원 조회 (사번, 이름)
SELECT empno, ename
FROM EMP
WHERE empno IN(7566, 7698, 7369)
INTERSECT
--사번이 7566 또는 7698 또는 7499인 사원 조회 (사번, 이름)
SELECT empno, ename
FROM EMP
WHERE empno IN(7566, 7698, 7499);


--MINUS(차집합 : 위 집합에서 아래 집합을 제거)
--사번이 7566 또는 7698 또는 7369인 사원 조회 (사번, 이름)
SELECT empno, ename
FROM EMP
WHERE empno IN(7566, 7698, 7369)
MINUS
--사번이 7566 또는 7698 또는 7499인 사원 조회 (사번, 이름)
SELECT empno, ename
FROM EMP
WHERE empno IN(7566, 7698, 7499);


SELECT *
FROM USER_CONSTRAINTS
WHERE OWNER = 'PC21'
AND TABLE_NAME IN('PROD', 'LPROD')
AND CONSTRAINT_TYPE IN ('P','R');