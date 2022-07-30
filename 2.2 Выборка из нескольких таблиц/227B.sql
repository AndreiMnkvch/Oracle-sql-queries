WITH "prepared_data" AS(        
        SELECT COUNT("sb_book")AS "books_brought",
        "g_name" AS "genre",
        RANK() OVER( ORDER BY COUNT("sb_book") DESC) AS "rank"
        FROM "genres"
                JOIN "m2m_books_genres" USING("g_id")
                LEFT OUTER JOIN "subscriptions" ON "b_id"="sb_book"
        GROUP BY "g_id","g_name"
        )
SELECT "genre"
FROM "prepared_data"
WHERE "rank" = 1
