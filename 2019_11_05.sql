--��� �Ķ���Ͱ� �־����� �� �ش����� �ϼ��� ���ϴ� ����
--201911->30 / 201912-->31

--�Ѵ� ���� �� �������� ���� = �ϼ�
--��������¥ ���� �� --> DD�� ����
SELECT TO_CHAR(LAST_DAY(TO_DATE('201911','YYYYMM')), 'DD') as day_cnt
FROM dual;

--���ε�( :yyyymm )
SELECT :yyyymm as param, TO_CHAR(LAST_DAY(TO_DATE(:yyyymm,'YYYYMM')), 'DD') as day_cnt
FROM dual;

explain plan for
SELECT *
FROM emp
WHERE empno = '7369';   --���ڿ��� ������ ��������ɶ��� ����
--WHERE TO_CHAR(empno) = '7369';  --���ڷ� ����ȯ. ����ɶ� ����

--sql�����ȹ ����
SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);

--,ǥ��/.�Ҽ���/L,l : ȭ�����
SELECT empno, ename, sal, TO_CHAR(sal, 'L000999,999.99')sal_fmt
FROM emp;

--�߿�. Ȱ�뵵 ����
--function null
--nvl(col1, col1�� null�ϰ�� ��ü�� ��) 
SELECT empno, ename, sal, comm, nvl(comm, 0) nvl_comm,
    sal+comm, 
    sal + nvl(comm,0),
    nvl(sal + comm, 0)
FROM emp;


--nvl2(col1, col1�� null�� �ƴҰ�� ǥ���Ǵ� ��, col1�� null�ϰ�� ǥ�� �Ǵ� ��)
SELECT empno, ename, sal, comm, nvl2(comm, comm, 0)+sal
FROM emp;

--NULLIF(expr1, expr2)
--expr1 == expr2 ������ null (������ null�� ����)
--else : expr1
SELECT empno, ename, sal, comm, NULLIF(sal, 1250)
FROM emp; 

--COALESCE(expr1, expr2, expr3...)
--�Լ� ���� �� null�� �ƴ� ù��° ����
SELECT empno, ename, sal, comm, coalesce(comm, sal) --comm�� null�� �ƴϸ� comm�� ��. comm�� null�̸� sal���̿�
FROM emp;

--null�ǽ� fn4
SELECT empno, ename, mgr, 
        nvl(mgr, 9999) as mgr_n,
        nvl2(mgr, mgr, 9999) mgr_n,
        coalesce(mgr, 9999) mgr_n
FROM emp;

--null �ǽ� fn5
SELECT userid, usernm, reg_dt, nvl(reg_dt, sysdate) as n_reg_dt
from users;

------------------------------------
--***case when
SELECT empno, ename, job, sal,
    case
        when job = 'SALESMAN' then sal*1.05
        when job = 'MANAGER' then sal*1.10
        when job = 'PRESIDENT' then sal*1.20
        else sal
    end as case_sal
FROM emp;

--***decode(col1, search1, return1, search2, return2.... default)
SELECT empno, ename, job, sal,
    DECODE(job, 'SALESMAN', sal*1.05, 
                'MANAGER', sal*1.10, 
                'PRESIDENT', sal*1.20,
                                        sal) as decode_sal
FROM emp;


--condition �ǽ� cond1
SELECT empno, ename,
    DECODE(deptno,  10, 'ACCOUNTING', 
                    20, 'RESEARCH',
                    30, 'SALES',
                    40, 'OPERATIONS', 
                                    'ddit') as dname
FROM emp;

--conditon �ǽ� cond2
SELECT empno, ename, hiredate,
    DECODE( MOD( (To_CHAR(SYSDATE,'YYYY')-TO_CHAR(hiredate,'YYYY')),2) ,0, '�ǰ����� �����',
                                                                            '�ǰ����� ������') as contact_to_doctor
FROM emp;

--���ش� ¦���ΰ�? Ȧ���ΰ�?
--1. ���� �⵵ ���ϱ�(DATE --> TO CHAR(DATE, FORMAT))
SELECT TO_CHAR(SYSDATE,'YYYY'),
--2.���� �⵵�� ¦������ ��� (� ���� 2�� ������ �׻� �������� 2���� �۴�) (2�� ������� �������� 0,1)
       MOD(TO_CHAR(SYSDATE,'YYYY'),2)
