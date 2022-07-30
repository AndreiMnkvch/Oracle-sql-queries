CREATE OR REPLACE PROCEDURE CREATE_ARREARS
AS
CURSOR curs IS
SELECT "sb_subscriber", "s_name"
FROM "subscriptions"
         JOIN "subscribers" ON "sb_subscriber" = "s_id"
WHERE "sb_is_active"= 'Y' AND "sb_finish" < TRUNC(SYSDATE);
table_found NUMBER(1);

BEGIN
SELECT COUNT(1) INTO table_found
FROM ALL_TABLES
WHERE OWNER = USER 
AND TABLE_NAME = 'arrears';

IF (table_found = 0)
THEN 
EXECUTE IMMEDIATE 
'CREATE TABLE "arrears"
(
"reader_id" NUMBER(10),
"reader_name" VARCHAR2(30)
)';
END IF;

EXECUTE IMMEDIATE 'TRUNCATE TABLE "arrears"';

FOR one_row IN curs
LOOP
EXECUTE IMMEDIATE 'INSERT INTO "arrears" VALUES (''' || one_row."sb_subscriber" ||  ''', ' || one_row."s_name" || ')';
END LOOP;
END;

BEGIN
CREATE_ARREARS;
END;