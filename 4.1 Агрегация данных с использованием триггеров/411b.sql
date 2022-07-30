CREATE TABLE "best_averages"
(
   "books_taken" DOUBLE PRECISION NOT NULL, 
   "days_to_read" DOUBLE PRECISION NOT NULL,
   "books_returned" DOUBLE PRECISION NOT NULL
)
TRUNCATE TABLE "best_averages";
    
INSERT INTO         "best_averages"
                   ("books_taken",
                    "days_to_read",
                    "books_returned")
WITH    "20+_group"
AS  (   SELECT "sb_subscriber", COUNT("sb_id")
        FROM "subscriptions"
        WHERE "sb_is_active"= 'N'
        GROUP BY "sb_subscriber"      
        HAVING COUNT("sb_id") > 1
    ),
        "quick_readers"
AS  (   SELECT "sb_subscriber", MAX("sb_finish"-"sb_start") "max_days"
        FROM "subscriptions"
        WHERE "sb_is_active"='N'
        GROUP BY "sb_subscriber"
        HAVING MAX("sb_finish"-"sb_start")<50
    ),
        "sbcrbs_wo_delays"
AS (    SELECT DISTINCT "sb_subscriber"
        FROM "subscriptions"
        WHERE "sb_subscriber" NOT IN (  SELECT DISTINCT "sb_subscriber"
                                        FROM "subscriptions"
                                        WHERE "sb_is_active"='Y' AND
                                            CURRENT_DATE>"sb_finish"
                                        OR "sb_subscriber" NOT IN 
                                            (   SELECT "sb_subscriber"
                                                FROM "subscriptions"
                                                WHERE "sb_is_active"='N'
                                                GROUP BY "sb_subscriber"    
                                            )
                                    )
    )
SELECT          ("active_count"/"subscribers_count") AS "books_taken",
                ("days_sum"/"books_count") AS "days_to_read",
                ("inactive_count"/"subscribers_wo_delays_count") AS "books_returned"
FROM    (   
            SELECT COUNT("sb_id")"active_count"
            FROM "subscriptions"
                JOIN "20+_group"
                    USING("sb_subscriber")
            WHERE "sb_is_active"='Y'
        )"tmp_active_count",
        (   
            SELECT COUNT("sb_subscriber")"subscribers_count"
            FROM "20+_group"
        )"tmp_subscribers_count",
        (
            SELECT SUM("sb_finish"-"sb_start")"days_sum"
            FROM "subscriptions"
                JOIN "quick_readers" USING("sb_subscriber")
            WHERE "sb_is_active"='N'
        )"tmp_days_sum",
        (   
            SELECT COUNT("sb_id")"books_count"
            FROM "subscriptions"
                JOIN "quick_readers" USING("sb_subscriber")
            WHERE "sb_is_active"='N'
        )"tmp_books_count",
        (   
            SELECT COUNT("sb_id")"inactive_count"
            FROM "subscriptions"
                JOIN("sbcrbs_wo_delays") USING("sb_subscriber")
            WHERE "sb_is_active"='N'
        )"tmp_inactive_count",
        (   
            SELECT COUNT("sb_subscriber")"subscribers_wo_delays_count"
            FROM "sbcrbs_wo_delays"
        )"tmp_subscribers_wo_delays_count";
        

CREATE TRIGGER "best_avrgs_on_sbs"
AFTER INSERT OR UPDATE OR DELETE
ON "subscriptions" 
BEGIN 
MERGE INTO "best_averages"
USING 
(
WITH    "20+_group"
AS  (   SELECT "sb_subscriber", COUNT("sb_id")
        FROM "subscriptions"
        WHERE "sb_is_active"= 'N'
        GROUP BY "sb_subscriber"      
        HAVING COUNT("sb_id") > 1
    ),
        "quick_readers"
AS  (   SELECT "sb_subscriber", MAX("sb_finish"-"sb_start") "max_days"
        FROM "subscriptions"
        WHERE "sb_is_active"='N'
        GROUP BY "sb_subscriber"
        HAVING MAX("sb_finish"-"sb_start")<50
    ),
        "sbcrbs_wo_delays"
AS (    SELECT DISTINCT "sb_subscriber"
        FROM "subscriptions"
        WHERE "sb_subscriber" NOT IN (  SELECT DISTINCT "sb_subscriber"
                                        FROM "subscriptions"
                                        WHERE "sb_is_active"='Y' AND
                                            CURRENT_DATE>"sb_finish"
                                        OR "sb_subscriber" NOT IN 
                                            (   SELECT "sb_subscriber"
                                                FROM "subscriptions"
                                                WHERE "sb_is_active"='N'
                                                GROUP BY "sb_subscriber"    
                                            )
                                    )
    )
SELECT          ("active_count"/"subscribers_count") AS "books_taken",
                ("days_sum"/"books_count") AS "days_to_read",
                ("inactive_count"/"subscribers_wo_delays_count") AS "books_returned"
FROM    (   
            SELECT COUNT("sb_id")"active_count"
            FROM "subscriptions"
                JOIN "20+_group"
                    USING("sb_subscriber")
            WHERE "sb_is_active"='Y'
        )"tmp_active_count",
        (   
            SELECT COUNT("sb_subscriber")"subscribers_count"
            FROM "20+_group"
        )"tmp_subscribers_count",
        (
            SELECT SUM("sb_finish"-"sb_start")"days_sum"
            FROM "subscriptions"
                JOIN "quick_readers" USING("sb_subscriber")
            WHERE "sb_is_active"='N'
        )"tmp_days_sum",
        (   
            SELECT COUNT("sb_id")"books_count"
            FROM "subscriptions"
                JOIN "quick_readers" USING("sb_subscriber")
            WHERE "sb_is_active"='N'
        )"tmp_books_count",
        (   
            SELECT COUNT("sb_id")"inactive_count"
            FROM "subscriptions"
                JOIN("sbcrbs_wo_delays") USING("sb_subscriber")
            WHERE "sb_is_active"='N'
        )"tmp_inactive_count",
        (   
            SELECT COUNT("sb_subscriber")"subscribers_wo_delays_count"
            FROM "sbcrbs_wo_delays"
        )"tmp_subscribers_wo_delays_count"
        
)"tmp" ON (1=1)
WHEN MATCHED THEN UPDATE 
SET     "best_averages"."books_taken" = "tmp"."books_taken",
        "best_averages"."days_to_read" = "tmp"."days_to_read",
        "best_averages"."books_returned"="tmp"."books_returned";
