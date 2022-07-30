SELECT "b_name"
FROM "books"
WHERE "b_quantity" < (SELECT AVG("b_quantity")
                        FROM "books")