


CREATE USER user01 IDENTIFIED BY user01
DEFAULT TABLESPACE USERS;

--권한 주기
GRANT CONNECT, RESOURCE, DBA TO user01;

COMMIT;