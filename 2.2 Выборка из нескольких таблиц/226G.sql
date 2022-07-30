WITH "step1" AS (
SELECT "sb_subscriber",COUNT("sb_book")AS "not_returned"
FROM "subscriptions"
WHERE "sb_is_active"='Y'
GROUP BY "sb_subscriber"
)
SELECT "not_returned","sb_subscriber","s_name"
FROM "step1"
    JOIN "subscribers" ON "sb_subscriber"="s_id"
    