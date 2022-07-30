SELECT DISTINCT "sb_subscriber","b_id","b_name"
FROM "subscriptions", "books"
WHERE "b_id" != "sb_book"