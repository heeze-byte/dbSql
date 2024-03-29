--복습
--실습 where11
--1981/6/1이후 --> 1981년 6월 1일 포함해서
SELECT *
FROM emp
WHERE job='SALESMAN'
OR hiredate >= TO_DATE('19810601', 'YYYYMMDD');

--ROWNUM
SELECT ROWNUM, emp.*
FROM emp;

SELECT ROWNUM, e.*
FROM emp e;

--ROWNUM과 정렬문제
--ORDER BY절은 SELECT 절 이후에 동작
--ROWUM 가상컬럼이 적용되고 나서 정렬되기 때문에
--우리가 원하는대로 첫번째 데이터부터 순차적인 번호 부여가 되지 않는다.
SELECT ROWNUM, e.*
FROM emp e
ORDER BY ename;

--ORDER BY 절을 포함한 인라인 뷰를 구성
--(직원이름으로 정렬 후 ROWNUM)
SELECT ROWNUM, A.*
FROM
    (SELECT e.*
    FROM emp e
    ORDER BY ename) A;
  
--ROWNUM : 1번부터 읽어야 된다
--WHERE절에 ROWNUM값을 중간만 읽는건 불가능
--불가능한 케이스
--WHERE ROWNUM = 2
--WHERE ROWNUM >= 2 

--가능한 케이스
--WHERE ROWNUM = 1
--WHERE ROWNUM <= 2 

    
--페이징 처리를 위한 꼼수 : ROWNUM에 별칭을 부여, 해당 SQL을 인라인뷰로 감싸고 별칭을 통해 페이징 처리
SELECT *
FROM
    (SELECT ROWNUM rn, A.*
    FROM
        (SELECT e.*
        FROM emp e
        ORDER BY ename) A)
WHERE rn BETWEEN 10 AND 14;   

-------------------------------------------------------------------
--CONCAT : 문자열 결합 
--두개의 문자열을 결합하는 함수
SELECT CONCAT('HELLO', ', WORLD') as CONCAT
FROM dual;
--문자열 세개 결합
--SUBSTR : 문자열의 부분 문자열(java : String.substring) 1이상5이하
--LENGTH : 문자열의 길이
--INSTR : 문자열에 특정 문자열이 등장하는 첫번째 인덱스
--LPAD : 문자열에 특정 문자열을 삽입
SELECT CONCAT(CONCAT('HELLO', ','), 'WORLD') as CONCAT,
        SUBSTR('HELLO, WORLD', 0 ,5) substr1,
         SUBSTR('HELLO, WORLD', 1 ,5) substr2,
         LENGTH('HELLO, WORLD') length,
         INSTR('HELLO, WORLD', 'O') instr1,
         --INSTR(문자열, 찾을 문자열, 문자열의 특정 위치 이후 표시)
         INSTR('HELLO, WORLD', 'O', 6) instr2,
         --LPAD(문자열, 전체 문자열길이, 문자열이 전체문자열 길이에 미치지 못할경우 왼쪽에 추가할 문자)
         LPAD('HELLO, WORLD',15,'*') lpad1,
         LPAD('HELLO, WORLD',15) lpad2,         --lapd2, lapd3동일
         LPAD('HELLO, WORLD',15,' ') lpad3,
         RPAD('HELLO, WORLD',15,'*') rpad1,
         --REPLACE(원본문자열, 원본 문자열에서 변경하고자하는 대상 문자열, 변경 문자열) . 중첩가능
         REPLACE(REPLACE('HELLO, WORLD','HELLO','hello'), 'WORLD', 'world') replace,
         TRIM('  HELLO, WORLD  ') trim,
         TRIM('H' FROM 'HELLO, WORLD') trim2
FROM dual;

--숫자함수 (별로안중요)
--ROUND(대상숫자, 반올림 결과 자리수) 
SELECT ROUND(105.54, 1) r1,   --소수점 둘째자리에서 반올림 (105.5)
       ROUND(105.55, 1) r2, 
       ROUND(105.55, 0) r3,   --소수점 첫째 자리에서 반올림 (106)
       ROUND(105.55, -1) r4   --정수 첫째 자리에서 반올림 (110)
FROM dual;

--TRUNC
SELECT TRUNC(105.54, 1) T1,   --소수점 둘째자리에서 절삭 105.5
       TRUNC(105.55, 1) T2, 
       TRUNC(105.55, 0) T3,   --소수점 첫째 자리에서 절삭 105
       TRUNC(105.55, -1) T4   --정수 첫째 자리에서 절삭 100
FROM dual;

--MOD연산(많이 씀)
SELECT empno, ename, sal, sal/1000, /*ROUND(sal/1000, 0) qutient,*/ MOD(sal, 1000) reminder
FROM emp;


-- SYSDATE : 오라클이 설치된 서버의 현재 날짜 + 시간정보를 리턴
-- 별도의 인자가 없는 함수

--TO_CHAR : DATE타입을 문자열로 변환
--날짜를 문자열로 변환시에 포맷을 지정
--YYYY/MM/DD HH24:MI:SS 외우기
SELECT TO_CHAR (SYSDATE, 'YYYY/MM/DD HH24:MI:SS'),
       TO_CHAR (SYSDATE + (1/24/60)*30 , 'YYYY/MM/DD HH24:MI:SS')    -- (+30분)
FROM dual;

