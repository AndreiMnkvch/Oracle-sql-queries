WITH "prepared_data"
    AS( SELECT "sb_subscriber",
                COUNT("sb_finish")"books_read"
       FROM "subscriptions"
       GROUP BY "sb_subscriber"),
        "ranked" 
    AS (SELECT "sb_subscriber",
                "books_read",
                RANK() OVER(ORDER BY "books_read" DESC) AS "rank"
        FROM "prepared_data"),
        "counted"
    AS (SELECT "rank",
                COUNT(*) AS "competitors"
        FROM "ranked"
        GROUP BY "rank")
        
SELECT "sb_subscriber"
FROM "ranked"
    JOIN "counted"
        ON "ranked"."rank"="counted"."rank"
WHERE "counted"."rank" = 1
AND "counted"."competitors" = 1
        

