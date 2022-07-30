SELECT "sb_id","sb_start"
FROM "subscriptions"
WHERE "sb_start" < (SELECT ADD_MONTHS(TRUNC(MIN("sb_start"),'YEAR'),12)
                    FROM "subscriptions")
