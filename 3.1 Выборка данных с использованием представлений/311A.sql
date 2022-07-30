CREATE OR REPLACE VIEW "authors_w_2_or_more_genres"
    AS
    SELECT "a_id", 
            "a_name", 
            COUNT("g_id") AS "genres_count" 
    FROM (  SELECT DISTINCT "a_id", "g_id" 
            FROM "m2m_books_genres" 
                JOIN "m2m_books_authors" 
                    USING ("b_id") ) "prepared_data" 
        JOIN "authors" 
            USING ("a_id") 
    GROUP BY "a_id", "a_name" 
    HAVING COUNT("g_id") > 1