SELECT "book","author(s)",
        UTL_RAW.CAST_TO_NVARCHAR2
        (
            LISTAGG
            (   UTL_RAW.CAST_TO_RAW("g_name"),
                UTL_RAW.CAST_TO_RAW(N', ')
            )
            WITHIN GROUP (ORDER BY "g_name")
        )
        AS "genre(s)"
FROM (
        SELECT "b_id","b_name" AS "book",
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
    ) "book_author(s)_ready"
            
JOIN "m2m_books_genres" USING("b_id")
JOIN "genres" USING("g_id")
GROUP BY "b_id",
        "book",
        "author(s)"