END;

CREATE TRIGGER "best_averages_on_sbcrbrs_upd_del"
AFTER UPDATE OR DELETE
ON "subscribers"
BEGIN 
MERGE INTO "best_averages"
USING 
(
WITH    "20+_group"
AS  (   SELECT "sb_subscriber", COUNT("sb_id")
        FROM "subscriptions"
        WHERE "sb_is_active"= 'N'
        GROUP BY "sb_subscriber"      
        HAVING COUNT("sb_id") > 1
    ),
        "quick_readers"
AS  (   SELECT "sb_subscriber", MAX("sb_finish"-"sb_start") "max_days"
        FROM "subscriptions"
        WHERE "sb_is_active"='N'
        GROUP BY "sb_subscriber"
        HAVING MAX("sb_finish"-"sb_start")<50
    ),
        "sbcrbs_wo_delays"
AS (    SELECT DISTINCT "sb_subscriber"
        FROM "subscriptions"
        WHERE "sb_subscriber" NOT IN (  SELECT DISTINCT "sb_subscriber"
                                        FROM "subscriptions"
                                        WHERE "sb_is_active"='Y' AND
                                            CURRENT_DATE>"sb_finish"
                                        OR "sb_subscriber" NOT IN 
                                            (   SELECT "sb_subscriber"
                                                FROM "subscriptions"
                                                WHERE "sb_is_active"='N'
                                                GROUP BY "sb_subscriber"    
                                            )
                                    )
    )
SELECT          ("active_count"/"subscribers_count") AS "books_taken",
                ("days_sum"/"books_count") AS "days_to_read",
                ("inactive_count"/"subscribers_wo_delays_count") AS "books_returned"
FROM    (   
            SELECT COUNT("sb_id")"active_count"
            FROM "subscriptions"
                JOIN "20+_group"
                    USING("sb_subscriber")
            WHERE "sb_is_active"='Y'
        )"tmp_active_count",
        (   
            SELECT COUNT("sb_subscriber")"subscribers_count"
            FROM "20+_group"
        )"tmp_subscribers_count",
        (
            SELECT SUM("sb_finish"-"sb_start")"days_sum"
            FROM "subscriptions"
                JOIN "quick_readers" USING("sb_subscriber")
            WHERE "sb_is_active"='N'
        )"tmp_days_sum",
        (   
            SELECT COUNT("sb_id")"books_count"
            FROM "subscriptions"
                JOIN "quick_readers" USING("sb_subscriber")
            WHERE "sb_is_active"='N'
        )"tmp_books_count",
        (   
            SELECT COUNT("sb_id")"inactive_count"
            FROM "subscriptions"
                JOIN("sbcrbs_wo_delays") USING("sb_subscriber")
            WHERE "sb_is_active"='N'
        )"tmp_inactive_count",
        (   
            SELECT COUNT("sb_subscriber")"subscribers_wo_delays_count"
            FROM "sbcrbs_wo_delays"
        )"tmp_subscribers_wo_delays_count"
        
)"tmp" ON (1=1)
WHEN MATCHED THEN UPDATE 
SET     "best_averages"."books_taken" = "tmp"."books_taken",
        "best_averages"."days_to_read" = "tmp"."days_to_read",
        "best_averages"."books_returned"="tmp"."books_returned";
END;


INSERT INTO     "subscriptions"
                ("sb_subscriber",
                "sb_book",
                "sb_start",
                "sb_finish",
                "sb_is_active")
    VALUES      (1,
                13,
                TO_DATE('2022-03-15','YYYY-MM-DD'),
                TO_DATE('2022-04-15','YYYY-MM-DD'),
                'Y')
    
UPDATE "subscriptions"
SET "sb_is_active"='Y'
WHERE "sb_id"=125
            
UPDATE "subscriptions"
SET "sb_is_active"='N'
WHERE "sb_id" IN (125,126)


DELETE "subscriptions"
WHERE "sb_id" IN (125,126)
            

INSERT INTO     "subscribers"
                ("s_name")
    VALUES      (N'testreader T.T.')
    
INSERT INTO     "subscriptions"
                ("sb_subscriber",
                "sb_book",
                "sb_start",
                "sb_finish",
                "sb_is_active")
    VALUES      (8,
                11,
                TO_DATE('2015-03-15','YYYY-MM-DD'),
                TO_DATE('2015-04-15','YYYY-MM-DD'),
                'N')    

DELETE "subscribers"
WHERE "s_id"=8

