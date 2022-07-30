SELECT
    "b_id",
    "b_name"
FROM "books"
      JOIN "m2m_books_authors" USING("b_id")
WHERE "a_id" IN (SELECT "a_id"
                FROM "authors"
                WHERE "a_name" IN(N'Alexander Pushkin', N'Isaac Asimov'))