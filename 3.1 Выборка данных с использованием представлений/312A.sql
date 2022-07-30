DROP MATERIALIZED VIEW "subscriptions_ready";
CREATE MATERIALIZED VIEW "subscriptions_ready" 
BUILD IMMEDIATE 
REFRESH FORCE 
START WITH (SYSDATE) NEXT (SYSDATE + 1/1440) AS
SELECT  "sb_id", 
        "s_name" AS "sb_subscriber", 
        "b_name" AS "sb_book",
        "sb_start", 
        "sb_finish", 
        "sb_is_active" 
FROM "books" 
    JOIN "subscriptions" 
        ON "b_id" = "sb_book" 
    JOIN "subscribers" 
        ON "sb_subscriber" = "s_id";


INSERT INTO "subscriptions"
            ("sb_subscriber",
            "sb_book",
            "sb_start",
            "sb_finish",
            "sb_is_active")
    VALUES  (  7,
                11,
                TO_DATE('2022-02-23', 'YYYY-MM-DD'),
                TO_DATE('2022-07-23', 'YYYY-MM-DD'),
                'Y')
                
UPDATE "subscriptions"
SET "sb_finish"= TO_DATE('2025-07-23','YYYY-MM-DD')
WHERE "sb_id"= 106

DELETE "subscriptions"
WHERE "sb_id"=105

UPDATE "subscribers"
SET "s_name"=N'Berkutov_upd B.B.'
WHERE "s_id"=7

DELETE "subscribers"
WHERE "s_id"=7
COMMIT; 



SELECT * FROM "subscriptions_ready";