CREATE OR REPLACE VIEW "subscribers_with_debt" 
AS
    WITH "step_1" AS (
        SELECT "sb_subscriber" AS "debtor(s)"
        FROM "subscriptions" 
        WHERE "sb_is_active" = 'Y'
        AND "sb_finish" < TRUNC(SYSDATE)
        ),
        "step_2" AS (
    SELECT  "debtor(s)",
            COUNT("sb_book") AS "books_in_use"
    FROM "step_1"
        JOIN "subscriptions"
            ON "step_1"."debtor(s)"="subscriptions"."sb_subscriber"
    WHERE "sb_is_active"='Y'
    GROUP BY "debtor(s)" 
    )
SELECT "s_name",
"books_in_use"
FROM "subscribers"
    JOIN "step_2"
        ON "subscribers"."s_id"="step_2"."debtor(s)"
GROUP BY "debtor(s)","s_name","books_in_use"

SELECT * FROM "subscribers_with_debt" 