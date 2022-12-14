ALTER SESSION SET ISOLATION_LEVEL = SERIALIZABLE; 
SET TRANSACTION READ WRITE;
SELECT 'Tr A: ' || GET_IDS_AND_ISOLATION_LEVEL FROM DUAL;
SELECT 'Tr A START: ' || GET_CT FROM DUAL;


SELECT 'Tr A SELECT:'  || GET_CT FROM DUAL; 
SELECT "sb_is_active" 
FROM "subscriptions" 
WHERE "sb_id" = 62;        
                        
EXEC DBMS_LOCK.SLEEP(10);

SELECT 'Tr A UPDATE:'  || GET_CT FROM DUAL; 
UPDATE "subscriptions" 
SET "sb_is_active" = 'Y'
WHERE "sb_id" = 62;

SELECT 'Tr A COMMIT: ' || GET_CT FROM DUAL;
COMMIT;

EXEC DBMS_LOCK.SLEEP(10);


SELECT 'Tr A SELECT AFTER1: ' || GET_CT FROM DUAL;
SELECT "sb_is_active" FROM "subscriptions" WHERE "sb_id" = 62;

EXEC DBMS_LOCK.SLEEP(10);

SELECT 'Tr A SELECT AFTER2: ' || GET_CT FROM DUAL;
SELECT "sb_is_active" FROM "subscriptions" WHERE "sb_id" = 62;




-----ANOTHER SESSION AT THE SAME TIME

ALTER SESSION SET ISOLATION_LEVEL = SERIALIZABLE; 
SET TRANSACTION READ WRITE;
SELECT 'Tr B: ' || GET_IDS_AND_ISOLATION_LEVEL FROM DUAL;
SELECT 'Tr B START: ' || GET_CT FROM DUAL;

EXEC DBMS_LOCK.SLEEP(5);

SELECT 'Tr B SELECT:'  || GET_CT FROM DUAL; 
SELECT "sb_is_active" 
FROM "subscriptions" 
WHERE "sb_id" = 62;

EXEC DBMS_LOCK.SLEEP(10);

SELECT 'Tr B UPDATE:'  || GET_CT FROM DUAL; 
UPDATE "subscriptions" 
SET "sb_is_active" = 'N'
WHERE "sb_id" = 62;

SELECT 'Tr A COMMIT: ' || GET_CT FROM DUAL;
COMMIT;


SELECT 'Tr B SELECT AFTER1: ' || GET_CT FROM DUAL;
SELECT "sb_is_active" FROM "subscriptions" WHERE "sb_id" = 62;
EXEC DBMS_LOCK.SLEEP(10);


SELECT 'Tr B UPDATE2:'  || GET_CT FROM DUAL; 
UPDATE "subscriptions" 
SET "sb_is_active" = 'N'
WHERE "sb_id" = 62;

SELECT 'Tr B COMMIT: ' || GET_CT FROM DUAL;
COMMIT;

SELECT 'Tr B SELECT AFTER2: ' || GET_CT FROM DUAL;
SELECT "sb_is_active" FROM "subscriptions" WHERE "sb_id" = 62;

