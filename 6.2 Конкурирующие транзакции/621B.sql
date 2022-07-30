COMMIT;
SELECT SYS_CONTEXT('userenv','sessionid') FROM DUAL; 
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT COUNT(1) AS "returned_books_count" 
FROM "subscriptions" 
WHERE "sb_is_active" = 'N';
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
END 
WHERE MOD("sb_subscriber",2)= 1; 
EXEC DBMS_LOCK.SLEEP(10);
ROLLBACK;