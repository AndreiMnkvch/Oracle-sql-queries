WITH "prepared_data" AS(
    SELECT COUNT("sb_book") AS "books" 
    FROM "authors" JOIN "m2m_books_authors" USING ("a_id")
    LEFT OUTER JOIN "subscriptions" ON "m2m_books_authors"."b_id" = "sb_book"
    GROUP BY "a_id") 
SELECT AVG("books") AS "avg_reading"
FROM "prepared_data"   