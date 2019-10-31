--���ں� ����
--�μ���ȣ�� 30�� ���� ũ�ų� ���� �μ��� ���� ���� ��ȸ
SELECT *
FROM emp
WHERE deptno >= 30;

--�μ���ȣ�� 30�� ���� ���� �μ��� ���� ���� ��ȸ
SELECT *
FROM emp
WHERE deptno < 30;

--�Ի����ڰ� 1982�� 1�� 1�� ������ ���� ��ȸ
SELECT *
FROM emp
WHERE hiredate >= TO_DATE('19820101', 'YYYYMMDD');
--WHERE hiredate >= TO_DATE('1982/01/01', 'YYYY/MM/DD');

--col BETEEN X AND Y ����
--�÷��� ���� x���� ũ�ų� ����, y���� �۰ų� ���� ������
--�޿�(sal)�� 1000���� ũ�ų� ����, 2000���� �۰ų� ���� �����͸� ��ȸ
SELECT *
FROM emp
WHERE sal between 1000 and 2000;

SELECT *
FROM emp
WHERE sal >= 1000
AND sal <= 2000
AND deptno = 30;

--�ǽ� where1
SELECT ename, hiredate
FROM emp
WHERE hiredate BETWEEN TO_DATE('19820101', 'YYYYMMDD') AND TO_DATE('19830101', 'YYYYMMDD');

--�ǽ� where2
SELECT ename, hiredate
FROM emp
WHERE hiredate >= TO_DATE('19820101', 'YYYYMMDD') AND HIREDATE <= TO_DATE('19830101', 'YYYYMMDD');

--IN ������
--COL IN (values...)
--�μ���ȣ�� 10 Ȥ�� 20�� ���� ��ȸ
SELECT *
FROM emp
WHERE deptno in (10, 20);

--IN �����ڴ� AND/OR �����ڷ� ǥ���� �� �ִ�.
SELECT *
FROM emp
WHERE deptno = 10 OR deptno = 20;

--�ǽ� where3
SELECT USERID ���̵� , USERNM �̸� 
FROM users
WHERE USERID IN ('brown', 'cony', 'sally');

--COL LIKE 'S%'
--COL �� ���� �빮�� s�� �����ϴ� ��� ��
--COL LIKE 'S____'
--COL�� ���� �빮�� s�� �����ϰ� �̾ 4���� ���ڿ��� �����ϴ� ��

--emp ���̺��� �����̸��� s�� �����ϴ� ��� ���� ��ȸ
SELECT *
FROM emp
WHERE ename LIKE 'S%';

SELECT *
FROM emp
WHERE ename LIKE 'S____';

--�ǽ� where4
SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '��%';

--�ǽ� where5
SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '%��%';

--NULL ��
--col IS NULL
--EMP ���̺��� MGR������ ���� ���(NULL) ��ȸ
SELECT *
FROM emp
WHERE mgr IS NULL;

--�Ҽ� �μ��� 10���� �ƴ�������
SELECT *
FROM emp
WHERE deptno != '10';
-- = , !=
-- IS NULL, IS NOT NULL

--�ǽ� where6
SELECT *
FROM emp
WHERE comm IS NOT NULL;

--AND / OR
--������(mgr) ����� 7698�̰� �޿��� 1000 �̻��� ���
SELECT *
FROM emp
WHERE mgr = 7698 AND sal >= 1000;

--emp ���̺��� ������(mgr) ����� 7698�̰ų�
--  �޿�(sal)�� 1000 �̻��� ���� ��ȸ
SELECT *
FROM emp
WHERE mgr = 7698 OR sal >= 1000;

--emp ���̺��� ������(mgr) ����� 7698�� �ƴϰ�, 7839�� �ƴ� ������ ��ȸ
SELECT *
FROM emp
WHERE mgr NOT IN (7698, 7839);

SELECT *
FROM emp
WHERE mgr != 7698 AND mgr != 7839;

--IN, NOT IN �������� NULL ó��
--emp ���̺��� ������(mgr) ����� 7698, 7839 �Ǵ� null�� �ƴ� ������ ��ȸ
SELECT *
FROM emp
WHERE mgr NOT IN(7698,7839) AND mgr IS NOT NULL;
--WHERE mgr NOT IN(7698,7839, NULL); IN�ȿ� NULL������ �ǵ����� ���� ���

--�ǽ� where7
SELECT *
FROM emp
WHERE job = 'SALESMAN' AND hiredate > TO_DATE('19810601', 'YYYYMMDD');

--�ǽ� where8
SELECT *
FROM emp
WHERE deptno != 10 AND hiredate > TO_DATE('19810601', 'YYYYMMDD');

--�ǽ� where9
SELECT *
FROM emp
WHERE deptno NOT IN(10) AND hiredate > TO_DATE('19810601', 'YYYYMMDD');

--�ǽ� where10
SELECT *
FROM emp
WHERE deptno IN(20, 30) AND hiredate > TO_DATE('19810601', 'YYYYMMDD');

--�ǽ� where11
SELECT *
FROM emp
WHERE job = 'SALESMAN' OR hiredate > TO_DATE('19810601', 'YYYYMMDD');

--�ǽ� where12
SELECT *
FROM emp
WHERE job='SALESMAN' OR empno LIKE '78%';

--�ǽ� where13
SELECT *
FROM emp
WHERE job='SALESMAN' OR (empno >= 7800 AND empno <7900);


