WITH "step_1" 
    AS( SELECT "sb_subscriber", MAX("sb_start") AS "last_visit"
        FROM "subscriptions"
        GROUP BY "sb_subscriber"),
        
     "step_2" 
    AS (SELECT "subscriptions"."sb_subscriber", MAX("sb_id") AS "max_sb_id"
        FROM "subscriptions"
            JOIN "step_1"
                ON "subscriptions"."sb_subscriber"="step_1"."sb_subscriber"
                AND "subscriptions"."sb_start"="step_1"."last_visit"
        GROUP BY "subscriptions"."sb_subscriber","last_visit"),
        
        "step_3"     
    AS( SELECT "subscriptions"."sb_subscriber","sb_book"
        FROM "subscriptions"
            JOIN "step_2"
                ON "subscriptions"."sb_id"="step_2"."max_sb_id")
        
SELECT "b_name","s_name"
FROM "step_3"
    JOIN "books" 
        ON "sb_book"="b_id"
    JOIN "subscribers" 
        ON "sb_subscriber"="s_id"