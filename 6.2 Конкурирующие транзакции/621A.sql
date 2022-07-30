COMMIT;
SELECT SYS_CONTEXT('userenv','sessionid') FROM DUAL; 
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT COUNT(1) AS "returned_books_count" 
FROM "subscriptions" 
WHERE "sb_is_active" = 'N';
EXEC DBMS_LOCK.SLEEP(10);
COMMIT;


COMMIT; 
SELECT SYS_CONTEXT('userenv','sessionid') FROM DUAL; 
UPDATE "subscriptions"
SET "sb_is_active" = 
CASE 
    WHEN "sb_is_active" = 'Y' 
        THEN 'N'
    WHEN "sb_is_active" = 'N' 
        THEN 'Y' 
END; 
EXEC DBMS_LOCK.SLEEP(10);
COMMIT;