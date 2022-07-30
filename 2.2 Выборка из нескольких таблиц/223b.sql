SELECT "b_name"
FROM "books"
    LEFT OUTER JOIN "subscriptions"
        ON "b_id" = "sb_book" 
WHERE "subscriptions"."sb_book" IS NULL