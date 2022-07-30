CREATE VIEW "subscriptions_with_day_of_the_week" AS 
SELECT "sb_id",
        "sb_subscriber",
        "sb_book",
        TO_CHAR("sb_start",  'YYYY-MM-DD-Day') || ' ' || TO_CHAR("sb_finish", 'YYYY-MM-DD-Day') AS "dates"
FROM "subscriptions" ;

DROP VIEW "subscriptions_with_day_of_the_week";


SELECT * FROM "subscriptions_with_day_of_the_week";