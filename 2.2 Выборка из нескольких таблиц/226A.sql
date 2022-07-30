SELECT "a_name"
FROM "authors"
WHERE "a_id" IN (
    SELECT "a_id"
    FROM "m2m_books_authors"
            JOIN "authors" USING("a_id")
    GROUP BY("a_id")
    HAVING(COUNT("b_id")>1))