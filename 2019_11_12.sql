--sub7
--1�� ���� �Դ� ������ǰ
--2�� ���� �Դ� ������ǰ���� ����
--���� �߰�
SELECT cycle.cid, customer.cnm, product.pid, day, cnt
FROM cycle, customer, product
WHERE cycle.cid = 1
AND cycle.cid = customer.cid
AND cycle.pid = product.pid
AND cycle.pid IN (SELECT pid FROM cycle WHERE cid=2);

-----------------------------------------------------------------


INSERT INTO emp (empno, ename, job)
VALUES (9999, 'brown', null);

SELECT *
FROM emp
WHERE empno=9999;

rollback;

desc emp;

SELECT *
FROM user_tab_columns
WHERE table_name ='EMP';

1.EMPNO
2.ENAME
3.JOB
4.MGR
5.HIREDATE
6.SAL
7.COMM
8.DEPTNO

INSERT INTO emp
VALUES (9999, 'brown', 'ranger', null, sysdate, 2500, null, 40);

SELECT *
FROM emp;

INSERT INTO emp (empno, ename)
SELECT deptno, dname
FROM dept;

SELECT *
FROM emp;

--UPDATE
-- UPDATE ���̺� SET �÷�=��, �÷�=��....
-- WHERE condition

SELECT *
FROM dept;

UPDATE dept SET dname='���IT', loc='ym'
WHERE deptno=99;

--DELETE ���̺��
--WHERE condition

--�����ȣ�� 9999�� ������ emp ���̺��� ����
DELETE emp
WHERE empno=9999;

--�μ����̺��� �̿��ؼ� emp ���̺� �Է��� 5���� �����͸� ����
--10, 20, 30, 40, 99 --> empno < 100, empno BETWWN 10 AND 99
DELETE emp
WHERE empno <100;

SELECT *
FROM emp
WHERE empno <100;

rollback;

DELETE emp
WHERE empno=9999;


--DDL : AUTO COMMIT, ROLLBACK�� �� �ȴ�.
--CREATE
CREATE TABLE ranger_new(
    ranger_no NUMBER,           --���� Ÿ��
    ranger_name VARCHAR2(50),    --���� : VARCHAR2, CHAR
    reg_dt DATE DEFAULT sysdate --DEFAULT : SYSDATE
);

desc ranger_new;

INSERT INTO ranger_new (ranger_no, ranger_name)
VALUES(1000, 'brown');

SELECT *
FROM ranger_new;
commit;

--��¥ Ÿ�Կ��� Ư�� �ʵ常��������
--ex : sysdate���� �⵵�� ��������
SELECT TO_CHAR(sysdate, 'YYYY')
FROM dual;

SELECT ranger_no, ranger_name, reg_dt, TO_CHAR(reg_dt, 'MM'),
EXTRACT(MONTH FROM reg_dt) mm,
EXTRACT(YEAR FROM reg_dt) year,
EXTRACT(DAY FROM reg_dt) day
FROM ranger_new;

--��������
--DEPT ����ؼ� DEPT_TEST ����
CREATE TABLE dept_test(
    deptno number(2) PRIMARY KEY,   --deptno �÷��� �ĺ��ڷ� ����
    dname varchar2(14),             --�ĺ��ڷ� ������ �Ǹ� ���� �ߺ��� �ɼ� ������, null�� ���� ����.
    loc varchar2(13)
);

desc dept_test;

--primary key �������� Ȯ��
--1.deptno�÷��� null�� �� �� ����.
--2.deptno�÷��� �ߺ��� ���� �� �� ����.

INSERT INTO dept_test(deptno, dname, loc)
VALUES(null, 'ddit', 'daejeon');

rollback;

INSERT INTO dept_test VALUES(1, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES(1, 'ddit2', 'daejeon');

--����� ���� �������Ǹ��� �ο��� primary key
DROP TABLE dept_test;
CREATE TABLE dept_test(
    deptno NUMBER(2) CONSTRAINT PK_DEPT_TEST PRIMARY KEY,
    dname VARCHAR2(14),
    loc VARCHAR2(13)
);

--TABLE CONSTRAINT
DROP TABLE dept_tset;
CREATE TABLE dept_test(
    deptno NUMBER(2),
    dname VARCHAR2(14),
    loc VARCHAR2(13),
    
    CONSTRAINT PK_DEPT_TEST PRIMARY KEY(deptno, dname)
);

INSERT INTO dept_test VALUES(1, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES(1, 'ddit2', 'daejeon');
SELECT *
FROM dept_test;

rollback;

--NOT NULL
DROP TABLE dept_test;
CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR2(14) NOT NULL,
    loc VARCHAR2(13)
);

INSERT INTO dept_test VALUES(1, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES(2, 'ddit', 'daejeon');

SELECT *
FROM dept_test;