WITH "books_taken" 
    AS(
        SELECT "sb_book"
        FROM "subscriptions"
        WHERE "sb_is_active"='Y'
    ),
    "real_taken"
    AS( 
        SELECT "b_id",
                COUNT("sb_book")"taken"
        FROM "books"
                LEFT OUTER JOIN "books_taken" ON "b_id" = "sb_book"
        GROUP BY "b_id"
    )
SELECT "b_id","b_name",
    (SELECT "taken"
    FROM "real_taken"
    WHERE "books"."b_id" = "real_taken"."b_id")"real_count"
FROM "books"