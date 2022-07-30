CREATE OR REPLACE FUNCTION GET_IDS_AND_ISOLATION_LEVEL
RETURN NVARCHAR2
IS    
session_id NUMBER(10);
session_sn NUMBER(10);
session_isolation_level NVARCHAR2(150);
BEGIN
SELECT  "session".sid AS "session_id",
        "session".serial# AS "session_sn",
        CASE BITAND("transaction".flag, POWER(2,28))
            WHEN 0 THEN 'READ COMMITTED'
        ELSE 'SERIALIZABLE'
        END AS "session_isolation_level"
INTO    session_id,
        session_sn,
        session_isolation_level
FROM v$transaction "transaction"
    JOIN v$session "session"
        ON  "transaction".addr = "session".taddr
        AND "session".sid = SYS_CONTEXT('USERENV', 'SID');

RETURN 'ID = ' || session_id || ', SN = ' || session_sn || ', in ' 
|| session_isolation_level;
END;


CREATE FUNCTION GET_CT RETURN NVARCHAR2
IS 
BEGIN 
RETURN TO_CHAR(SYSTIMESTAMP,'HH24:MI:SS.FF');
END;

SELECT GET_CT FROM DUAL;
SELECT GET_IDS_AND_ISOLATION_LEVEL FROM DUAL;

        
