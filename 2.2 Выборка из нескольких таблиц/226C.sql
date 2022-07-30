SELECT "sb_subscriber"
FROM "subscriptions"
WHERE "sb_is_active" ='Y'
GROUP BY "sb_subscriber"
HAVING COUNT("sb_book")>1