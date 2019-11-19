SELECT *
FROM USER_VIEWS;

SELECT *
FROM ALL_VIEWS
WHERE OWNER = 'PC21';

SELECT *
FROM PC21.V_EMP_DEPT;

--sem �������� ��ȸ������ ���� V_EMP_DEPT view�� hr �������� ��ȸ�ϱ�
--���ؼ��� ������.view�̸� �������� ����� �ؾ��ϳ���
--�Ź� �������� ����ϱ� �������Ƿ� �ó���� ���� �ٸ� ��Ī�� ����

CREATE SYNONYM V_EMP_DEPT FOR PC21.V_EMP_DEPT;

--PC21.V_EMP_DEPT --> V_EMP_DEPT
SELECT *
FROM V_EMP_DEPT;

--�ó�� ����
DROP SYNONYM V_EMP_DEPT;

--hr ���� ��й�ȣ : java
--hr ���� ��й�ȣ ���� : hr
ALTER USER hr IDENTIFIED BY hr;

--dictionary
--���ξ�   : USER : ����� ���� ��ü
--          ALL : ����ڰ� ��밡�� �� ��ü
--          DBA : ������ ������ ��ü ��ü(�Ϲ� ����ڴ� ��� �Ұ�)
--          V$ : �ý��۰� ���õ� view(�Ϲ� ����ڴ� ��� �Ұ�)

SELECT *
FROM USER_TABLES;

SELECT *
FROM ALL_TABLES;

SELECT *
FROM DBA_TABLES
WHERE OWNER IN('PC21', 'HR');

--����Ŭ���� ������ SQL�̶�?
--���ڰ� �ϳ��� Ʋ���� �ȵ�
--���� sql���� ��������� ����� ���� ���� DBMS������
--���� �ٸ� SQL�� �νĵȴ�.
SELECT /*bind_test*/* FROM emp;
Select /*bind_test*/* FROM emp;
Select /*bind_test*/*  FROM emp;

--�̷��� �ϸ� �����ȹ ����, ���ʿ��ϰ� �޸� ���� ���ֱ�����
Select /*bind_test*/*  FROM emp WHERE empno=:empno;

--system�������� ��ȸ
SELECT *
FROM v$SQL
WHERE SQL_TEXT LIKE '%bind_test%';



