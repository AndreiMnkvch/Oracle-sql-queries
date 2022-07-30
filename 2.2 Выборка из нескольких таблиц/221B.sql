SELECT "b_name"
FROM  (SELECT "b_id",
        COUNT("g_id")
FROM "m2m_books_genres"
GROUP BY "b_id"
HAVING COUNT("g_id")=1)
        JOIN "books" USING("b_id")