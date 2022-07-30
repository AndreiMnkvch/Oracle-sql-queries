DELETE FROM "subscriptions"
WHERE EXTRACT(DAY FROM "sb_start")> 20