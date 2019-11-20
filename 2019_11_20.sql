--GROUPING (cube, rollup ���� ���� �÷�)
--�ش� �÷��� �Ұ� ��꿡 ���� ��� 1
--������ �ʴ� ��� 0

--job �÷� 
--case1. GROUPING(job) = 1, GROUPING(deptno) = 1
--       job --> '�Ѱ�'
--case else
--       job --> job
SELECT CASE WHEN GROUPING(job) = 1 AND GROUPING(deptno) = 1 THEN '�Ѱ�'
            ELSE job
       END job,
       CASE WHEN GROUPING(job) = 0 AND GROUPING(deptno) = 1 THEN job || ' �Ұ�'
            ELSE TO_CHAR(deptno)
       END deptno,
       /*GROUPING(job), GROUPING(deptno),*/ sum(sal) sal
FROM emp
GROUP BY ROLLUP (job, deptno);

--�ǽ� GROUP_AD3
SELECT deptno, job, sum(sal) sal
FROM emp
GROUP BY ROLLUP (deptno, job);

--�ǽ� GROUP_AD4(����)
SELECT dept.dname, job, sum(sal) sal
FROM emp, dept
WHERE emp.deptno = dept.deptno
GROUP BY ROLLUP (dept.dname, job);

--�ǽ� GROUP_AD5(����)
SELECT CASE WHEN GROUPING(dname) = 1 AND GROUPING(job) = 1 THEN '�Ѱ�'
            ELSE dept.dname 
       END dname, job, sum(sal) sal
FROM emp, dept
WHERE emp.deptno = dept.deptno
GROUP BY ROLLUP (dept.dname, job);


-----------------------------------------------------------------------

--CUBE (col1, col2, ...)
--CUBE ���� ������ �÷��� ������ ��� ���տ� ���� ���� �׷����� ����
--CUBE�� ������ �÷��� ���� ���⼺�� ����(rollup���� ����)
--GROUP BY CUBE(job, deptno)
--oo : GROUP BY job, deptno
--ox : GROUP BY job
--ox : GROUP BY deptno
--xx : GROUP BY --��� �����Ϳ� ���ؼ�...

SELECT job, deptno, sum(sal) sal
FROM emp
GROUP BY CUBE (job, deptno);


-----------------------------------------------------------------------
--subquery�� ���� ������Ʈ
DROP TABLE emp_test;

--emp���̺��� �����͸� �����ؼ� ��� �÷��� �̿��Ͽ� emp_test���̺�� ����
CREATE TABLE emp_test AS
SELECT *
FROM emp;

--emp_test ���̺��� dept���̺��� �����ǰ� �ִ� dname �÷�(VARCHAR2(14))�� �߰�
ALTER TABLE emp_test ADD (dname VARCHAR2(14));

SELECT *
FROM emp_test;

--emp_test���̺��� dname �÷��� dept���̺��� dname �÷� ������ ������Ʈ�ϴ�
--���� �ۼ�

UPDATE emp_test SET dname = ( SELECT dname
                              FROM dept
                              WHERE dept.deptno = emp_test.deptno );


--�ǽ� sub_a1
CREATE TABLE dept_test AS
SELECT *
FROM dept;

ALTER TABLE dept_test ADD (empcnt NUMBER(6));

--�����Ѱ�
UPDATE dept_test SET empcnt = ( SELECT a.c
                                FROM (SELECT deptno, COUNT(*) c
                                        FROM emp
                                        GROUP BY deptno) a
                                WHERE a.deptno = dept_test.deptno);
--����
UPDATE dept_test SET empcnt = (SELECT COUNT(*)
                               FROM emp
                               WHERE deptno = dept_test.deptno);

SELECT *
FROM dept_test;


--�ǽ� sub_a2
SELECT *
FROM dept_test;
INSERT INTO dept_test VALUES(98, 'it', 'daejeon', 0);
INSERT INTO dept_test VALUES(99, 'it', 'daejeon', 0);

DELETE FROM dept_test
WHERE NOT EXISTS (SELECT 'X'
                  FROM emp
                  WHERE deptno = dept_test.deptno);

rollback;

--�ǽ� sub_a3
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

--emp, emp_test empno�÷����� ���������� ��ȸ
--1.emp.empno, emp.ename, emp.sal, emp_test.sal
--2.emp.empno, emp.ename, emp.sal, emp_test.sal, �ش���(emp���̺� ����)�� ���� �μ��� �޿����

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
