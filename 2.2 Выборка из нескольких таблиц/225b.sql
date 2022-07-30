WITH "prepared_data" AS(
    SELECT "b_id"
    FROM "m2m_books_authors"
            JOIN "books" USING("b_id")
    WHERE "a_id" IN (SELECT "a_id"
                     FROM "authors"
                     WHERE "a_name" IN ( N'Dale Carnegie','Bjarne Stroustrup'))
    GROUP BY "b_id"
    HAVING COUNT("a_id")>1)
SELECT "b_name"
FROM "books"
    JOIN "prepared_data" USING("b_id")