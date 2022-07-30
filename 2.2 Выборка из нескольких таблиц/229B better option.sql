WITH "prepared_data" AS (
        SELECT "s_id","s_name",("sb_finish"-"sb_start") AS "days",
        RANK() OVER( ORDER BY ("sb_finish"-"sb_start") DESC) AS "rank"
        FROM "subscribers"
                JOIN "subscriptions" ON "s_id"="sb_subscriber"
        WHERE "sb_is_active"='Y')
SELECT "s_id","s_name","days"
FROM "prepared_data"
WHERE "rank"=1