SELECT "s_name","sb_start"
FROM "subscriptions"
        JOIN "subscribers"
            ON "sb_subscriber"="s_id"
            