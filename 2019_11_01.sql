--����
--WHERE
--������
-- �� : =, !=, <>, >=, >, <=, <
-- BETWEEN start AND end
-- IN (set)
-- LIKE 'S%' (% : �ټ��� ���ڿ��� ��Ī, _ : ��Ȯ�� �ѱ��� ��Ī)
-- IS NULL ( != NULL �̰� �ƴ�)
-- AND, OR, NOT,

--emp ���̺��� �Ի����ڰ� 1981�� 6�� 1�Ϻ��� 1986�� 12�� 31�� ���̿� �ִ� ���� ���� ��ȸ
--BTWEEN AND
SELECT *
FROM emp
WHERE hiredate BETWEEN TO_DATE('19810601' ,'YYYYMMDD') AND TO_DATE('19811231' ,'YYYYMMDD');

SELECT *
FROM emp
WHERE hiredate >= TO_DATE('19810601' ,'YYYYMMDD') AND hiredate <= TO_DATE('19811231' ,'YYYYMMDD');

--emp ���̺��� ������(mgr)�� �ִ� ������ ��ȸ
SELECT *
FROM emp
WHERE mgr IS NOT NULL;

----------------------------------------------------------------------------------------------------
--�ǽ� where13
SELECT *
FROM emp
WHERE job='SALESMAN' OR (empno >= 7800 AND empno <7900) OR (empno >= 780 AND empno <790) OR (empno = 78);

SELECT *
FROM emp
WHERE job='SALESMAN' OR (empno LIKE '78%' AND hiredate >= TO_DATE('19810601' ,'YYYYMMDD'));

--order by �÷��� | ��Ī | �÷��ε��� [ASC | DESC]
--order by ������ WHERE�� ������ ���
--ename �������� �������� ����
SELECT *
FROM emp
ORDER BY ename ASC;

--ASC�� �Ⱥٿ��� �� ������ ����
SELECT *
FROM emp
ORDER BY ename;

--�̸�(ename)�� �������� ��������
SELECT *
FROM emp
ORDER BY ename DESC;

--job�� �������� ������������ ����, ���� job�� ���� ���
--���(empno)���� �������� ����
SELECT *
FROM emp
ORDER BY job DESC, empno;

--��Ī���� �����ϱ�
--��� ��ȣ(empno), �����(ename), ����(sal*12) as year_sal
SELECT empno, ename, sal, sal*12 AS year_sal
FROM emp
ORDER BY year_sal;

--SELECT�� �÷� ���� �ε����� ����
SELECT empno, ename, sal, sal*12 AS year_sal
FROM emp
ORDER BY 4;

--�ǽ� orderby1
SELECT *
FROM dept
ORDER BY dname;

SELECT *
FROM dept
ORDER BY loc DESC;

--�ǽ� orderby2
SELECT *
FROM emp
WHERE comm IS NOT NULL
ORDER BY comm DESC, empno;

--�ǽ� orderby3
SELECT *
FROM emp
WHERE mgr IS NOT NULL
ORDER BY job, empno DESC;

--�ǽ� orderby4
SELECT *
FROM emp
WHERE (deptno = 10 OR deptno = 30) AND sal > 1500
ORDER BY ename DESC;

SELECT ROWNUM, empno, ename
FROM emp;

SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM > 10;
--WHERE ROWNUM <=10;

--emp ���̺��� ���(empno), �̸�(ename)�� �޿� �������� �������� �����ϰ�
--���ĵ� ��������� ROWNUM
SELECT empno, ename, sal, ROWNUM
FROM emp
ORDER BY sal;

--�ǽ� row1
SELECT ROWNUM, a.*
FROM
(SELECT empno, ename, sal
FROM emp
ORDER BY sal) a;


SELECT ROWNUM, a.*
FROM
(SELECT empno, ename, sal
FROM emp
ORDER BY sal) a
WHERE ROWNUM <= 10;


--�ǽ� row_2(sal�������� ������ 11~14�� ���)
--�����ϴ� �����Ѱ�
SELECT a.RN, a.empno, a.ename
FROM
(SELECT ROWNUM RN, empno, ename, sal
FROM emp
ORDER BY sal) a
WHERE sal>=2900;

--����
SELECT *
FROM
    (SELECT ROWNUM rn, B.*
    FROM
        (SELECT empno, ename, sal
        FROM emp
        ORDER BY sal) B
    WHERE ROWNUM <= 14)
WHERE rn BETWEEN 11 AND 14;


--FUNCTION
--DUAL ���̺� ��ȸ
SELECT 'HELLO WORLD' as msg
FROM DUAL;

--���ڿ� ��ҹ��� ���� �Լ�
--LOWER, UPPER, INITCAP
SELECT LOWER('Hello, World'), UPPER('Hello, World'), INITCAP('hello, world')
FROM DUAL;

--FUNCTION�� WHERE�������� ��밡��
SELECT *
FROM emp
--WHERE ename = UPPER('smith');
WHERE LOWER(ename) = 'smith';

--������ SQL ĥ������
--1.�º��� �������� ���ƶ�
--�º�(TABLE�� �÷�)�� �����ϰ� �Ǹ� INDEX�� ���������� ������� ����
--Function Based Index -> FBI

--CONCAT : ���ڿ� ���� - �ΰ��� ���ڿ��� �����ϴ� �Լ�
--SUBSTR : ���ڿ��� �κ� ���ڿ� (java : String.substring)
--LENGTH : ���ڿ��� ����
--INSTR : ���ڿ��� Ư�� ���ڿ��� �����ϴ� ù�� ° �ε���
--LPAD : ���ڿ��� Ư�� ���ڿ��� ����
SELECT CONCAT('HELLO', CONCAT(', ','WORLD')) AS CONCAT,
       SUBSTR('HELLO, WORLD', 0, 5) substr1,
       SUBSTR('HELLO, WORLD', 1, 5) substr2,
       LENGTH('HELLO, WORLD') length,
       INSTR('HELLO, WORLD', 'O') instr1,
       INSTR('HELLO, WORLD', 'O', 6) instr2,
       --INSTR(���ڿ�, ã�� ���ڿ�, ���ڿ��� Ư�� ��ġ ���� ǥ��)
       LPAD('HELLO, WORLD', 15, '*') lpad,
       --LAPD(���ڿ�, ��ü ���ڿ�����, ���ڿ��� ��ü���ڿ� ���̿� ��ġ�� �� �� ��� �߰��� ����);
       LPAD('HELLO, WORLD',15,'*') lpad1,
       LPAD('HELLO, WORLD',15) lpad2,
       LPAD('HELLO, WORLD',15,' ') lpad3,
       RPAD('HELLO, WORLD',15,'*') rpad1
FROM dual;