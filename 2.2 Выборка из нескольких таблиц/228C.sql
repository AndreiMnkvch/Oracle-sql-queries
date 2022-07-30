WITH  "ranked" AS (
        SELECT "sb_subscriber",COUNT(DISTINCT "g_id")as "genres_count",
        RANK() OVER( ORDER BY COUNT(DISTINCT "g_id")DESC)"rank"
        FROM "subscriptions"
            JOIN "m2m_books_genres" ON "sb_book"="b_id"
        GROUP BY "sb_subscriber"
        )
SELECT "s_name"
FROM "subscribers"
    JOIN "ranked" ON "s_id"="ranked"."sb_subscriber"
WHERE "rank"=1