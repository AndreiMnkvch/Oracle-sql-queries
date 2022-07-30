UPDATE "authors"
SET "a_name"= 
(SELECT 
    CASE 
        WHEN "x">2
            THEN (SELECT "a_name" || ' [' || '+' || ']' FROM "DUAL")
        ELSE (SELECT "a_name" || ' [' || '-' || ']' FROM "DUAL")
    END
FROM (  SELECT "a_id",
                COUNT("b_id")"x"
        FROM "authors"
                LEFT OUTER JOIN "m2m_books_authors"
                        USING("a_id")
        GROUP BY "a_id")"prepared_data"
WHERE "authors"."a_id"="prepared_data"."a_id")
            