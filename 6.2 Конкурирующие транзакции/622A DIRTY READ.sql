ALTER SESSION SET ISOLATION_LEVEL = READ COMMITTED; 
SET TRANSACTION READ WRITE;
SELECT 'Tr A: ' || GET_IDS_AND_ISOLATION_LEVEL FROM DUAL;
SELECT 'Tr A START: ' || GET_CT FROM DUAL;

EXEC DBMS_LOCK.SLEEP(5);

SELECT 'Tr A UPDATE:'  || GET_CT FROM DUAL; 
UPDATE "subscriptions" 
SET "sb_is_active" =    CASE 
                            WHEN "sb_is_active" = 'Y' THEN 'N' 
                            WHEN "sb_is_active" = 'N' THEN 'Y' 
                        END
WHERE "sb_id" = 62;
                        
                        
EXEC DBMS_LOCK.SLEEP(20);

SELECT 'Tr A ROLLBACK: ' || GET_CT FROM DUAL;
ROLLBACK;





---- ANOTHER SESSION AT THE SAME TIME 


ALTER SESSION SET ISOLATION_LEVEL = SERIALIZABLE; 
SET TRANSACTION READ ONLY; 
SELECT 'Tr B: ' || GET_IDS_AND_ISOLATION_LEVEL FROM DUAL; 
SELECT 'Tr B START: ' || GET_CT FROM DUAL;

SELECT 'Tr B SELECT-1: ' || GET_CT FROM DUAL;
SELECT "sb_is_active" 
FROM "subscriptions" 
WHERE "sb_id" = 62;

EXEC DBMS_LOCK.SLEEP(10);

SELECT 'Tr B SELECT-2: ' || GET_CT FROM DUAL;
SELECT "sb_is_active" 
FROM "subscriptions" 
WHERE "sb_id" = 62;

SELECT 'Tr B COMMIT: ' || GET_CT 
FROM DUAL;
COMMIT;

