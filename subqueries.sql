-- 1. 부서코드가 노옹철 사원과 같은 소속의 직원 명단 조회하세요.
SELECT 
       E.EMP_NAME
  FROM EMPLOYEE E
 WHERE E.DEPT_CODE = (SELECT E2.DEPT_CODE
                        FROM EMPLOYEE E2
                       WHERE E2.EMP_NAME = '노옹철'
                     );

-- 2. 전 직원의 평균 급여보다 많은 급여를 받고 있는 직원의 사번, 이름, 직급코드, 급여를 조회하세요.
SELECT 
       AVG(E.SALARY)
  FROM EMPLOYEE E;  -- 전 직원의 평균 급여 

SELECT 
       E.EMP_ID
     , E.EMP_NAME
     , E.JOB_CODE
     , E.SALARY
FROM EMPLOYEE E
WHERE E.SALARY >= (SELECT AVG(E2.SALARY)
                     FROM EMPLOYEE E2
                  );
                  
-- 3. 노옹철 사원의 급여보다 많이 받는 직원의 사번, 이름, 부서, 직급, 급여를 조회하세요.
SELECT 
       E.EMP_ID
     , E.EMP_NAME
     , E.DEPT_CODE
     , E.JOB_CODE
     , E.SALARY
FROM EMPLOYEE E
WHERE E.SALARY > (SELECT E2.SALARY
                    FROM EMPLOYEE E2
                   WHERE E2.EMP_NAME = '노옹철'
                 );
                 
-- 4. 가장 적은 급여를 받는 직원의 사번, 이름, 직급, 부서, 급여, 입사일을 조회하세요.
SELECT 
       E.EMP_ID
     , E.EMP_NAME
     , E.DEPT_CODE
     , E.JOB_CODE
     , E.SALARY
     , E.HIRE_DATE
  FROM EMPLOYEE E
 WHERE E.SALARY = (SELECT MIN(E2.SALARY)
                     FROM EMPLOYEE E2
                  );

-- *** 서브쿼리는 SELECT, FROM, WHERE, HAVING, ORDER BY절에도 사용할 수 있다.

-- 5. 부서별 최고 급여를 받는 직원의 이름, 직급, 부서, 급여 조회하세요.
SELECT 
       E.EMP_NAME
     , E.JOB_CODE
     , E.DEPT_CODE
     , E.SALARY
  FROM EMPLOYEE E
 WHERE E.SALARY IN (SELECT MAX(E2.SALARY)
                      FROM EMPLOYEE E2
                     GROUP BY E2.DEPT_CODE  -- 부서별 : group by dept_code 부서별로 그룹화
                   );

-- *** 여기서부터 난이도 극상

-- 6. 관리자에 해당하는 직원에 대한 정보와 관리자가 아닌 직원의 정보를 추출하여 조회하세요.
-- 사번, 이름, 부서명, 직급, '관리자' AS 구분 / '직원' AS 구분
-- HINT!! is not null, union(혹은 then, else), distinct
-- 방법 1
SELECT 
       E.EMP_ID 사번
     , E.EMP_NAME 이름
     , D.DEPT_TITLE 부서명
     , J.JOB_NAME 직급
     , '관리자' AS 구분
  FROM EMPLOYEE E
  LEFT JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
  LEFT JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
 WHERE E.EMP_ID IN (SELECT DISTINCT E2.MANAGER_ID
                      FROM EMPLOYEE E2
                     WHERE E2.MANAGER_ID IS NOT NULL
                   )
 UNION
SELECT E3.EMP_ID 사번
     , E3.EMP_NAME 이름
     , D3.DEPT_TITLE 부서명
     , J3.JOB_NAME 직급
     , '직원' AS 구분
  FROM EMPLOYEE E3
  LEFT JOIN DEPARTMENT D3 ON(E3.DEPT_CODE = D3.DEPT_ID)
  LEFT JOIN JOB J3 ON(E3.JOB_CODE = J3.JOB_CODE)
 WHERE E3.EMP_ID NOT IN (SELECT DISTINCT E4.MANAGER_ID
                           FROM EMPLOYEE E4
                          WHERE E4.MANAGER_ID IS NOT NULL
                        );

-- 방법 2
SELECT 
       E.EMP_ID
     , E.EMP_NAME
     , D.DEPT_TITLE
     , CASE 
         WHEN E.EMP_ID IN (SELECT DISTINCT E2.MANAGER_ID
                             FROM EMPLOYEE E2
                            WHERE E2.MANAGER_ID IS NOT NULL
                        )
         THEN '관리자'
         ELSE '직원'
       END AS 구분
  FROM EMPLOYEE E
  LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID);
  
-- 7. 자기 직급의 평균 급여를 받고 있는 직원의 사번, 이름, 직급코드, 급여를 조회하세요.
-- 단, 급여와 급여 평균은 만원단위로 계산하세요.
-- HINT!! round(컬럼명, -5)
SELECT 
       E.EMP_NAME
     , E.JOB_CODE
     , E.SALARY
  FROM EMPLOYEE E
 WHERE (E.JOB_CODE, E.SALARY) IN (SELECT E2.JOB_CODE
                                       , ROUND(AVG(E2.SALARY), -5)
                                    FROM EMPLOYEE E2
                                   GROUP BY E2.JOB_CODE
                                 );
                                 
-- 8. 퇴사한 여직원과 같은 부서, 같은 직급에 해당하는 사원의 이름, 직급, 부서, 입사일을 조회하세요.
SELECT 
       E.EMP_NAME
     , E.JOB_CODE
     , E.DEPT_CODE
     , E.HIRE_DATE
  FROM EMPLOYEE E
 WHERE (E.DEPT_CODE, E.JOB_CODE) IN (SELECT E2.DEPT_CODE
                                          , E2.JOB_CODE
                                       FROM EMPLOYEE E2
                                      WHERE SUBSTR(E2.EMP_NO, 8, 1) = 2
                                        AND ENT_YN = 'Y'
                                    )
   AND E.EMP_ID NOT IN (SELECT E3.EMP_ID
                          FROM EMPLOYEE E3
                         WHERE SUBSTR(E3.EMP_NO, 8, 1) = 2
                           AND ENT_YN = 'Y'
                       );
                       
-- 9. 급여 평균 3위 안에 드는 부서의 부서 코드와 부서명, 평균급여를 조회하세요.
-- HINT!! limit
SELECT 
       V.DEPT_CODE
     , V.DEPT_TITLE
     , V.평균급여
  FROM (SELECT E.DEPT_CODE
             , D.DEPT_TITLE
             , AVG(E.SALARY) 평균급여
          FROM EMPLOYEE E
          JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
         GROUP BY E.DEPT_CODE, D.DEPT_TITLE
         ORDER BY AVG(E.SALARY) DESC
       ) V
LIMIT 3;

-- 10. 부서별 급여 합계가 전체 급여의 총 합의 20%보다 많은 부서의 부서명과, 부서별 급여 합계를 조회하세요.
SELECT 
       D.DEPT_TITLE
     , SUM(E.SALARY)
  FROM EMPLOYEE E
  JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
 GROUP BY D.DEPT_TITLE
HAVING SUM(E.SALARY) > (SELECT SUM(E2.SALARY) * 0.2
                          FROM EMPLOYEE E2
                       );