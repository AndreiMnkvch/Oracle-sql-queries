CREATE OR REPLACE PROCEDURE TEST_INSERT_SPEED(records_count IN INT, 
use_autocommit IN INT, total_time OUT NVARCHAR2)
AS 
counter INT := 0; 
start_time TIMESTAMP; 
finish_time TIMESTAMP; 
diff_time INTERVAL DAY TO SECOND; 
BEGIN
DBMS_OUTPUT.PUT_LINE('Autocommit value = ' || use_autocommit); 
DBMS_OUTPUT.PUT_LINE('Committing previous transaction...'); 
COMMIT;
DBMS_OUTPUT.PUT_LINE('Starting insert of ' || records_count || ' records...');
start_time := CURRENT_TIMESTAMP;
WHILE (counter < records_count)
LOOP
INSERT INTO "subscribers" ("s_name")
VALUES (CONCAT('New subscriber ', (counter + 1)));
IF (use_autocommit = 1) 
THEN
DBMS_OUTPUT.PUT_LINE('Committing small transaction...'); 
COMMIT;
END IF;
counter := counter + 1;
END LOOP;
finish_time := CURRENT_TIMESTAMP;
DBMS_OUTPUT.PUT_LINE('Finished insert of ' || records_count || ' records...');
IF (use_autocommit = 0) 
THEN
DBMS_OUTPUT.PUT_LINE('Committing one big transaction...');
COMMIT;
END IF;
diff_time := finish_time - start_time; 
total_time := TO_CHAR(EXTRACT(hour FROM diff_time)) || ':' || 
TO_CHAR(EXTRACT(minute FROM diff_time)) 
|| ':' || TO_CHAR(EXTRACT(second FROM diff_time ), 'fm00.000000' );
DBMS_OUTPUT.PUT_LINE('Time used: ' || total_time);
END;


DECLARE
t NVARCHAR2(100);
BEGIN TEST_INSERT_SPEED(100000, 1, t);
DBMS_OUTPUT.PUT_LINE('Stored procedure has returned The following value: ' || t);
END;

DELETE FROM "subscribers"
WHERE "s_id">6;