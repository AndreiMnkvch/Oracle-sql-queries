SELECT DISTINCT "b_name"
FROM "books"
    JOIN "subscriptions"
        ON "b_id" = "sb_subscriber"