--���κ���
--���� ��??
--RDBMS�� Ư���� ������ �ߺ��� �ִ� ������ ���踦 �Ѵ�.
--EMP ���̺��� ������ ������ ����, �ش� ������ �Ҽ� �μ�������
--�μ���ȣ�� �����ְ�, �μ���ȣ�� ���� dept ���̺�� ������ ����
--�ش� �μ��� ������ ������ �� �ִ�.

--���� ��ȣ, �����̸�, ������ �Ҽ� �μ���ȣ, �μ��̸�
--emp, dept

SELECT emp.empno, emp.ename, emp.deptno, dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--�μ���ȣ, �μ���, �ش�μ��� �ο���
SELECT e.deptno, dept.dname, cnt
FROM    (SELECT deptno, count(*) cnt
        FROM emp
        GROUP BY DEPTNO) e, dept
WHERE e.deptno = dept.deptno;


--count(col) : col ���� �����ϸ� 1, null�̸� 0
--TOTAL ROW : 14
SELECT COUNT(*), COUNT(EMPNO), COUNT(MGR), COUNT(COMM)
FROM emp;

--OUTER JOIN : ���ο� ���е� ������ �Ǵ� ���̺��� �����ʹ� ��ȸ����� �������� �ϴ� ���� ����
--LEFT OUTER JOIN : JOIN KEYWORD ���ʿ� ��ġ�� ���̺��� ��ȸ ������ �ǵ��� �ϴ� ���� ����
--RIGHT OUTER JOIN : JOIN KEYWORD �����ʿ� ��ġ�� ���̺��� ��ȸ ������ �ǵ��� �ϴ� ���� ����
--FULL OUTER JOIN : LFET OUTER JOIN + RIGHT OUTER JOIN - �ߺ�����

--���� ������, �ش� ������ ������ ���� outer join
--���� ��ȣ, �����̸�, ������ ��ȣ, ������ �̸�

--ansi
--LEFT OUTER JOIN
SELECT a.empno, a.ename, a.mgr, b.ename
FROM emp a LEFT OUTER JOIN emp b ON (a.mgr = b.empno);
--�� JOIN
SELECT a.empno, a.ename, a.mgr, b.ename
FROM emp a JOIN emp b ON (a.mgr = b.empno);

--oracle outer join (left, right�� ���� fullouter�� �������� ����)
SELECT a.empno, a.ename, a.mgr, b.ename
FROM emp a, emp b
WHERE a.mgr = b.empno(+);

--ANSI LEFT OUTER
SELECT a.empno, a.ename, a.mgr, b.ename
FROM emp a LEFT OUTER JOIN emp b ON(a.mgr = b.empno AND b.deptno = 10);

SELECT a.empno, a.ename, a.mgr, b.ename
FROM emp a LEFT OUTER JOIN emp b ON(a.mgr = b.empno)
WHERE a.deptno = 10;

--oracle outer ���������� outer ���̺��̵Ǵ� ��� �÷��� (+)�� �ٿ���� outer joing�� ���������� �����Ѵ�
SELECT *
FROM emp a, emp b
WHERE a.mgr = b.empno(+)
AND b.deptno(+) = 10;

--ANSI RIGHT OUTER
SELECT a.empno, a.ename, a.mgr, b.ename
FROM emp a RIGHT OUTER JOIN emp b ON (a.mgr = b.empno);

--�ǽ� outerjoin1
SELECT BUY_DATE, BUY_PROD, PROD_ID, PROD_NAME, BUY_QTY
FROM buyprod a RIGHT OUTER JOIN prod b
ON (a.buy_prod = b.prod_id AND BUY_DATE = TO_DATE('05/01/25', 'YY/MM/DD'));

--�ǽ� outerjoin2
SELECT '05/01/25' BUY_DATE, BUY_PROD, PROD_ID, PROD_NAME, BUY_QTY
FROM buyprod a , prod b
WHERE a.buy_prod(+) = b.prod_id AND BUY_DATE(+) = TO_DATE('05/01/25', 'YY/MM/DD');

--�ǽ� outerjoin3
SELECT '05/01/25' BUY_DATE, BUY_PROD, PROD_ID, PROD_NAME, NVL(BUY_QTY, 0) BUY_QTY
FROM buyprod a , prod b
WHERE a.buy_prod(+) = b.prod_id AND BUY_DATE(+) = TO_DATE('05/01/25', 'YY/MM/DD');

--�ǽ� outerjoin4
SELECT a.pid, pnm, 1 cid, NVL(day,0) day, NVL(cnt,0) cnt
FROM product a, cycle b
WHERE a.pid = b.pid(+) AND b.cid(+) = 1;

SELECT a.pid, pnm, cid, NVL(day,0) day, NVL(cnt,0) cnt
FROM product a LEFT OUTER JOIN cycle b ON(a.pid = b.pid AND b.cid = 1);

--�ǽ� outerjoin5
SELECT PID, PNM, c.CID, CNM, DAY, CNT
FROM (SELECT a.pid, pnm, 1 cid, NVL(day,0) day, NVL(cnt,0) cnt
    FROM product a, cycle b
    WHERE a.pid = b.pid(+) AND b.cid(+) = 1) c, customer d
WHERE c.cid = d.cid;

--�ǽ� crossjoin1
SELECT CID, CNM, PID, PNM
FROM customer CROSS JOIN product;

--subquery : main������ ���ϴ� �κ� ����
--���Ǵ� ��ġ : 
-- SELECT - scalar subquery(�ϳ��� ���, �ϳ��� �÷��� ��ȸ�Ǵ� �����̾�� �Ѵ�.)
-- FROM - inline view 
-- WHERE - subquery

-- SCALAR subquery
SELECT empno, ename, SYSDATE now/*���糯¥*/
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
                

--�ǽ� sub1 ��� �޿����� ���� �޿��� �޴� ������ ���� ��ȸ�ϼ���
SELECT COUNT(*)
FROM emp
WHERE sal > (SELECT AVG(sal)
            FROM emp);
            
--�ǽ� sub2
SELECT *
FROM emp
WHERE sal > (SELECT AVG(sal)
            FROM emp);
            
SELECT *
FROM emp
WHERE deptno IN (SELECT deptno
                FROM emp
                WHERE ename = 'SMITH' OR ename = 'WARD');