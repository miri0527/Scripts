SELECT * FROM DEPARTMENTS;

SELECT * FROM SEQ;

INSERT INTO DEPARTMENTS (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
VALUES (DEPARTMENTS_SEQ.NEXTVAL, 'IT', 100, 3000);

UPDATE DEPARTMENTS SET MANAGER_ID =200 WHERE DEPARTMENT_ID =120;
UPDATE DEPARTMENTS SET DEPARTMENT_NAME = 'ITTest', MANAGER_ID = NULL
WHERE DEPARTMENT_ID = 290;

DELETE DEPARTMENTS WHERE DEPARTMENT_ID=320;

SELECT * FROM LOCATIONS;

UPDATE LOCATIONS SET STREET_ADDRESS = '400 Va', POSTAL_CODE = 10000 WHERE LOCATION_ID = 1000;



---------------------------------------Function----------------------------------------------------
SELECT 1+1
FROM DUAL;

--SUM
SELECT SALARY , COMMISSION_PCT  FROM EMPLOYEES;
SELECT SUM(SALARY) FROM EMPLOYEES; 

--SELECT SALARY, SUM(SALARY) FROM EMPLOYEES; error
SELECT SUM(SALARY), AVG(SALARY)  
FROM EMPLOYEES

SELECT COUNT(EMPLOYEE_ID)  FROM EMPLOYEES;
SELECT SUM(COMMISSION_PCT),AVG(COMMISSION_PCT),COUNT(COMMISSION_PCT)  FROM EMPLOYEES;
SELECT SUM(COMMISSION_PCT)/COUNT(EMPLOYEE_ID),AVG(COMMISSION_PCT) FROM EMPLOYEES;
SELECT COUNT(EMPLOYEE_ID)  FROM EMPLOYEES; --평균이나 이런건 NULL이 나올 수 없는 기본키로 세기

SELECT MAX(SALARY),MIN(SALARY)  FROM EMPLOYEES; 

SELECT MIN(HIRE_DATE),MAX(HIRE_DATE)  FROM EMPLOYEES;
--SELECT AVG(HIRE_DATE)  FROM EMPLOYEES;
SELECT MAX(LAST_NAME),MIN(LAST_NAME)  FROM EMPLOYEES;

--부서별
--평균 급여, 큰 금액, 적은 금액
--평균 급여가 10000 이상
--MANAGER_ID가 NULL인 사람 제외

SELECT DEPARTMENT_ID,  AVG(SALARY),MAX(SALARY),MIN(SALARY)  
FROM EMPLOYEES
WHERE MANAGER_ID IS NOT NULL
GROUP BY DEPARTMENT_ID --DEPARTMENT_ID로 그룹을 묶을꺼다
HAVING AVG(SALARY) >=10000 --HAVING -> GROUP BY에 조건을 걸 때
ORDER BY 2 DESC;

--메니저별 사원 수
SELECT MANAGER_ID , COUNT(EMPLOYEE_ID) 
FROM EMPLOYEES
--WHERE MANAGER_ID IS NOT NULL
GROUP BY MANAGER_ID
HAVING MANAGER_ID IS NOT NULL; --둘 다 됨

--2.단일 함수
SELECT * FROM DEPARTMENTS;
SELECT DEPARTMENT_NAME , NVL(MANAGER_ID , 200) 
FROM DEPARTMENTS;

SELECT SUM(COMMISSION_PCT) / COUNT(EMPLOYEE_ID), AVG(COMMISSION_PCT),
FROM EMPLOYEES; 

SELECT SUM(COMMISSION_PCT)/COUNT(EMPLOYEE_ID), AVG(NVL(COMMISSION_PCT,0))  
FROM EMPLOYEES;
--함수 안에 함수 호출 가능

SELECT DEPARTMENT_NAME, NVL2(MANAGER_ID, 100,200) 
FROM DEPARTMENTS;

---숫자함수
SELECT ABS(-2.3) FROM DUAL;
SELECT FLOOR(3.723)  FROM DUAL; --소숫점 버리기
SELECT ROUND(35.723,-1) FROM DUAL;  --반올림

SELECT DEPARTMENT_ID, UPPER(DEPARTMENT_NAME)
FROM DEPARTMENTS ;

SELECT RPAD('abc',10,'*') FROM DUAL;
SELECT LPAD('abc',10,'%') FROM DUAL;

--myData
--m*****
SELECT RPAD(SUBSTR('myData',1,1), LENGTH ('myData'), '*') FROM DUAL;
SELECT SUBSTR('mavce', -4, 2 ) FROM DUAL; 

SELECT FIRST_NAME, RPAD(SUBSTR(FIRST_NAME,1,1), LENGTH(FIRST_NAME), '*')FROM EMPLOYEES;

---날짜함수
SELECT SYSDATE , SYSTIMESTAMP , CURRENT_DATE ,CURRENT_TIMESTAMP FROM DUAL;

SELECT SYSDATE , SYSDATE +3 , SYSDATE -2 FROM DUAL;

SELECT ADD_MONTHS(SYSDATE, 5) FROM DUAL;

SELECT FLOOR( MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) || '개월' FROM EMPLOYEES;

SELECT NEXT_DAY(SYSDATE, 4) FROM DUAL; 
SELECT NEXT_DAY(SYSDATE, '수') FROM DUAL;

SELECT LAST_DAY(SYSDATE) FROM DUAL; 

--TO_CHAR
SELECT SYSDATE , TO_CHAR(SYSDATE, 'YYYY/MM/DD DAY') FROM DUAL; 
SELECT TO_CHAR(1234, '9999') FROM DUAL; --4자리인 것을 선언 

--TO_NUMBER
SELECT TO_NUMBER('123')*2 FROM DUAL; 
SELECT TO_NUMBER('1,234','9,999')*2 FROM DUAL;
SELECT TO_NUMBER('1.23')*2 FROM DUAL;

--TO_DATE
SELECT TO_DATE('2022/3/12') FROM DUAL; 

--LAST_NAME King이 근무하는 부서명 -> King이 근무하는 대륙
SELECT DEPARTMENT_ID 
FROM EMPLOYEES
WHERE LAST_NAME='Austin';

SELECT DEPARTMENT_NAME 
FROM DEPARTMENTS
WHERE DEPARTMENT_ID = 90;

SELECT DEPARTMENT_ID, LOCATION_ID 
FROM DEPARTMENTS
WHERE DEPARTMENT_ID = 90;

--
SELECT DEPARTMENT_NAME 
FROM DEPARTMENTS 
WHERE DEPARTMENT_ID = 
	(SELECT DEPARTMENT_ID 
	FROM EMPLOYEES
	WHERE LAST_NAME='Austin');



SELECT  REGION_NAME 
FROM REGIONS
WHERE REGION_ID = (SELECT REGION_ID 
					FROM COUNTRIES
					WHERE COUNTRY_ID = (SELECT COUNTRY_ID 
										FROM LOCATIONS
										WHERE LOCATION_ID = 
												(SELECT LOCATION_ID 
												FROM DEPARTMENTS 
												WHERE DEPARTMENT_ID =
													(SELECT DEPARTMENT_ID 
													FROM EMPLOYEES
													WHERE LAST_NAME='Austin'
													)
												)
										)
					);	
				
				


--도시명이 시에틀에 근무하는 사원들의 정보를 출력

SELECT 
FROM LOCATIONS l  
WHERE CITY  = 'Seattle';

SELECT DEPARTMENT_ID 
FROM DEPARTMENTS
WHERE LOCATION_ID = 1700;

SELECT *
FROM EMPLOYEES 
WHERE DEPARTMENT_ID IN (30,10,90,100,120);

SELECT DEPARTMENT_NAME 
FROM DEPARTMENTS 
WHERE DEPARTMENT_ID = 
(
	SELECT DEPARTMENT_ID 
	FROM EMPLOYEES
	WHERE LAST_NAME = 'Austin'
);

--사원들의 정보 평균 급여보다 많이 받는 사원들의 정보
SELECT * 
FROM EMPLOYEES 
WHERE SALARY > 
(
	SELECT AVG(SALARY)
	FROM EMPLOYEES
);

--First_name john의 관리자의 First_name
SELECT FIRST_NAME 
FROM EMPLOYEES
WHERE EMPLOYEE_ID  = 
(
	SELECT MANAGER_ID  
	FROM EMPLOYEES 
	WHERE FIRST_NAME = 'Lex'
);

--사원들 중에서 급여를 제일 많이 받는 사원과 같은 부서에 근무하는 사람들의 평균급여


SELECT  AVG(SALARY)
FROM EMPLOYEES 
WHERE DEPARTMENT_ID  =
(
	SELECT DEPARTMENT_ID 
	FROM EMPLOYEES
	WHERE SALARY = (SELECT MAX(SALARY) FROM EMPLOYEES)
);


--신입사원 이름, 가장오래된 사윈의 이름
SELECT 
(	SELECT FIRST_NAME  
	FROM EMPLOYEES
	WHERE HIRE_DATE = (SELECT MIN(HIRE_DATE) FROM EMPLOYEES)
),	
	
(
	SELECT LAST_NAME 
	FROM EMPLOYEES
	WHERE HIRE_DATE = (SELECT MIN(HIRE_DATE) FROM EMPLOYEES)
) FROM DUAL;

SELECT * FROM REGIONS; 
INSERT INTO REGIONS (REGION_ID, REGION_NAME)
VALUES ((SELECT MAX(REGION_ID) FROM REGIONS) + 1, 'Space');

SELECT A.SALARY * 2 FROM
(SELECT LAST_NAME , SALARY , DEPARTMENT_ID 
FROM EMPLOYEES ) A;


SELECT DEPARTMENT_NAME 
FROM DEPARTMENTS 
WHERE DEPARTMENT_ID NOT IN (
(
	SELECT DEPARTMENT_ID 
	FROM EMPLOYEES 
	WHERE LAST_NAME = 'King'
));

