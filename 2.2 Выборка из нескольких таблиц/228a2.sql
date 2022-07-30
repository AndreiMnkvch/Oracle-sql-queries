WITH "prepared_data" AS (
        SELECT DISTINCT "a_id", "g_id"
        FROM "m2m_books_genres" 
            JOIN "m2m_books_authors" USING ("b_id")
            )
            
SELECT "a_id", "a_name", COUNT("g_id") AS "genres_count" 
FROM "prepared_data"     
    JOIN "authors" USING ("a_id")
GROUP BY "a_id", "a_name"
HAVING COUNT("g_id") > 1