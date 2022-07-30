WITH "step1" AS (
        SELECT "sb_subscriber", MIN("sb_start") AS "last_visit"
        FROM "subscriptions"
        GROUP BY "sb_subscriber"),
        
    "step2" AS (
        SELECT "subscriptions"."sb_book",
        "subscriptions"."sb_subscriber"
        FROM "subscriptions"
                      JOIN "step1" 
                               ON "subscriptions"."sb_subscriber" = "step1"."sb_subscriber" AND 
        "subscriptions"."sb_start"="step1"."last_visit"),
        
    "step3" AS(
        SELECT "s_id","s_name","b_id","b_name"
        FROM "subscribers"
             JOIN "step2" 
                ON "s_id"="sb_subscriber"
             JOIN "books"
                ON "sb_book"="b_id")

SELECT "s_id","s_name",
          UTL_RAW.CAST_TO_NVARCHAR2
          (
            LISTAGG
            (
              UTL_RAW.CAST_TO_RAW("b_name"),
              UTL_RAW.CAST_TO_RAW(N', ')
             )
           WITHIN GROUP (ORDER BY "b_name")
           )
          AS "books_list"
FROM "step3"
GROUP BY "s_id","s_name"