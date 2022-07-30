ALTER SESSION SET ISOLATION_LEVEL = READ COMMITTED;
SET TRANSACTION READ WRITE;
SELECT 'Tr A UPDATE:'  || GET_CT FROM DUAL; 
UPDATE "subscriptions" 
SET "sb_is_active" =    CASE 
                            WHEN "sb_is_active" = 'Y' THEN 'N' 
                            WHEN "sb_is_active" = 'N' THEN 'Y' 
                        END
WHERE "sb_id" = 62;