--실습fn1
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
--년도 : YYYY, YY, RRRR, RR : 두자일때랑 4자일때랑 다름
-- RR : 50보다 클 경우 앞자리는 19, 50보다 작을경우 앞자리는 20  
--YYYY, RRRR은 동일
--가급적이면 명시적으로 표현. RRRR로 쓰자~
-- D : 요일을 숫자로 표기(일요일:1, 월요일:2, 화요일:3.....토요일:7)
-- IW : 오늘이 1년중 몇주차에 해당하는지 주차 표기
--피티 format외우기
SELECT TO_CHAR(TO_DATE('35/03/01','RR/MM/DD'),'YYYY/MM/DD') r1,
       TO_CHAR(TO_DATE('55/03/01','RR/MM/DD'),'YYYY/MM/DD') r2,    
       TO_CHAR(TO_DATE('35/03/01','YY/MM/DD'),'YYYY/MM/DD') y1,
       TO_CHAR(SYSDATE, 'D') d, --오늘은 월요일:2
       TO_CHAR(SYSDATE, 'IW') iw, 
       TO_CHAR(TO_DATE('20191229','YYYYMMDD'),'IW') this_year
FROM dual;  

--fn2
SELECT TO_CHAR(SYSDATE, 'YYY-MM-DD') DT_DASH,
       TO_CHAR(SYSDATE,  'YYYY-MM-DD HH24:MI:SS') DT_DASH_WIDTH_TIME,
       TO_CHAR(SYSDATE, 'DD-MM-YYYY') DT_DD_MM_YYYY
FROM dual;

--날짜의 반올림(ROUND), 절삭(TRUNC)
--ROUND(DATE,'포맷')YYYY, MM, DD
desc emp;

SELECT ename, TO_CHAR(hiredate, 'YYYY/MM/DD HH24:MI:SS') as hiredate,
       TO_CHAR(ROUND(hiredate, 'YYYY'), 'YYYY/MM/DD HH24:MI:SS') as round_yyyy,  --월자리에서 반올림
       TO_CHAR(ROUND(hiredate, 'MM'), 'YYYY/MM/DD HH24:MI:SS') as round_MM,  --일자리에서 반올림
       TO_CHAR(ROUND(hiredate, 'DD'), 'YYYY/MM/DD HH24:MI:SS') as round_DD,
       TO_CHAR(ROUND(hiredate-2, 'MM'), 'YYYY/MM/DD HH24:MI:SS') as round_MM
FROM emp
WHERE ename = 'SMITH';

SELECT ename, TO_CHAR(hiredate, 'YYYY/MM/DD HH24:MI:SS') as hiredate,
        TO_CHAR(TRUNC(hiredate, 'YYYY'), 'YYYY/MM/DD HH24:MI:SS') as trunc_yyyy,  --월자리에서 반올림
        TO_CHAR(TRUNC(hiredate, 'MM'), 'YYYY/MM/DD HH24:MI:SS') as trunc_MM,  --일자리에서 반올림
        TO_CHAR(TRUNC(hiredate, 'DD'), 'YYYY/MM/DD HH24:MI:SS') as trunc_DD,
        TO_CHAR(TRUNC(hiredate-2, 'MM'), 'YYYY/MM/DD HH24:MI:SS') as trunc_MM
FROM emp
WHERE ename = 'SMITH';

--Function(date)날짜조작 중요.
--날짜 연산 함수
--MONTHS_BETWEEN(DATE, DATE) :두 날짜 사이의 개월 수
--19801217~20191104-->20191117
SELECT ename, TO_CHAR(hiredate, 'YYYY/MM/DD HH24:MI:SS') hiredate,
        MONTHS_BETWEEN(SYSDATE, hiredate) months_between,
        MONTHS_BETWEEN(TO_DATE('20191117','YYYYMMDD'), hiredate) months_between
FROM emp
WHERE ename='SMITH';

--ADD_MONTH(DATE, 개월수) : DATE에 개월수가 지난 날짜 *****
--개월수가 양수일경우 미래, 음수일경우 과거
SELECT ename, 
        TO_CHAR(hiredate, 'YYYY/MM/DD HH24:MI:SS') hiredate,
        ADD_MONTHS(hiredate, 467) as add_month,
        ADD_MONTHS(hiredate, -467) as add_month
FROM emp
WHERE ename='SMITH';

--NEXT_DAY(DATE, 요일) : DATE이후 첫번째 요일의 날짜
SELECT SYSDATE, 
       NEXT_DAY(SYSDATE, 7) as first_sat, --오늘 날짜 이후 첫 토요일 일자
       NEXT_DAY(SYSDATE, '토요일') as first_sat --안될수도있음
FROM dual;

--LAST_DAY(DATE)해당 날짜가 속한 월의 마지막 일자
SELECT SYSDATE, LAST_DAY(SYSDATE) as last_day,
        LAST_DAY(ADD_MONTHS(SYSDATE,1)) as last_day_12,
        TO_CHAR(LAST_DAY(ADD_MONTHS(SYSDATE,1)),'DD') as DCNT
FROM dual;

-- DATE + 정수 = DATE (DATE에서 정수만큼 이후의 DATE)
-- D1 + 정수 = D2
-- 양변에서 D2 차감
-- D1 + 정수 - D2 = 0
-- D1 + 정수 = D2
-- 양변에 D1 차감
-- 정수 = D2 - D1
-- 날짜에서 날짜를 빼면 일자가 나온다
SELECT TO_DATE('20191104','YYYYMMDD')-TO_DATE('20191101','YYYYMMDD') D1, -- = 3
        TO_DATE('20191201','YYYYMMDD')-TO_DATE('20191101','YYYYMMDD') D2,   -- 11월의 일수
        -- 201908 : 2019년 8월의 일수 :31 구하기
        ADD_MONTHS(TO_DATE('201908','YYYYMM'),1)-TO_DATE('201908','YYYYMM') D3
FROM dual;