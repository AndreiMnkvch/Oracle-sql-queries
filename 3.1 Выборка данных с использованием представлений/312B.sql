DROP MATERIALIZED VIEW "books_and_its_genres";
CREATE MATERIALIZED VIEW "books_and_its_genres"
BUILD IMMEDIATE
REFRESH FORCE 
START WITH (SYSDATE) NEXT ( SYSDATE +1/1440) AS 
    SELECT "b_name",
            UTL_RAW.CAST_TO_NVARCHAR2
            (
            LISTAGG (
                        UTL_RAW.CAST_TO_RAW("g_name"),
                        UTL_RAW.CAST_TO_RAW(N', ')
                    )
            WITHIN GROUP (ORDER BY("g_name"))
            ) AS "genre(s)"
    FROM "books"
            JOIN "m2m_books_genres"
                    USING ("b_id")
            JOIN "genres"
                USING ("g_id")
    GROUP BY("b_id","b_name");

SELECT * FROM "books_and_its_genres"
