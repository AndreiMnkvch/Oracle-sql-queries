SELECT MIN("sb_start") AS "first_visit",
        MAX("sb_start") AS "last visit" 
FROM "subscriptions"
GROUP BY "sb_subscriber"
ORDER BY "first_visit" DESC