-- SELECT : ��ȸ�� �÷� ���
--        - ��ü �÷� ��ȸ : *
--        - �Ϻ� �÷� : �ش� �÷��� ���� (,����)
-- FROM : ��ȸ�� ���̺� ���
-- ������ �����ٿ� ����� �ۼ��ص� ��� ����.
-- �� keyword�� �ٿ��� �ۼ�

-- ��� �÷��� ��ȸ
SELECT * FROM prod;

--Ư�� �÷��� ��ȸ
SELECT prod_id, prod_name
FROM prod;

--�ǽ� select1
--1)lprod ���̺��� ��� �����͸� ��ȸ
SELECT *
FROM lprod;

--2)buyer ���̺��� buyer_id, buyer_name �÷��� ��ȸ
SELECT buyer_id, buyer_name
FROM buyer;

--3)cart ���̺��� ��� �����͸� ��ȸ
SELECT *
FROM cart;

--4)member ���̺��� mem_id, mem_pass, mem_name �÷��� ��ȸ
SELECT mem_id, mem_pass, mem_name
FROM member;


-- ������ / ��¥����
-- date type + ���� : ���ڸ� ���Ѵ�.
-- null�� ������ ������ ����� �׻� null�̴�.
SELECT userid, usernm, reg_dt,
        reg_dt+5 reg_dt_after5,
        reg_dt-5 AS reg_dt_before5  --�÷��� �����ٶ� as �ᵵ�ǰ� �Ƚᵵ��
FROM users;

--�ǽ� select2
--1)prod ���̺��� prod_id, prod_name �� �÷��� ��ȸ(��, ��Ī�� id, name)
SELECT prod_id AS id, prod_name AS name
FROM prod;

--2)1prod ���̺��� lprod_gu, lprod_nm �� �÷��� ��ȸ(��, ��Ī�� gu, nm)
SELECT lprod_gu AS gu, lprod_nm AS nm
FROM lprod;

--3)buyer ���̺��� buyer_id, buyer_name �� �÷��� ��ȸ(��, ��Ī�� ���̾���̵�, �̸�)
SELECT buyer_id AS ���̾���̵�, buyer_name �̸�
FROM buyer;

--���ڿ� ����
--�ڹٿ����� + SQL������ ||
--CONCAT(str, str) �Լ�
--users���̺��� userid, usernm
SELECT userid, usernm, userid || usernm, CONCAT(userid, usernm)
FROM users;

--���ڿ� ��� (�÷��� ��� �����Ͱ� �ƴ϶� �����ڰ� ���� �Է��� ���ڿ�)
SELECT '����� ���̵� : ' || userid,
        CONCAT('����� ���̵� : ', userid)
FROM users;

--�ǽ� sel_con1
SELECT table_name
FROM user_tables;

SELECT 'SELECT * FROM ' || table_name || ';' AS QUERY
FROM user_tables;

--desc table
--���̺� ���ǵ� �÷��� �˰� ���� ��
--1.desc
--2.slect* ...
desc emp;

SELECT *
FROM user_tables;

--WHERE��, ���� ������
SELECT 'SELECT * FROM ' || table_name || ';' AS QUERY
FROM user_tables
ORDER BY desc user_tables;