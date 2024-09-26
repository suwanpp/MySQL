-- JOIN을 이용하여 여러 테이블을 조회 시에는 모든 컬럼에 테이블 별칭을 사용하는 것이 좋다.

-- 1. 직급이 대리이면서 아시아 지역에 근무하는 직원의 사번, 이름, 직급명, 부서명, 지역명, 급여를 조회하세요
SELECT 
		A.EMP_ID,
        A.EMP_NAME,
        B.JOB_NAME,
        C.DEPT_TITLE,
        D.LOCAL_NAME,
        A.SALARY
  FROM EMPLOYEE A  
  JOIN JOB B ON (A.JOB_CODE = B.JOB_CODE )
  JOIN DEPARTMENT C ON (C.DEPT_ID = A.DEPT_CODE)
  JOIN LOCATION D ON(C.LOCATION_ID = D.LOCAL_CODE)
  WHERE A.JOB_CODE = 'J6' AND D.LOCAL_CODE BETWEEN 'L1' AND 'L3';
  -- WHERE A.JOB_CODE = 'J6' AND (D.LOCAL_CODE = 'L1' OR D.LOCAL_CODE = 'L2' OR D.LOCAL_CODE='L3');

-- 2. 주민번호가 70년대 생이면서 성별이 여자이고, 성이 전씨인 직원의 이름, 주민등록번호, 부서명, 직급명을 조회하세요.
SELECT 
		A.EMP_NAME,
        A.EMP_NO,
        B.DEPT_TITLE,
        C.JOB_NAME
  FROM EMPLOYEE A
  JOIN DEPARTMENT B ON (A.DEPT_CODE = B.DEPT_ID)
  JOIN JOB C ON ( A.JOB_CODE = C.JOB_CODE)
  WHERE A.EMP_NO LIKE '7_____\-2%' AND A.EMP_NAME LIKE '전%';    
-- 3. 이름에 '형'자가 들어가는 직원의 사번, 이름, 직급명을 조회하세요.
SELECT
		A.EMP_ID,
        A.EMP_NAME,
        B.JOB_NAME
 FROM EMPLOYEE A
 JOIN JOB B ON( A.JOB_CODE = B.JOB_CODE)
 WHERE A.EMP_NAME LIKE '%형%';

-- 4. 해외영업팀에 근무하는 직원의 이름, 직급명, 부서코드, 부서명을 조회하세요.
SELECT
		A.EMP_NAME,
        B.JOB_NAME,
        A.DEPT_CODE,
        C.DEPT_TITLE
 FROM EMPLOYEE A
 JOIN JOB B ON( A.JOB_CODE = B.JOB_CODE)
 JOIN DEPARTMENT C ON (A.DEPT_CODE = C.DEPT_ID)
 WHERE C.DEPT_ID BETWEEN 'D5' AND 'D7';
-- 5. 보너스포인트를 받는 직원의 이름, 보너스, 부서명, 지역명을 조회하세요.
SELECT
		A.EMP_NAME,
        A.SALARY,
        B.DEPT_TITLE,
        C.LOCAL_NAME
  FROM EMPLOYEE A
  JOIN DEPARTMENT B ON ( A.DEPT_CODE = B.DEPT_ID)
  JOIN LOCATION C ON (B.LOCATION_ID = C.LOCAL_CODE)
  WHERE A.BONUS IS NOT NULL;
-- 6. 부서코드가 D2인 직원의 이름, 직급명, 부서명, 지역명을 조회하세오.
SELECT 
		A.EMP_NAME,
        B.JOB_NAME,
        C.DEPT_TITLE,
        D.LOCAL_NAME
  FROM EMPLOYEE A
  JOIN JOB B ON( A.JOB_CODE = B.JOB_CODE)
  JOIN DEPARTMENT C ON ( A.DEPT_CODE = C.DEPT_ID)
  JOIN LOCATION D ON ( C.LOCATION_ID = D.LOCAL_CODE)
  WHERE A.DEPT_CODE = 'D2';
-- 7. 한국(KO)과 일본(JP)에 근무하는 직원의 이름, 부서명, 지역명, 국가명을 조회하세요.
SELECT
		A.EMP_NAME,
        B.DEPT_TITLE,
        C.LOCAL_NAME,
        D.NATIONAL_NAME
  FROM EMPLOYEE A
  JOIN DEPARTMENT B ON ( A.DEPT_CODE = B.DEPT_ID)
  JOIN LOCATION C ON ( B.LOCATION_ID = C.LOCAL_CODE)
  JOIN NATION D ON (C.NATIONAL_CODE = D.NATIONAL_CODE)
  WHERE B.LOCATION_ID = 'L1' OR B.LOCATION_ID = 'L2';
     