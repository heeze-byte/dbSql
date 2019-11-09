--����
--�ǽ� where11
--1981/6/1���� --> 1981�� 6�� 1�� �����ؼ�
SELECT *
FROM emp
WHERE job='SALESMAN'
OR hiredate >= TO_DATE('19810601', 'YYYYMMDD');

--ROWNUM
SELECT ROWNUM, emp.*
FROM emp;

SELECT ROWNUM, e.*
FROM emp e;

--ROWNUM�� ���Ĺ���
--ORDER BY���� SELECT �� ���Ŀ� ����
--ROWUM �����÷��� ����ǰ� ���� ���ĵǱ� ������
--�츮�� ���ϴ´�� ù��° �����ͺ��� �������� ��ȣ �ο��� ���� �ʴ´�.
SELECT ROWNUM, e.*
FROM emp e
ORDER BY ename;

--ORDER BY ���� ������ �ζ��� �並 ����
--(�����̸����� ���� �� ROWNUM)
SELECT ROWNUM, A.*
FROM
    (SELECT e.*
    FROM emp e
    ORDER BY ename) A;
  
--ROWNUM : 1������ �о�� �ȴ�
--WHERE���� ROWNUM���� �߰��� �д°� �Ұ���
--�Ұ����� ���̽�
--WHERE ROWNUM = 2
--WHERE ROWNUM >= 2 

--������ ���̽�
--WHERE ROWNUM = 1
--WHERE ROWNUM <= 2 

    
--����¡ ó���� ���� �ļ� : ROWNUM�� ��Ī�� �ο�, �ش� SQL�� �ζ��κ�� ���ΰ� ��Ī�� ���� ����¡ ó��
SELECT *
FROM
    (SELECT ROWNUM rn, A.*
    FROM
        (SELECT e.*
        FROM emp e
        ORDER BY ename) A)
WHERE rn BETWEEN 10 AND 14;   

-------------------------------------------------------------------
--CONCAT : ���ڿ� ���� 
--�ΰ��� ���ڿ��� �����ϴ� �Լ�
SELECT CONCAT('HELLO', ', WORLD') as CONCAT
FROM dual;
--���ڿ� ���� ����
--SUBSTR : ���ڿ��� �κ� ���ڿ�(java : String.substring) 1�̻�5����
--LENGTH : ���ڿ��� ����
--INSTR : ���ڿ��� Ư�� ���ڿ��� �����ϴ� ù��° �ε���
--LPAD : ���ڿ��� Ư�� ���ڿ��� ����
SELECT CONCAT(CONCAT('HELLO', ','), 'WORLD') as CONCAT,
        SUBSTR('HELLO, WORLD', 0 ,5) substr1,
         SUBSTR('HELLO, WORLD', 1 ,5) substr2,
         LENGTH('HELLO, WORLD') length,
         INSTR('HELLO, WORLD', 'O') instr1,
         --INSTR(���ڿ�, ã�� ���ڿ�, ���ڿ��� Ư�� ��ġ ���� ǥ��)
         INSTR('HELLO, WORLD', 'O', 6) instr2,
         --LPAD(���ڿ�, ��ü ���ڿ�����, ���ڿ��� ��ü���ڿ� ���̿� ��ġ�� ���Ұ�� ���ʿ� �߰��� ����)
         LPAD('HELLO, WORLD',15,'*') lpad1,
         LPAD('HELLO, WORLD',15) lpad2,         --lapd2, lapd3����
         LPAD('HELLO, WORLD',15,' ') lpad3,
         RPAD('HELLO, WORLD',15,'*') rpad1,
         --REPLACE(�������ڿ�, ���� ���ڿ����� �����ϰ����ϴ� ��� ���ڿ�, ���� ���ڿ�) . ��ø����
         REPLACE(REPLACE('HELLO, WORLD','HELLO','hello'), 'WORLD', 'world') replace,
         TRIM('  HELLO, WORLD  ') trim,
         TRIM('H' FROM 'HELLO, WORLD') trim2
FROM dual;

