SELECT "b_name"
FROM  (SELECT "b_id",
        COUNT("a_id")
FROM "m2m_books_authors"
GROUP BY "b_id"
HAVING COUNT("a_id")>1)
        JOIN "books" USING("b_id")
