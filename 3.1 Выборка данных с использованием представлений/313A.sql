CREATE VIEW "subscriptions_without_book" AS
SELECT  "sb_id",
        "sb_subscriber",
        "sb_start",
        "sb_finish",
        "sb_is_active"
FROM "subscriptions"

SELECT * FROM "subscriptions_without_book";