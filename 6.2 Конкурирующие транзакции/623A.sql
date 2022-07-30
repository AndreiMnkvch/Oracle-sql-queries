CREATE OR REPLACE TRIGGER "upd_sbns_transaction"
AFTER UPDATE 
ON "subscriptions"
    FOR EACH ROW 
        DECLARE 
            isolation_level NVARCHAR2(150);
            trans_id VARCHAR(100);
        BEGIN
            trans_id := DBMS_TRANSACTION.LOCAL_TRANSACTION_ID(FALSE);
            SELECT  CASE BITAND("transaction".flag, POWER(2, 28))
                        WHEN 0 THEN 'READ COMMITTED'
                        ELSE 'SERIALIZABLE'
                    END AS "session_isolation_level"
            INTO isolation_level
            FROM v$transaction "transaction"
                JOIN v$session "session"
                    ON "transaction".addr = "session".taddr
                        AND "session".sid = SYS_CONTEXT('USERENV', 'SID');
            IF ( isolation_level != 'SERIALIZABLE')
                THEN 
                RAISE_APPlICATION_ERROR(-20001, 'Please, switch your transaction
                to SERIALIZABLE isolation level and rerun this UPDATE again.');
            END IF;
        END;
            
                 
