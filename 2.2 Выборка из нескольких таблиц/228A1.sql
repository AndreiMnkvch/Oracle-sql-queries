WITH "prepared_data" AS(
        SELECT "a_id", "a_name", COUNT("g_id") AS "genres_count"
        FROM "authors" 
            JOIN "m2m_books_authors" USING ("a_id")
            JOIN "m2m_books_genres" USING ("b_id")
        GROUP BY "a_id", "a_name", "b_id"
        HAVING COUNT("g_id") > 1) 
SELECT "a_id", "a_name", MAX("genres_count") AS "genres_count"
FROM "prepared_data"
GROUP BY "a_id", "a_name"