--�����Լ� (���ξ��߿�)
--ROUND(������, �ݿø� ��� �ڸ���) 
SELECT ROUND(105.54, 1) r1,   --�Ҽ��� ��°�ڸ����� �ݿø� (105.5)
       ROUND(105.55, 1) r2, 
       ROUND(105.55, 0) r3,   --�Ҽ��� ù° �ڸ����� �ݿø� (106)
       ROUND(105.55, -1) r4   --���� ù° �ڸ����� �ݿø� (110)
FROM dual;

--TRUNC
SELECT TRUNC(105.54, 1) T1,   --�Ҽ��� ��°�ڸ����� ���� 105.5
       TRUNC(105.55, 1) T2, 
       TRUNC(105.55, 0) T3,   --�Ҽ��� ù° �ڸ����� ���� 105
       TRUNC(105.55, -1) T4   --���� ù° �ڸ����� ���� 100
FROM dual;

--MOD����(���� ��)
SELECT empno, ename, sal, sal/1000, /*ROUND(sal/1000, 0) qutient,*/ MOD(sal, 1000) reminder
FROM emp;


-- SYSDATE : ����Ŭ�� ��ġ�� ������ ���� ��¥ + �ð������� ����
-- ������ ���ڰ� ���� �Լ�

--TO_CHAR : DATEŸ���� ���ڿ��� ��ȯ
--��¥�� ���ڿ��� ��ȯ�ÿ� ������ ����
--YYYY/MM/DD HH24:MI:SS �ܿ��
SELECT TO_CHAR (SYSDATE, 'YYYY/MM/DD HH24:MI:SS'),
       TO_CHAR (SYSDATE + (1/24/60)*30 , 'YYYY/MM/DD HH24:MI:SS')    -- (+30��)
FROM dual;

--�ǽ�fn1
SELECT  TO_DATE('19/12/31','YY/MM/DD') LASTDAY,
        TO_CHAR(TO_DATE('19/12/31','YY/MM/DD')-5) LASTDAY_BEFORE5,
        TO_CHAR(SYSDATE, 'YY/MM/DD') NOW,
        TO_CHAR(SYSDATE-3, 'YY/MM/DD') NOW_BEFORE3
FROM dual;

--fn1
SELECT LASTDAY, LASTDAY-5 AS LASTDAY_BEFORE5,
        NOW, NOW-3 NOW_BEFORE3
FROM 
    (SELECt TO_DATE('19/12/31','YY/MM/DD') LASTDAY,
        SYSDATE NOW
        FROM DUAL);
        
--date format
--�⵵ : YYYY, YY, RRRR, RR : �����϶��� 4���϶��� �ٸ�
-- RR : 50���� Ŭ ��� ���ڸ��� 19, 50���� ������� ���ڸ��� 20  
--YYYY, RRRR�� ����
--�������̸� ��������� ǥ��. RRRR�� ����~
-- D : ������ ���ڷ� ǥ��(�Ͽ���:1, ������:2, ȭ����:3.....�����:7)
-- IW : ������ 1���� �������� �ش��ϴ��� ���� ǥ��
--��Ƽ format�ܿ��
SELECT TO_CHAR(TO_DATE('35/03/01','RR/MM/DD'),'YYYY/MM/DD') r1,
       TO_CHAR(TO_DATE('55/03/01','RR/MM/DD'),'YYYY/MM/DD') r2,    
       TO_CHAR(TO_DATE('35/03/01','YY/MM/DD'),'YYYY/MM/DD') y1,
       TO_CHAR(SYSDATE, 'D') d, --������ ������:2
       TO_CHAR(SYSDATE, 'IW') iw, 
       TO_CHAR(TO_DATE('20191229','YYYYMMDD'),'IW') this_year
FROM dual;  

--fn2
SELECT TO_CHAR(SYSDATE, 'YYY-MM-DD') DT_DASH,
       TO_CHAR(SYSDATE,  'YYYY-MM-DD HH24:MI:SS') DT_DASH_WIDTH_TIME,
       TO_CHAR(SYSDATE, 'DD-MM-YYYY') DT_DD_MM_YYYY
FROM dual;

--��¥�� �ݿø�(ROUND), ����(TRUNC)
--ROUND(DATE,'����')YYYY, MM, DD
desc emp;

