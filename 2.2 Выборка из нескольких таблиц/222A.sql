SELECT "b_name" AS "book",
        UTL_RAW.CAST_TO_NVARCHAR2
        (
            LISTAGG
            (   UTL_RAW.CAST_TO_RAW("a_name"),
                UTL_RAW.CAST_TO_RAW(N', ')
            )
            WITHIN GROUP (ORDER BY "a_name")
        )
        AS "author(s)"
FROM "books"
        JOIN "m2m_books_authors" USING("b_id")
        JOIN "authors" USING("a_id")
GROUP BY "b_id","b_name" 
