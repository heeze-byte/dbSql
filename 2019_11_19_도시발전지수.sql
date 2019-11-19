SELECT *
FROM tax;

SELECT sido, sigungu, round(sal/people, 2) point
FROM tax
ORDER BY sal desc;
ORDER BY point desc;

--시도, 시군구, 버거지수, 시도, 시군구, 연말정산, 납입액
SELECT *
FROM
    (SELECT ROWNUM r, c.*
    FROM
    (SELECT a.sido, a.sigungu , ROUND(a.cnt/b.cnt, 2) cnt
        FROM
            (SELECT sido ,sigungu, COUNT(*) cnt
            FROM fastfood
            WHERE gb IN ('버거킹' ,'맥도날드' ,'KFC')
            GROUP BY sido, sigungu) a,
            (SELECT sido, sigungu, COUNT(*) cnt
            FROM fastfood 
            WHERE gb = '롯데리아'
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