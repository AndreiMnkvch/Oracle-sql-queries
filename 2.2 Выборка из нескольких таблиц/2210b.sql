SELECT "s_name","sb_start"
FROM "subscribers"
  LEFT OUTER JOIN "subscriptions"
        ON "s_id" = "sb_subscriber"
        
        