WITH "ranked" AS(
        SELECT "b_id",COUNT("g_id")"count_genres",RANK() OVER( ORDER BY COUNT("g_id")DESC)"rank"
        FROM "m2m_books_genres"
        GROUP BY "b_id"
),
    "subscribers_ready" AS(
    SELECT "sb_subscriber"
    FROM "subscriptions"
        JOIN "ranked" ON "sb_book"= "ranked"."b_id" 
    WHERE "rank"=1
)
SELECT DISTINCT "s_id","s_name"
FROM "subscribers"
    JOIN "subscribers_ready" 
    ON "subscribers"."s_id"="subscribers_ready"."sb_subscriber"