SELECT DEPARTMENT_NAME 
FROM DEPARTMENTS 
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = 100);


----JOIN -------
-- 사원번호가 100인 사원의 이름, 부서명 출력
SELECT FIRST_NAME 
FROM EMPLOYEES WHERE EMPLOYEE_ID = 100;

SELECT  DEPARTMENT_NAME 
FROM DEPARTMENTS WHERE DEPARTMENT_ID =(
	SELECT DEPARTMENT_ID FROM EMPLOYEES 
	WHERE EMPLOYEE_ID=100);
-- 코드가 너무 길어지기 때문에 JOIN을 쓴다---

--EMPLOYEE테이블과 DEPARTMENT테이블을 연결
SELECT E.FIRST_NAME , D.DEPARTMENT_NAME, D.DEPARTMENT_ID 
FROM EMPLOYEES E
	INNER JOIN
	DEPARTMENTS D 
	ON (E.DEPARTMENT_ID = D.DEPARTMENT_ID )
WHERE E.EMPLOYEE_ID = 100;
 -- =--
SELECT E.FIRST_NAME , D.DEPARTMENT_NAME, D.DEPARTMENT_ID 
FROM EMPLOYEES E
	INNER JOIN
	DEPARTMENTS D 
	ON (E.DEPARTMENT_ID = D.DEPARTMENT_ID AND E.EMPLOYEE_ID  = 100 );

SELECT E.FIRST_NAME , D.DEPARTMENT_NAME, DEPARTMENT_ID 
FROM EMPLOYEES E
	NATURAL JOIN
	DEPARTMENTS D 
	


-- 부서번호가 30번인 부서에 근무하는 사원의 정보(이름,월급,부서명,부서아이디,도시명, 나라명, 대록명) 출력
SELECT E.FIRST_NAME , E.SALARY , D.DEPARTMENT_NAME, D.DEPARTMENT_ID, L.CITY, C.COUNTRY_NAME, R.REGION_NAME
FROM EMPLOYEES E
	INNER JOIN
	DEPARTMENTS D
	ON (E.DEPARTMENT_ID = D.DEPARTMENT_ID) 
	INNER JOIN 
	LOCATIONS L
	ON (D.LOCATION_ID = L.LOCATION_ID)
	INNER JOIN
	COUNTRIES C
	ON (L.COUNTRY_ID = C.COUNTRY_ID)
	INNER JOIN 
	REGIONS R 
	ON (C.REGION_ID = R.REGION_ID)
WHERE D.DEPARTMENT_ID  = 30;

---- USING
-- JOIN 조건 중 컬럼명이 같을 경우 사용 
-- USING에 사용한 컬럼명은 사용시 테이블명의 식별자를 사용하지 않는다
SELECT E.FIRST_NAME , D.DEPARTMENT_NAME , DEPARTMENT_ID 
FROM EMPLOYEES E
	INNER JOIN
	DEPARTMENTS D 
	USING(DEPARTMENT_ID)
WHERE E.EMPLOYEE_ID = 100;	

SELECT E.FIRST_NAME , D.DEPARTMENT_NAME , DEPARTMENT_ID 
FROM EMPLOYEES E
	INNER JOIN
	DEPARTMENTS D 
	USING(DEPARTMENT_ID AND E.EMPLOYEE_ID = 100); --USING에서는 AND를 사용할 수 없다


----
-- 30번 부서에 근무하는 사원들 중 가장 월급이 많은 사원의 월급보다 많이 받는 사원들의
-- 이름, 월급, 부서명, 도시명을 출력

SELECT E.FIRST_NAME , E.SALARY , D.DEPARTMENT_NAME, LOCATION_ID
FROM EMPLOYEES E
	INNER JOIN
	DEPARTMENTS D 
	USING (DEPARTMENT_ID)
	INNER JOIN
	LOCATIONS L 
	USING (LOCATION_ID)
WHERE E.SALARY > (SELECT MAX(SALARY) FROM EMPLOYEES WHERE DEPARTMENT_ID= 30);

-- 사원들의 이름, 월급, 입사일, 메니저의 이름, 메니저의 월급, 메니저의 입사일
--SELF JOIN
SELECT E.FIRST_NAME , E.SALARY , E.HIRE_DATE , E2.FIRST_NAME , E2.SALARY , E2.HIRE_DATE 
FROM EMPLOYEES E
	INNER JOIN
	EMPLOYEES E2
	ON (E.MANAGER_ID = E2.EMPLOYEE_ID)	;
	
-- 부서명, 부서관리자의 이름, 월급, 입사일
SELECT * FROM DEPARTMENTS;
SELECT D.DEPARTMENT_NAME , E.FIRST_NAME , E.SALARY , E.HIRE_DATE 
FROM DEPARTMENTS D LEFT OUTER JOIN EMPLOYEES E
	ON (D.DEPARTMENT_ID = E.EMPLOYEE_ID);
-- 조건식이 FALSE여도 데이터를 뵤어주고 싶을 때 OUTER JOIN을 쓰는데
-- 데이터가 있는 쪽으로 LEFT, RIGHT를 써줌	
-- 번갈아가면서 데이터가 있고 없으면 FULL사용

SELECT * FROM EMPLOYEES ;
SELECT * FROM JOBS;

-- 최소급여가 8200, 최대급여 16000 사이에 속하는 job_title과 사원의 ID, 급여
SELECT E.EMPLOYEE_ID , E.SALARY, J.JOB_TITLE  
FROM EMPLOYEES E
	INNER JOIN
	JOBS J
	ON E.SALARY BETWEEN 8200 AND 16000;
--공통적인건 없기 때문

SELECT E.FIRST_NAME, D.DEPARTMENT_NAME 
FROM EMPLOYEES E 
INNER JOIN DEPARTMENTS D 
ON (E.DEPARTMENT_ID = D.DEPARTMENT_ID) 
WHERE D.DEPARTMENT_ID  = 30;

