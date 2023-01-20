SELECT * FROM ALL_USERS;

--사용자 생성,수정,삭제
--권한 설정
--저장소 설정

--사용자 생성
--유저명 hr,패스워드 hr

--1.사용자 생성
CREATE USER hr IDENTIFIED BY hr
DEFAULT TABLESPACE USERS;

--2.권한 부여
GRANT CONNECT, RESOURCE, DBA TO hr;

--3. COMMIT(확인)
COMMIT;

DROP USER hr2;
ROLLBACK; 