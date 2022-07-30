SELECT AVG(TRUNC(SYSDATE)-MIN("sb_start"))
FROM "subscriptions"
GROUP BY "sb_subscriber"