SELECT ename, TO_CHAR(hiredate, 'YYYY/MM/DD HH24:MI:SS') as hiredate,
       TO_CHAR(ROUND(hiredate, 'YYYY'), 'YYYY/MM/DD HH24:MI:SS') as round_yyyy,  --���ڸ����� �ݿø�
       TO_CHAR(ROUND(hiredate, 'MM'), 'YYYY/MM/DD HH24:MI:SS') as round_MM,  --���ڸ����� �ݿø�
       TO_CHAR(ROUND(hiredate, 'DD'), 'YYYY/MM/DD HH24:MI:SS') as round_DD,
       TO_CHAR(ROUND(hiredate-2, 'MM'), 'YYYY/MM/DD HH24:MI:SS') as round_MM
FROM emp
WHERE ename = 'SMITH';

SELECT ename, TO_CHAR(hiredate, 'YYYY/MM/DD HH24:MI:SS') as hiredate,
        TO_CHAR(TRUNC(hiredate, 'YYYY'), 'YYYY/MM/DD HH24:MI:SS') as trunc_yyyy,  --���ڸ����� �ݿø�
        TO_CHAR(TRUNC(hiredate, 'MM'), 'YYYY/MM/DD HH24:MI:SS') as trunc_MM,  --���ڸ����� �ݿø�
        TO_CHAR(TRUNC(hiredate, 'DD'), 'YYYY/MM/DD HH24:MI:SS') as trunc_DD,
        TO_CHAR(TRUNC(hiredate-2, 'MM'), 'YYYY/MM/DD HH24:MI:SS') as trunc_MM
FROM emp
WHERE ename = 'SMITH';

--Function(date)��¥���� �߿�.
--��¥ ���� �Լ�
--MONTHS_BETWEEN(DATE, DATE) :�� ��¥ ������ ���� ��
--19801217~20191104-->20191117
SELECT ename, TO_CHAR(hiredate, 'YYYY/MM/DD HH24:MI:SS') hiredate,
        MONTHS_BETWEEN(SYSDATE, hiredate) months_between,
        MONTHS_BETWEEN(TO_DATE('20191117','YYYYMMDD'), hiredate) months_between
FROM emp
WHERE ename='SMITH';

--ADD_MONTH(DATE, ������) : DATE�� �������� ���� ��¥ *****
--�������� ����ϰ�� �̷�, �����ϰ�� ����
SELECT ename, 
        TO_CHAR(hiredate, 'YYYY/MM/DD HH24:MI:SS') hiredate,
        ADD_MONTHS(hiredate, 467) as add_month,
        ADD_MONTHS(hiredate, -467) as add_month
FROM emp
WHERE ename='SMITH';

--NEXT_DAY(DATE, ����) : DATE���� ù��° ������ ��¥
SELECT SYSDATE, 
       NEXT_DAY(SYSDATE, 7) as first_sat, --���� ��¥ ���� ù ����� ����
       NEXT_DAY(SYSDATE, '�����') as first_sat --�ȵɼ�������
FROM dual;

--LAST_DAY(DATE)�ش� ��¥�� ���� ���� ������ ����
SELECT SYSDATE, LAST_DAY(SYSDATE) as last_day,
        LAST_DAY(ADD_MONTHS(SYSDATE,1)) as last_day_12,
        TO_CHAR(LAST_DAY(ADD_MONTHS(SYSDATE,1)),'DD') as DCNT
FROM dual;

-- DATE + ���� = DATE (DATE���� ������ŭ ������ DATE)
-- D1 + ���� = D2
-- �纯���� D2 ����
-- D1 + ���� - D2 = 0
-- D1 + ���� = D2
-- �纯�� D1 ����
-- ���� = D2 - D1
-- ��¥���� ��¥�� ���� ���ڰ� ���´�
SELECT TO_DATE('20191104','YYYYMMDD')-TO_DATE('20191101','YYYYMMDD') D1, -- = 3
        TO_DATE('20191201','YYYYMMDD')-TO_DATE('20191101','YYYYMMDD') D2,   -- 11���� �ϼ�
        -- 201908 : 2019�� 8���� �ϼ� :31 ���ϱ�
        ADD_MONTHS(TO_DATE('201908','YYYYMM'),1)-TO_DATE('201908','YYYYMM') D3
FROM dual;