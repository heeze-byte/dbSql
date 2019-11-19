SELECT *
FROM tax;

SELECT sido, sigungu, round(sal/people, 2) point
FROM tax
ORDER BY sal desc;
ORDER BY point desc;

--�õ�, �ñ���, ��������, �õ�, �ñ���, ��������, ���Ծ�
SELECT *
FROM
    (SELECT ROWNUM r, c.*
    FROM
    (SELECT a.sido, a.sigungu , ROUND(a.cnt/b.cnt, 2) cnt
        FROM
            (SELECT sido ,sigungu, COUNT(*) cnt
            FROM fastfood
            WHERE gb IN ('����ŷ' ,'�Ƶ�����' ,'KFC')
            GROUP BY sido, sigungu) a,
            (SELECT sido, sigungu, COUNT(*) cnt
            FROM fastfood 
            WHERE gb = '�Ե�����'
            GROUP BY sido, sigungu) b
        WHERE a.sido = b.sido AND a.sigungu = b.sigungu
        ORDER BY cnt desc) c
    ) e,
    (SELECT ROWNUM r, d.*
    FROM
        (SELECT sido, sigungu, sal
        FROM tax
        ORDER BY sal desc) d
    ) f
WHERE e.r(+) = f.r;