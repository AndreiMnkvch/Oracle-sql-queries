WITH "prepared_data" AS(
        SELECT "a_id",SUM("b_quantity")AS "books"
        FROM "authors"
                JOIN "m2m_books_authors" USING("a_id")
                JOIN "books" USING("b_id")
        GROUP BY "a_id"
        ORDER BY "a_id"
        )
SELECT "a_id","books","a_name"
FROM "prepared_data"
    JOIN "authors" USING("a_id")
