SELECT "s_name" 
FROM "subscribers" 
WHERE "s_id" = (SELECT "sb_subscriber"
                FROM "subscriptions" 
                WHERE "sb_id" = (SELECT MAX("sb_id") 
                                 FROM "subscriptions"))