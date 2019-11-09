--����
--multi row funciton : �������� ���� �Է����� �ϳ��� ��� ���� ����
--SUM, MAX, MIN, AVG, COUNT
--GROUP BY col | express
--SELECT������ GROUP BY���� ����� COL, EXPRESS ǥ�� ����

--������ ���� ���� �޿��� ��ȸ
--14���� ���� �Է����� �� �ϳ��� ����� ����
SELECT MAX(sal) max_sal
FROM emp;

--�μ����� ���� ���� �޿� ��ȸ
SELECT deptno, MAX(sal) max_sal
FROM emp
GROUP BY deptno;

--group function �ǽ� grp3
SELECT DECODE(deptno, 10, 'ACCOUNTING', 
                      20,'RESEARCH', 
                      30, 'SALES',
                      40, 'OPERATIONS',
                                'ddit') as dname, 
        max(sal) max_sal, min(sal) min_sal, 
        round(avg(sal),2) avg_sal, 
        sum(sal) sum_sal, 
        count(sal) count_sal, count(mgr) count_mgr, count(*) count_all
FROM emp
GROUP BY deptno;

--group function �ǽ� grp4
SELECT TO_CHAR(hiredate,'YYYYMM') as hire_yyyymm, count(*) cnt
FROM emp
GROUP BY TO_CHAR(hiredate,'YYYYMM');

--group function �ǽ� grp5
SELECT TO_CHAR(hiredate,'YYYY') as hire_yyyy, count(*) as cnt
FROM emp
GROUP BY TO_CHAR(hiredate,'YYYY')
ORDER BY TO_CHAR(hiredate,'YYYY');

--group function �ǽ� grp6
SELECT count(deptno) as cnt
FROM dept;
-------------------------------------------------------------
--JOIN*****
--emp ���̺��� dname �÷��� ���� --> �μ���ȣ(deptno)�ۿ� ����
desc emp;

--emp���̺� �μ��̸��� ������ �� �ִ� dname �÷� �߰�
ALTER TABLE emp ADD (dname VARCHAR2(14));   --Table EMP�� ����Ǿ����ϴ�.

SELECT *
FROM emp;

--emp���̺� deptno�� ���� dname�߰�
UPDATE emp SET dname = 'ACCOUNTING' WHERE DEPTNO=10;
UPDATE emp SET dname = 'RESEARCH' WHERE DEPTNO=20;
UPDATE emp SET dname = 'SALES' WHERE DEPTNO=30;
COMMIT;

SELECT dname, MAX(sal) max_sal
FROM emp
GROUP BY dname;

--emp���̺� dname �����
ALTER TABLE emp DROP COLUMN DNAME;

SELECT *
FROM emp;

--ansi natural join : �����ϴ� ���̺��� �÷����� ���� �÷��� �������� JOIN
SELECT DEPTNO, ename, DNAME
FROM emp NATURAL JOIN dept;

--ORACLE join
SELECT emp.empno, emp.ENAME, emp.deptno, dept.dname, dept.loc
FROM emp, dept
WHERE emp.deptno = dept.deptno; --������ �����ϰڴ�

SELECT e.empno, e.ENAME, e.deptno, d.dname, d.loc
FROM emp e, dept d              --���̺���� ��Ī��밡��
WHERE e.deptno = d.deptno;

--ANSI JOIN WITH USING
SELECT emp.empno, emp.ename, dept.dname
FROM emp JOIN dept USING (deptno);

--from���� ���� ��� ���̺� ���� (oracle����***)
--where���� �������� ���
--������ ����ϴ� ���� ���൵ �������
SELECT emp.empno, emp.ename, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
  AND emp.job='SALESMAN'; --job�� SALESMAN�� ����� ������� ��ȸ

SELECT emp.empno, emp.ename, dept.dname, emp.job
FROM emp, dept
WHERE emp.job='SALESMAN'
    AND emp.deptno = dept.deptno;   --WHERE���� AND�� ���� �ٲ��� �������
    
--JOIN with ON(�����ڰ� ���� �÷��� on���� ���� ���)
SELECT emp.empno, emp.ename, dept.dname
FROM emp JOIN dept ON (emp.deptno = dept.deptno);


--SELF join : ���� ���̺��� ����
--emp���̺��� mgr ������ �����ϱ� ���ؼ� emp���̺�� ������ �ؾ��Ѵ�.
--a:��������, b:������
--1)ANSI
SELECT a.empno, a.ename, a.mgr, b.empno, b.ename
FROM emp a JOIN emp b ON (a.mgr = b.empno)   
WHERE a.empno between 7369 and 7698;

--2)ORACLE
SELECT a.empno, a.ename, a.mgr, b.empno, b.ename
FROM emp a, emp b
WHERE a.mgr = b.empno
  AND a.empno between 7369 and 7698;

--------------------------------------------------
--non-equijoin (��� ������ �ƴѰ��) �� equlals(=)�� �����ؾ��ϴ°� �ƴ�
--������ �޿� �����??? (sal�� ��grade�� �ش��ϴ���)
SELECT *
FROM salgrade;

SELECT empno, ename, sal
FROM emp;

--1)oracle
SELECT emp.empno, emp.ename, emp.sal, salgrade.*
FROM emp, salgrade
WHERE emp.sal BETWEEN salgrade.losal AND salgrade.hisal;

--2)ansi
SELECT emp.empno, emp.ename, emp.sal, salgrade.*
FROM emp JOIN salgrade ON(emp.sal BETWEEN salgrade.losal AND salgrade.hisal);

--14��. ����ɼ� �ִ� ��� ����
SELECT a.empno, a.ename, a.mgr, b.empno, b.ename
FROM emp a, emp b
WHERE a.empno='7369';

--�ǽ� join0
SELECT  e.empno, e.ename, e.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno
ORDER BY deptno;

--�ǽ� join0_1
SELECT e.empno, e.ename, e.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno
--AND (e.deptno=10 OR e.deptno=30)
  AND e.deptno IN(10, 30)
ORDER BY empno;


desc emp;

SELECT*
FROM dept;