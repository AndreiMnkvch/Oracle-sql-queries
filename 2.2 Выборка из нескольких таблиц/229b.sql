SELECT "s_id","s_name",("sb_finish"-"sb_start") AS "days"
FROM "subscribers"
    JOIN "subscriptions" ON "s_id"="sb_subscriber"
WHERE "sb_is_active"='Y'
AND ("sb_finish"-"sb_start")=(SELECT "max_days"
                              FROM (SELECT ("sb_finish"-"sb_start") AS "max_days",
                                            RANK() OVER( ORDER BY ("sb_finish"-"sb_start") DESC) AS "rank"
                                    FROM "subscriptions"
                                    WHERE "sb_is_active" = 'Y')
                             WHERE "rank"=1)
                             