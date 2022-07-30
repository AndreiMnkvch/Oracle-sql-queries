SELECT "b_name"
FROM "books"
WHERE "b_id" IN (
    SELECT "b_id"
    FROM "m2m_books_genres"
    GROUP BY("b_id")
    HAVING(COUNT("g_id")>1))