ALTER TABLE "authors" 
ADD ( "a_last_taken" DATE DEFAULT NULL NULL);
-- Инициализация
UPDATE "authors" "outer"
SET "a_last_taken" = 
    (
        SELECT "last_taken"
        FROM "books"
        LEFT OUTER JOIN (SELECT   "sb_book",
                                MAX("sb_start") "last_taken"
                        FROM "subscriptions" 
                        GROUP BY "sb_book") "prepared_data"
        ON "b_id" = "sb_book"
        WHERE "outer"."b_id"="sb_book")
