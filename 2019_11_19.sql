--emp_test ���̺� ����
DROP TABLE emp_test;

--multipel insert�� ���� �׽�Ʈ ���̺� ����
--empno, ename �ΰ��� �÷��� ���� emp_test, emp_test2 ���̺���
--emp ���̺�� ���� �����Ѵ� (CTAS)
--�����ʹ� �������� �ʴ´�

CREATE TABLE emp_test AS
SELECT empno, ename
FROM emp
WHERE 1=2;

--INSERT ALL
--�ϳ��� INSERT SQL �������� ���� ���̺� �����͸� �Է�

INSERT ALL
    INTO emp_test
    INTO emp_test2
SELECT 1, 'brown' FROM dual UNION ALL
SELECT 2, 'sally' FROM dual;

SELECT *
FROM emp_test;

--INSERT ALL �÷� ����
ROLLBACK;

INSERT ALL
    INTO emp_test (empno) VALUES (empno)
    INTO emp_test2 VALUES (empno, ename)
SELECT 1 empno, 'brown' ename FROM dual UNION ALL
SELECT 2 empno, 'sally' ename FROM dual;

SELECT *
FROM emp_test;
SELECT *
FROM emp_test2;

--multiple insert (conditional insert)
INSERT ALL
    WHEN empno < 10 THEN
        INTO emp_test (empno) VALUES (empno)
    ELSE --������ ������� ���� ���� ����
        INTO emp_test2 VALUES (empno, ename)
SELECT 20 empno, 'brown' ename FROM dual UNION ALL
SELECT 2 empno, 'sally' ename FROM dual;

SELECT *
FROM emp_test;
SELECT *
FROM emp_test2;


--INSERT FIRST
--���ǿ� �����ϴ� ù��° INSERT ������ ����
INSERT FIRST
    WHEN empno > 10 THEN
        INTO emp_test (empno) VALUES (empno)
    WHEN empno > 5 THEN
        INTO emp_test2 VALUES (empno, ename)
SELECT 20 empno, 'brown' ename FROM dual;

SELECT *
FROM emp_test;
SELECT *
FROM emp_test2;


--MERGE : ���ǿ� �����ϴ� �����Ͱ� ������ UPDATE
--      : ���ǿ� �����ϴ� �����Ͱ� ������ INSERT

--empno�� 7369�� �����͸� emp ���̺�� ���� emp_test���̺� ����(insert)
INSERT INTO emp_test
SELECT empno, ename
FROM emp
WHERE empno=7369;

SELECT *
FROM emp_test;

--emp���̺��� �������� emp_test ���̺��� empno�� ���� ���� ���� �����Ͱ� �������
--emp_test.ename = ename || '_merge' ������ update
--�����Ͱ� ���� ��쿡�� emp_test ���̺� insert
ALTER TABLE emp_test MODIFY(ename VARCHAR2(20));

MERGE INTO emp_test
USING emp
ON (emp.empno = emp_test.empno)
WHEN MATCHED THEN
UPDATE SET ename = emp.ename || 'merge'
WHEN NOT MATCHED THEN
INSERT VALUES(emp.empno, emp.ename);

SELECT *
FROM emp_test;

rollback;

MERGE INTO emp_test
USING dual
 ON (emp_test.empno = 1)
WHEN MATCHED THEN 
 UPDATE set ename = 'brown' || '_merge'         --empno�� 1�� ������ ����
WHEN NOT MATCHED THEN 
 INSERT VALUES (1, 'brown');

SELECT 'X'
FROM emp_test
WHERE empno=1;

UPDATE emp_test set ename = 'brown' || '_merge'
WHERE empno=1;

INSERT INTO emp_test VALUES (1, 'brown');

--�ǽ�GROUP_AD1

SELECT deptno, sum(sal) sal
FROM emp
GROUP BY deptno
UNION ALL
SELECT null, sum(sal) sal
FROM emp
ORDER BY deptno;

--�� ������ ROLLUP���·� ����
SELECT deptno, sum(sal) sal
FROM emp
GROUP BY ROLLUP (deptno);


--rollup
--group by �� ���� �׷��� ����
--GROUP BY ROLLUP ({col,})
--�÷��� �����ʿ������� �����ذ��鼭 ���� ����׷���
--GROUP BY �Ͽ� UNION �� �Ͱ� ����
--ex : GROUP BY ROLLUP (job, deptno)
--     GROUP BY job, deptno
--     UNION
--     GROUP BY job
--     UNION
--     GROUP BY --> �Ѱ�(��� �࿡ ���� �׷��Լ� ����)

SELECT job, deptno, sum(sal) sal
FROM emp
GROUP BY ROLLUP (job, deptno);


--GROUPING SETS (col1, col2...)
--GROUPING SETS �� ������ �׸��� �ϳ��� ����׷����� GROUP BY ���� �̿�ȴ�
--GROUP BY col1
--UNION ALL
--GROUP BY col2

--emp ���̺��� �̿��Ͽ� �μ��� �޿��հ�, ������(job)�� �޿����� ���Ͻÿ�
SELECT deptno, null job, sum(sal) sal
FROM emp
GROUP BY deptno
UNION ALL
SELECT null deptno, job, sum(sal) sal
FROM emp
GROUP BY job;

--�� ������ GROUPING SETS���·� ����
SELECT job, deptno, sum(sal) sal
FROM emp
GROUP BY GROUPING SETS (job, deptno);
