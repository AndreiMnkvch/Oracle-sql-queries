SELECT "s_name"
FROM "subscribers"
  LEFT OUTER JOIN "subscriptions"
        ON "s_id" = "sb_subscriber"
WHERE "sb_subscriber" IS NULL
        
        