SELECT "sb_id", COUNT("sb_id")
FROM "subscriptions"
GROUP BY "sb_id"