FROM dual;

--emp���̺��� �Ի����ڰ� Ȧ�������� ¦�������� Ȯ��
SELECT empno, ename, hiredate, 
        CASE
            WHEN MOD(TO_CHAR(SYSDATE,'YYYY'),2)= MOD(TO_CHAR(hiredate,'YYYY'),2) 
            then '�ǰ����� ���'
            else'�ǰ����� ����'
        END                                                           
FROM emp;

--condition �ǽ� cond3
SELECT userid, usernm, alias, reg_dt,
    case
        when MOD(TO_CHAR(SYSDATE,'YYYY'),2)= MOD(TO_CHAR(reg_dt,'YYYY'),2)
        then '�ǰ����� �����'
        else '�ǰ����� ������'
    end as contacttodoctor
FROM users;

--�׷��Լ�(AVG, MAX, MIN, SUM, COUNT)
--�׷��Լ��� NULL���� ����󿡼� �����Ѵ�
--SUM(comm), COUNT(*), COUNT(mgr)
--������ ���� ���� �޿��� �޴� ��� �޿�
--������ ���� ���� �޿��� �޴� ����� �޿�
--������ �޿����(�Ҽ��� ��°�ڸ������� ������ --> �Ҽ��� 3°�ڸ����� �ݿø�)
--������ �޿���ü��
--������ ����
SELECT MAX(sal) as max_sal, MIN(sal) as min_sal,
       ROUND(AVG(sal),2) as avg_sal,
       SUM(sal) as sum_sal,
       COUNT(*) as emp_cnt, --������� ����
       COUNT(sal) as sal_cnt,
       COUNT(mgr) as mgr_cnt,    --null���� ���꿡 ���Ծȵ�(null�� ���� ���)
       SUM(comm) as comm_sum
FROM emp;

--�μ���(10,20,30) ���� ���� �޿��� �޴� ����� �޿�
--GROUP BY���� ������� ���� �÷��� SELECT���� ����Ǹ� ����. �׷�ȭ�� ���þ��� ������ ���ڿ�, ����� �� �� ���� ex) 'test',1
SELECT deptno, MAX(sal) as max_sal, MIN(sal) as min_sal,  --ename���� ����/ cf. MIN(ename)�� ����,���� �����޿� ���»�����°žƴ�.���þ��� / deptno��� ��
       ROUND(AVG(sal),2) as avg_sal,
       SUM(sal) as sum_sal,
       COUNT(*) as emp_cnt, 
       COUNT(sal) as sal_cnt,
       COUNT(mgr) as mgr_cnt,    
       SUM(comm) as comm_sum
FROM emp
GROUP BY deptno;

--�μ��� �ִ� �޿�
SELECT deptno, MAX(sal) max_sal
FROM emp
--WHERE MAX(sal) > 3000     --���⿡��������.����
GROUP BY deptno
HAVING MAX(sal)>3000;

--group function �ǽ� grp1
SELECT max(sal) max_sal, min(sal) min_sal, 
        round(avg(sal),2) avg_sal, 
        sum(sal) sum_sal, 
        count(sal) count_sal, count(mgr) count_mgr, count(*) count_all
FROM emp;

--group function �ǽ� grp2
SELECT deptno, max(sal) max_sal, min(sal) min_sal, 
        round(avg(sal),2) avg_sal, 
        sum(sal) sum_sal, 
        count(sal) count_sal, count(mgr) count_mgr, count(*) count_all
FROM emp
GROUP BY deptno;

--group function �ǽ� grp3
SELECT DECODE(deptno, 30, 'ACCOUNTING', 20,'RESEARCH', 10, 'SALES') as dname, 
        max(sal) max_sal, min(sal) min_sal, 
        round(avg(sal),2) avg_sal, 
        sum(sal) sum_sal, 
        count(sal) count_sal, count(mgr) count_mgr, count(*) count_all
FROM emp
GROUP BY deptno;

--group function �ǽ� grp4
SELECT TO_CHAR(hiredate,'YYYYMM') as hire_yyyymm, count(sal)
FROM emp
GROUP BY hiredate;

--