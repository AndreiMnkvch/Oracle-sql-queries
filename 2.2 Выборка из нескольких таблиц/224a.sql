SELECT "b_name"
FROM "books"
WHERE "b_id" NOT IN (SELECT DISTINCT "sb_book"
                    FROM "subscriptions"
                    WHERE "sb_is_active" = 'Y')