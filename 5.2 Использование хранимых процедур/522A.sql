/*
I'm aware that materialised view is better option than cashed table with
corresponding triggers on it.  
To accomplish this task its needed to create a new cashed table 
called "subscriptions_ready_12h" which will be updated by stored
procedure every 12h. 
*/


CREATE TABLE "subscriptions_ready_12h"
(
    "sb_id" NUMBER(10) NOT NULL,
    "sb_subscriber" VARCHAR2(30) NOT NULL,
    "sb_book" VARCHAR2(30) NOT NULL,
    "sb_start" DATE NOT NULL,
    "sb_finish" DATE NOT NULL,
    "sb_is_active" CHAR(1) NOT NULL
    );

    ALTER TABLE  "subscriptions_ready_12h" 
 ADD CONSTRAINT "PK_subscriptions_ready_12h"
	PRIMARY KEY ("sb_id") 
 USING INDEX;
 
ALTER TABLE  "subscriptions_ready_12h" 
MODIFY "sb_book" VARCHAR2(150); 

ALTER TABLE  "subscriptions_ready_12h" 
 ADD CONSTRAINT "check_enum_sbs_ready_12h" CHECK ("sb_is_active" IN ('Y', 'N'));
 
 
INSERT INTO "subscriptions_ready_12h"
SELECT "sb_id",
        "s_name" AS "sb_subscriber",
        "b_name" AS "sb_book",
        "sb_start",
        "sb_finish",
        "sb_is_active"
FROM "subscriptions"
    JOIN "subscribers" ON "sb_subscriber"="s_id"
    JOIN "books" ON "sb_book"="b_id"    
;


CREATE TYPE "sbns_ready_12h_row" AS OBJECT(
"field_a" NUMBER(10),
"field_b" VARCHAR2(150),
"field_c" VARCHAR2(150),
"field_d" DATE,
"field_e" DATE,
"field_f" CHAR);

CREATE TYPE "sbns_ready_12h_table" IS TABLE OF "sbns_ready_12h_row";


CREATE OR REPLACE PROCEDURE UPDATE_SUBSCRIPTIONS_READY_12H
AS 
rows_count NUMBER;
BEGIN   
SELECT COUNT(1) INTO rows_count
FROM ALL_TABLES
WHERE OWNER = USER AND
TABLE_NAME = 'subscriptions_ready_12h';

IF (rows_count=0) 
    THEN
        RAISE_APPLICATION_ERROR(-20111, 'Table ''subscriptions_ready_12h'' is missed');
        RETURN;
END IF;
query_text := (
'SELECT "sb_id",
        "s_name" AS "sb_subscriber",
        "b_name" AS "sb_book",
        "sb_start",
        "sb_finish",
        "sb_is_active"
FROM "subscriptions"
    JOIN "subscribers" ON "sb_subscriber"="s_id"
    JOIN "books" ON "sb_book"="b_id"
    ');
    


EXECUTE UPDATE_SUBSCRIPTIONS_READY_12H


BEGIN 
    DBMS_SCHEDULER.CREATE_JOB(
    JOB_NAME  =>                'update subscriptions_ready_12h',
    JOB_TYPE  =>                'STORED_PROCEDURE',
    JOB_ACTION =>               'UPDATE_SUBSCRIPTIONS_READY_12H',
    START_DATE =>               '09-APR-22 10.00.00 AM',
    REPEAT_INTERVAL =>          'FREQ=HOURLY INTERVAL=1',
    AUTO_DROP       =>          FALSE,
    FOLLOW_DEFAULT_TIMEZONE  => TRUE,
    ENABLED         =>          TRUE);
END;



ALTER TRIGGER"TRG_subscriptions_sb_id" DISABLE;
INSERT INTO "subscriptions"
("sb_id","sb_subscriber","sb_book","sb_start","sb_finish","sb_is_active")
VALUES(500,1,9,TO_DATE('2022-04-09','YYYY-MM-DD'),TO_DATE('2022-04-20','YYYY-MM-DD'),'Y');
