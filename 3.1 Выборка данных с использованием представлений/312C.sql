DROP MATERIALIZED VIEW "authors_and_their_books";
CREATE MATERIALIZED VIEW "authors_and_their_books"
BUILD IMMEDIATE
REFRESH FORCE 
START WITH (SYSDATE) NEXT ( SYSDATE +1/1440) AS 
    SELECT "a_name",
            UTL_RAW.CAST_TO_NVARCHAR2
            (
            LISTAGG (
                        UTL_RAW.CAST_TO_RAW("b_name"),
                        UTL_RAW.CAST_TO_RAW(N', ')
                    )
            WITHIN GROUP (ORDER BY("b_name"))
            ) AS "book(s)"
    FROM "authors"
            JOIN "m2m_books_authors"
                    USING ("a_id")
            JOIN "books"
                USING ("b_id")
    GROUP BY("a_id","a_name");

SELECT * FROM "authors_and_their_books"
