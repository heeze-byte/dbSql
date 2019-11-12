--SMITH, WARD�� ���ϴ� �μ��� ������ ��ȸ
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

--ANY : set �߿� �����ϴ°� �ϳ��� ������ ������(ũ���)
--SMITH �Ǵ� WARD ���� ���� �޿��� �޴� ���� ���� ��ȸ
SELECT *
FROM emp
WHERE sal < ANY(SELECT sal  --800, 1250
            FROM emp
            WHERE ename IN ('SMITH', 'WARD'));

--ALL
--SMITH�� WARD���� �޿��� ���� ���� ��ȸ
--SMITH���ٵ� �޿��� ���� WARD���ٵ� �޿��� �������(AND)
SELECT *
FROM emp
WHERE sal > ALL(SELECT sal  --800, 1250
            FROM emp
            WHERE ename IN ('SMITH', 'WARD'));

--NOT IN
--1. �������� ����� ��ȸ
--mgr �÷��� ���� ������ ����
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
--��� 7499, 7782�� ������ ������, �μ���ȣ ��ȸ
--7698  30
--7839  10
--�����߿� �����ڿ� �μ���ȣ�� (7698, 30)�̰ų�, (7839, 10)�� ���
--mgr, deptno �÷��� [����]�� ���� ��Ű�� ���� ���� ��ȸ
SELECT *
FROM emp
WHERE (mgr, deptno) IN (SELECT mgr, deptno
                        FROM emp
                        WHERE empno IN (7499, 7782));

--SCALAR SUBQUERY : SELECT ���� �����ϴ� ���� ����(��, ���� �ϳ��� ��, �ϳ��� �÷�)
--������ �Ҽ� �μ����� JOIN�� ������� �ʰ� ��ȸ
SELECT empno, ename, deptno, (SELECT dname
                              FROM dept
                              WHERE deptno = emp.deptno) dname
FROM emp;

--sub4 ������ ����
SELECT *
FROM dept;
INSERT INTO dept VALUES (99, 'ddit', 'daejeon');
COMMIT;

--�ǽ� sub4
SELECT deptno, dname, loc
FROM dept
WHERE deptno NOT IN(SELECT deptno
                    FROM emp);

--�ǽ� sub5
SELECT pid, pnm
FROM product
WHERE pid NOT IN (SELECT pid
                  FROM cycle
                  WHERE cid=1);

--�ǽ� sub6
SELECT cid, pid, day, cnt
FROM cycle
WHERE cid=1 AND pid IN(SELECT pid
                    FROM cycle
                    WHERE cid=2);

--�ǽ� sub7
SELECT a.cid, cnm, a.pid, pnm, day, cnt
FROM(SELECT cid, pid,day, cnt
     FROM cycle
     WHERE cid=1 AND pid IN(SELECT pid
                            FROM cycle
                            WHERE cid=2)) a, customer c, product p
WHERE a.cid = c.cid AND a.pid = p.pid;

--Exists MAIN������ �÷��� ����ؼ� SUBQUERY�� �����ϴ� ������ �ִ��� üũ
--�����ϴ� ���� �ϳ��� �����ϸ� ���̻� �������� �ʰ� ���߱� ������ ���ɸ鿡�� ����

--MGR�� �����ϴ� ���� ��ȸ
SELECT *
FROM emp a
WHERE EXISTS (SELECT 'X'
              FROM emp
              WHERE empno = a.mgr);

--MGR�� �������� �ʴ� ���� ��ȸ
SELECT *
FROM emp a
WHERE NOT EXISTS (SELECT 'X'
                  FROM emp
                  WHERE empno = a.mgr);

--�ǽ� sub8
SELECT *
FROM emp
WHERE mgr IS NOT NULL;

--�μ��� �Ҽӵ� ������ �ִ� �μ� ���� ��ȸ(EXISTS)
SELECT *
FROM dept
WHERE EXISTS (SELECT *
              FROM emp
              WHERE deptno = dept.deptno);

--�ǽ� sub9
SELECT p.pid, pnm
FROM product p
WHERE NOT EXISTS (SELECT *
                  FROM cycle
                  WHERE pid = p.pid AND cid=1);

SELECT p.pid, pnm
FROM product p;


--���տ���
--UNION : ������, �ߺ��� ����
--        DBMS������ �ߺ��� �����ϱ����� �����͸� ����
--        (�뷮�� �����Ϳ� ���� ���Ľ� ����)
--UNION ALL : UNION�� ��������
--            �ߺ��� �������� �ʰ� ���Ʒ� ������ ���� => �ߺ�����
--            ���Ʒ� ���տ� �ߺ��Ǵ� �����Ͱ� ���ٴ� ���� Ȯ���ϸ�
--            UNION �����ں��� ���ɸ鿡�� ����

--����� 7566 �Ǵ� 7698�� ��� ��ȸ (���, �̸�)
SELECT empno, ename
FROM EMP
WHERE empno = 7566 OR empno =7698
UNION
--����� 7369 �Ǵ� 7499�� ��� ��ȸ (���, �̸�)
SELECT empno, ename
FROM EMP
WHERE empno = 7369 OR empno =7499;


--����� 7566 �Ǵ� 7698�� ��� ��ȸ (���, �̸�)
SELECT empno, ename
FROM EMP
WHERE empno = 7566 OR empno =7698
UNION
--����� 7566 �Ǵ� 7698�� ��� ��ȸ (���, �̸�)
SELECT empno, ename
FROM EMP
WHERE empno = 7566 OR empno =7698;


--����� 7566 �Ǵ� 7698�� ��� ��ȸ (���, �̸�)
SELECT empno, ename
FROM EMP
WHERE empno = 7566 OR empno =7698
UNION ALL
--����� 7566 �Ǵ� 7698�� ��� ��ȸ (���, �̸�)
SELECT empno, ename
FROM EMP
WHERE empno = 7566 OR empno =7698;


--INTERSECT(������ : �� �Ʒ� ���հ� ���� ������)
--����� 7566 �Ǵ� 7698 �Ǵ� 7369�� ��� ��ȸ (���, �̸�)
SELECT empno, ename
FROM EMP
WHERE empno IN(7566, 7698, 7369)
INTERSECT
--����� 7566 �Ǵ� 7698 �Ǵ� 7499�� ��� ��ȸ (���, �̸�)
SELECT empno, ename
FROM EMP
WHERE empno IN(7566, 7698, 7499);


--MINUS(������ : �� ���տ��� �Ʒ� ������ ����)
--����� 7566 �Ǵ� 7698 �Ǵ� 7369�� ��� ��ȸ (���, �̸�)
SELECT empno, ename
FROM EMP
WHERE empno IN(7566, 7698, 7369)
MINUS
--����� 7566 �Ǵ� 7698 �Ǵ� 7499�� ��� ��ȸ (���, �̸�)
SELECT empno, ename
FROM EMP
WHERE empno IN(7566, 7698, 7499);


SELECT *
FROM USER_CONSTRAINTS
WHERE OWNER = 'PC21'
AND TABLE_NAME IN('PROD', 'LPROD')
AND CONSTRAINT_TYPE IN ('P','R');