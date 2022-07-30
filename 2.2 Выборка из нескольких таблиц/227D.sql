WITH "prepared_data" AS(
SELECT COUNT("sb_book")AS "books_brought",
"g_name" AS "genre"
FROM "genres"
        JOIN "m2m_books_genres" USING("g_id")
        LEFT OUTER JOIN "subscriptions" ON "b_id"="sb_book"
GROUP BY "g_id","g_name"
)
SELECT MEDIAN("books_brought")
FROM "prepared_data"